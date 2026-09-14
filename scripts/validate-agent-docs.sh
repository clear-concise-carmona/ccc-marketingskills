#!/usr/bin/env bash
# Validate the Aliens of Brooklyn agent documentation in this repo.
#
# Checks:
#   1. Required client files exist.
#   2. Relative markdown links in client docs resolve to real files.
#   3. Client context files carry a version line.
#   4. No em-dashes in client docs (owner writing rule).
#   5. No credential-looking strings or .env files anywhere in tracked files.
#   6. No obvious customer-data artifacts (loose CSV exports) staged for commit.
#
# Usage: scripts/validate-agent-docs.sh
# Exit code 0 on pass, 1 on any error. Warnings do not fail the run.

set -u

cd "$(dirname "$0")/.." || exit 1

ERRORS=0
WARNINGS=0

pass() { printf '  \342\234\223 %s\n' "$1"; }
fail() { printf '  \342\234\227 %s\n' "$1"; ERRORS=$((ERRORS + 1)); }
warn() { printf '  ! %s\n' "$1"; WARNINGS=$((WARNINGS + 1)); }

CLIENT_DOCS=(
  "AGENTS.md"
  "CLAUDE.md"
  ".agents/README.md"
  ".agents/product-marketing.md"
  ".agents/aliens-of-brooklyn-brand-context.md"
  ".agents/ecommerce-marketing-context.md"
  "docs/source-of-truth.md"
  "docs/claims-and-disclaimers.md"
  "docs/agent-workflows.md"
)

# Files where the no-em-dash rule is enforced. AGENTS.md and README.md carry
# upstream text that uses em-dashes, so only the client-authored files are checked.
NO_EMDASH_DOCS=(
  "CLAUDE.md"
  ".agents/README.md"
  ".agents/product-marketing.md"
  ".agents/aliens-of-brooklyn-brand-context.md"
  ".agents/ecommerce-marketing-context.md"
  "docs/source-of-truth.md"
  "docs/claims-and-disclaimers.md"
  "docs/agent-workflows.md"
)

echo "Validating Aliens of Brooklyn agent docs"
echo "========================================"

echo
echo "1. Required files"
for f in "${CLIENT_DOCS[@]}" "scripts/validate-agent-docs.sh"; do
  if [[ -f "$f" ]]; then pass "$f"; else fail "missing: $f"; fi
done
if [[ -L "CLAUDE.md" ]]; then
  fail "CLAUDE.md is a symlink; this fork expects a real file (see CLAUDE.md maintainer note)"
fi

echo
echo "2. Relative links in client docs"
LINK_ERRORS=0
for f in "${CLIENT_DOCS[@]}" "README.md"; do
  [[ -f "$f" ]] || continue
  dir=$(dirname "$f")
  # Extract markdown link targets: [text](target)
  while IFS= read -r target; do
    [[ -z "$target" ]] && continue
    case "$target" in
      http://*|https://*|mailto:*|\#*) continue ;;
    esac
    path="${target%%#*}"
    [[ -z "$path" ]] && continue
    # Resolve relative to the containing document only; no repo-root fallback.
    if [[ ! -e "$dir/$path" ]]; then
      fail "$f links to missing path: $target (resolved from $dir/)"
      LINK_ERRORS=$((LINK_ERRORS + 1))
    fi
  done < <(grep -o '\]([^)]*)' "$f" | sed 's/^](//; s/)$//' | sort -u)
done
[[ $LINK_ERRORS -eq 0 ]] && pass "all relative links resolve"

echo
echo "3. Version lines in context files"
for f in ".agents/product-marketing.md" ".agents/aliens-of-brooklyn-brand-context.md"; do
  [[ -f "$f" ]] || continue
  if grep -qiE '^\*\*(Document version|Status):\*\*' "$f"; then
    pass "$f has a version or status line"
  else
    fail "$f is missing a **Document version:** or **Status:** line"
  fi
done

echo
echo "4. Em-dashes in client-authored docs"
EMDASH=0
for f in "${NO_EMDASH_DOCS[@]}"; do
  [[ -f "$f" ]] || continue
  if grep -n $'\xe2\x80\x94' "$f" >/dev/null; then
    fail "$f contains em-dashes:"
    grep -n $'\xe2\x80\x94' "$f" | head -5 | sed 's/^/      /'
    EMDASH=1
  fi
done
# Client-authored sections inside upstream files are checked by heading range.
check_section_emdash() {
  local file="$1" start="$2" end="$3"
  [[ -f "$file" ]] || return 0
  if awk -v s="$start" -v e="$end" 'index($0,s)==1{f=1} f&&index($0,e)==1&&NR>1&&$0!=s{f=0} f' "$file" | grep -n $'\xe2\x80\x94' >/dev/null; then
    fail "$file client section (from '$start') contains em-dashes"
    EMDASH=1
  fi
}
check_section_emdash "AGENTS.md" "## Aliens of Brooklyn: Client Working Agreement" "## Marketing Skills Library Guidelines (upstream)"
check_section_emdash "README.md" "## This fork: Aliens of Brooklyn" "## Partners"
[[ $EMDASH -eq 0 ]] && pass "no em-dashes found (client docs and client sections of AGENTS.md and README.md)"

echo
echo "5. Credentials and secrets"
SECRET_PATTERN='shpat_[A-Za-z0-9]{8,}|shpca_[A-Za-z0-9]{8,}|shpss_[A-Za-z0-9]{8,}|sk_live_[A-Za-z0-9]{8,}|sk_test_[A-Za-z0-9]{8,}|AKIA[0-9A-Z]{16}|xox[baprs]-[A-Za-z0-9-]{10,}|ghp_[A-Za-z0-9]{20,}|AIza[0-9A-Za-z_-]{30,}|-----BEGIN (RSA |EC |OPENSSH )?PRIVATE KEY-----'
SELF='scripts/validate-agent-docs.sh'

# Report file:line only. The matched value is never printed, so a real credential
# does not get copied into logs or agent transcripts.
report_hits() {
  local label="$1" hits="$2"
  fail "credential-looking strings in $label (values redacted):"
  printf '%s\n' "$hits" | awk -F: '{print "      " $1 ":" $2 ": [REDACTED]"}' | head -10
}

if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  # git grep handles any filename (spaces included) and reports errors distinctly:
  # exit 0 = matches, 1 = clean, 2+ = scan error. Two passes: working tree
  # (tracked plus untracked, ignoring gitignored files) and the staged index,
  # so a token that is staged but removed from the working copy is still caught.
  scan_git() {
    local label="$1"; shift
    local out rc
    out=$(git grep -nIoE "$@" -e "$SECRET_PATTERN" -- . ":!$SELF" 2>&1); rc=$?
    if [[ $rc -ge 2 ]]; then
      fail "credential scan failed for $label: $out"
    elif [[ $rc -eq 0 ]]; then
      report_hits "$label" "$out"
    else
      pass "no credential-looking strings in $label"
    fi
  }
  scan_git "working tree (tracked and untracked files)" --untracked
  scan_git "staged index" --cached
  TRACKED=$(git ls-files --cached --others --exclude-standard)
else
  # Outside git: null-delimited paths so spaces in filenames are preserved.
  # xargs returns 123 for both "no match" and "grep hit a read error", so stderr
  # is captured separately: any stderr output means the scan was incomplete.
  errfile=$(mktemp)
  out=$(find . -type f -not -path './.git/*' -not -path './node_modules/*' -not -path "./$SELF" -print0 \
        | xargs -0 grep -nIoE "$SECRET_PATTERN" 2>"$errfile"); rc=$?
  if [[ -s "$errfile" ]]; then
    fail "credential scan incomplete (files could not be read):"
    sed 's/^/      /' "$errfile" | head -5
  elif [[ $rc -eq 0 ]]; then
    report_hits "working tree" "$out"
  elif [[ $rc -eq 1 || $rc -eq 123 ]]; then
    pass "no credential-looking strings in working tree"
  else
    fail "credential scan failed (exit $rc)"
  fi
  rm -f "$errfile"
  TRACKED=$(find . -type f -not -path './.git/*' -not -path './node_modules/*' | sed 's|^\./||')
fi
ENVFILES=$(echo "$TRACKED" | grep -E '(^|/)\.env(\..*)?$' | grep -v '\.env\.example$' || true)
if [[ -n "$ENVFILES" ]]; then
  fail ".env files are tracked: $ENVFILES"
else
  pass "no .env files tracked"
fi

echo
echo "6. Customer-data artifacts"
LOOSE_CSV=$(echo "$TRACKED" | grep -E '\.csv$' | grep -vE '^(skills|tools)/' || true)
if [[ -n "$LOOSE_CSV" ]]; then
  fail "CSV files outside skills/ and tools/ are tracked (possible exports): $LOOSE_CSV"
else
  pass "no loose CSV files tracked"
fi
# Placeholder emails are fine; anything else in client docs gets a warning for a human to check.
EMAILS=$(grep -hoEI '[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}' "${CLIENT_DOCS[@]}" 2>/dev/null | sort -u | grep -vE '^(aliensofbrooklyn@gmail\.com|alex@example\.com|noreply@anthropic\.com)$' || true)
if [[ -n "$EMAILS" ]]; then
  warn "email addresses in client docs to double-check: $(echo "$EMAILS" | tr '\n' ' ')"
else
  pass "only the brand contact and placeholder emails appear in client docs"
fi

echo
echo "========================================"
if [[ $ERRORS -eq 0 ]]; then
  echo "PASS ($WARNINGS warning(s))"
  exit 0
else
  echo "FAIL: $ERRORS error(s), $WARNINGS warning(s)"
  exit 1
fi
