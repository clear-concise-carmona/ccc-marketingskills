# AGENTS.md

Guidelines for AI agents working in this repository.

This fork is configured for one client: **Aliens of Brooklyn**. The first section is the client working agreement and applies to Codex, Claude Code, Cursor, and any other agent. The sections after it are the upstream Marketing Skills library guidelines and still apply when editing skills or tools. Claude Code also reads `CLAUDE.md`.

## Aliens of Brooklyn: Client Working Agreement (read first)

### What this repo is for

Marketing Skills gives coding agents 50 marketing skills (`skills/*/SKILL.md`). This fork points them at Aliens of Brooklyn's ecommerce growth: product and collection pages, SEO, conversion, email and SMS, social, ads, merchandising, launches, and campaign planning. Claude Code implements; OpenAI Codex reviews.

### Client context in one paragraph

Aliens of Brooklyn (https://www.aliensofbrooklyn.com) is, in its own words on its FAQ, a "queer-owned 90s and Y2K pop culture streetwear brand born in Crown Heights, Brooklyn in 2012." It sells pop culture tees, sweatshirts, baby tees, totes, magnets, and mugs, plus Choose Your Word dad hats ($35) and beanies ($25) made in New York City, and fully custom caps and shirts ($45) where the buyer emails or DMs the word or image after purchase. Custom items are final sale. Two stores: 304 E 5th St, New York, NY 10003 (East Village) and 1630 E 6th St #104, Austin, TX 78702 (East Austin). Walk-in custom printing at the NYC store. Full facts with source tags: `.agents/aliens-of-brooklyn-brand-context.md`. Prices and policies change; verify on the live page before quoting.

### Source of truth hierarchy

1. Owner-approved brand materials shared by the owners.
2. The official website.
3. Official Instagram and other official channels, only when provided or clearly verified.
4. This repo's existing documentation.
5. Claude and OpenAI cookbook conventions.
6. Third-party press and interviews, labeled as supporting context.
7. Agent inference, labeled `[ASSUMPTION]` and never published.

One carve-out: owner materials set positioning, voice, and history, but they cannot override a price, policy, address, or product spec printed on the live site. When the two disagree on those, the site wins and the owner document is treated as outdated. Rules for conflicts, tags, and requests for missing information: `docs/source-of-truth.md`.

### Client files in this repo

```
.agents/
├── README.md                              # How to use this directory
├── product-marketing.md                   # Short context every skill reads first
├── aliens-of-brooklyn-brand-context.md    # Durable brand and product facts, tagged by source
└── ecommerce-marketing-context.md         # Channel-by-channel operating rules
docs/
├── source-of-truth.md                     # Source hierarchy, conflicts, privacy boundaries
├── claims-and-disclaimers.md              # What may be claimed; review checklist
└── agent-workflows.md                     # Step-by-step task workflows
scripts/
└── validate-agent-docs.sh                 # Doc validation (links, tags, secrets, em-dashes)
CLAUDE.md                                  # Claude Code specifics
```

### Agent operating rules

- Read `.agents/product-marketing.md` before any marketing task. Read `.agents/aliens-of-brooklyn-brand-context.md` and `docs/claims-and-disclaimers.md` before writing customer-facing copy.
- Verify every product fact on the live page the day you use it. Record the URL and date.
- Drafts only. Nothing is published, sent, or applied to the store without owner approval per item. If a connector is available, writes require an explicit instruction naming the item.
- Mark what you cannot verify: `[CLIENT REVIEW]` for facts needing owner sign-off, `[ASSUMPTION]` for inference. Never remove a tag to make a draft look done.
- Batch open questions at the end of the task. Do not fill gaps with plausible answers.
- Prefer small, reviewable changes. One product, one collection, one flow per branch when practical.
- Do not copy competitor wording. Study patterns only.

### Build, test, and validation commands

```bash
scripts/validate-agent-docs.sh        # Client docs: required files, relative links, tags, secrets, em-dashes
./validate-skills.sh                  # Skill frontmatter and structure (only when a SKILL.md changes)
node --check tools/clis/<name>.js     # CLI syntax (only when a tool changes)
```

There is no build step. Skills and docs are markdown.

### Documentation rules

- Client docs use plain markdown, H2 and H3 headings, short paragraphs, tables for facts.
- No em-dashes anywhere in client docs or copy (owner writing rule). Use periods, commas, or colons.
- Every fact that can change (price, policy, address, menu word) carries a source tag and, where useful, a verification date.
- Context files carry a version and change log; bump on any substantive change.
- Keep `.agents/product-marketing.md` short. Detail goes in the brand context file.
- Do not edit upstream skill files to add client specifics. Client context stays in `.agents/` and `docs/`.

### Marketing skill usage rules

- Use the skill that matches the task (table in `CLAUDE.md`; workflows in `docs/agent-workflows.md`).
- Skills that touch data (`analytics`, `attribution`) run on aggregated or sanitized inputs only.
- Skills that produce ads (`ads`, `ad-creative`) draft concepts; agents never access ad accounts.
- Skills that produce outreach (`public-relations`, `influencer-marketing`, `cold-email`) produce drafts with every name and claim tagged for review.
- `product-marketing` updates go to `.agents/product-marketing.md` with a version bump.

### Ecommerce copy rules

- Product description order: hook, benefit, details, vibe, CTA.
- Preserve materials, sizes, care, turnaround, custom order steps, made-in claims, and "final sale" on custom items. Remove supplier boilerplate.
- SEO title `Product | Aliens of Brooklyn` under 60 characters; meta description under 160; alt text under 125.
- No discount, code, threshold, delivery date, carrier, exchange, or free-return language unless the owners confirm it.
- No store hours. No "grand opening." Soft opening language only.
- Full rules: `.agents/ecommerce-marketing-context.md`.

### Brand consistency rules

- Voice: fun, cheeky, playful, inclusive; bold and nostalgic; short sentences; 90s and Y2K references; space and alien metaphors in moderation; one or two emoji at most and none in policy text.
- Inclusive by default. Never exclude, mock, or single out anyone.
- Provocative or explicit slogans: only those already on the site or approved in writing.
- Celebrity, character, and franchise references: only existing product titles; never imply endorsement or partnership.
- Visual system is in transition; confirm with the owners before design work. No hex codes in customer copy.

### File editing rules

- Branch names: `docs/<topic>`, `content/<topic>`, `seo/<topic>`, or the upstream patterns for skill work.
- Conventional Commits (`docs:`, `feat:`, `fix:`).
- Do not overwrite or restructure upstream files (`README.md` sections below the client section, `skills/`, `tools/`, `VERSIONS.md`, `.claude-plugin/`) without stating what exists and why the change is needed.
- Do not bump the repo release version or `VERSIONS.md` for client-doc changes; those track skill changes only.
- Deliverables (rewritten copy, audits, campaign drafts) are returned to the owners, not committed here, unless they document how to do the work.

### Security and privacy rules

- Never commit or write credentials: Shopify tokens, API keys, ad platform tokens, email platform keys, analytics IDs, `.env` files. Use `{{PLACEHOLDER}}`.
- Never store, summarize, or restate customer data: names, emails, phones, addresses, orders, payments, analytics exports. Aggregates for a specific task stay in that task's deliverable.
- Fabricated examples only: "Alex Example," "alex@example.com," "order #1001."
- If real data or a credential appears by mistake, stop, say so, and do not process it.
- `.gitignore` excludes `.env*`, loose CSVs, `data/`, and `exports/`. Do not work around it.

### Client review checklist

Before handing off, paste the checklist in `docs/claims-and-disclaimers.md` section 12 and check every line. Short form:

- [ ] Facts verified on the live page today; prices re-checked.
- [ ] Custom steps, turnaround, and final sale intact.
- [ ] No new third-party names, endorsements, discounts, hours, guarantees, or superlatives.
- [ ] No customer data, credentials, or internal metrics.
- [ ] Every `[CLIENT REVIEW]` and `[ASSUMPTION]` listed in the handoff.
- [ ] `scripts/validate-agent-docs.sh` passes.

### Definition of done

A task is done when the deliverable is drafted in the brand voice with every fact sourced, the open questions are batched, the checklist is complete, validation passes, a second agent (Codex) has reviewed it against this file and the claims file, and the handoff summary is written. Publishing is the owners' step, not the agent's.

### Codex review guidelines (priority order)

1. Any customer data, credential, or internal metric in a file or diff. Blocker.
2. Any claim in `docs/claims-and-disclaimers.md` section 4 (endorsement, guarantee, invented material, fake social proof). Blocker.
3. Product facts that do not match the live page or the brand context file.
4. Missing or removed `[CLIENT REVIEW]` and `[ASSUMPTION]` tags.
5. Voice violations: em-dashes, corporate language, more than two emoji, exclusionary copy.
6. Broken relative links, wrong skill names, missing handoff summary.

---

## Marketing Skills Library Guidelines (upstream)

## Repository Overview

This repository contains **Agent Skills** for AI agents following the [Agent Skills specification](https://agentskills.io/specification.md). Skills install to `.agents/skills/` (the cross-agent standard). This repo also serves as a **Claude Code plugin marketplace** via `.claude-plugin/marketplace.json`.

- **Name**: Marketing Skills
- **GitHub**: [coreyhaines31/marketingskills](https://github.com/coreyhaines31/marketingskills)
- **Creator**: Corey Haines
- **License**: MIT

## Repository Structure

```
marketingskills/
├── .agents/               # Client context files (tracked) and installed skills (ignored)
├── .claude-plugin/
│   └── marketplace.json   # Claude Code plugin marketplace manifest
├── docs/                  # Client governance: source of truth, claims, workflows
├── scripts/               # sync-partners.mjs (upstream), validate-agent-docs.sh (client docs)
├── skills/                # Agent Skills
│   └── skill-name/
│       └── SKILL.md       # Required skill file
├── tools/
│   ├── clis/              # Zero-dependency Node.js CLI tools (51 tools)
│   ├── composio/          # Composio integration layer (quick start + toolkit mapping)
│   ├── integrations/      # API integration guides per tool
│   └── REGISTRY.md        # Tool index with capabilities
├── AGENTS.md              # This file
├── CLAUDE.md              # Claude Code specifics (real file in this fork, symlink upstream)
├── CONTRIBUTING.md
├── LICENSE
└── README.md
```

## Build / Lint / Test Commands

**Skills** are content-only (no build step). Verify manually:
- YAML frontmatter is valid
- `name` field matches directory name exactly
- `name` is 1-64 chars, lowercase alphanumeric and hyphens only
- `description` is 1-1024 characters

**CLI tools** (`tools/clis/*.js`) are zero-dependency Node.js scripts (Node 18+). Verify with:
```bash
node --check tools/clis/<name>.js   # Syntax check
node tools/clis/<name>.js           # Show usage (no args = help)
node tools/clis/<name>.js <cmd> --dry-run  # Preview request without sending
```

## Versioning

Two version layers, with different rules:

**Repo release version** — `.claude-plugin/plugin.json` `version`, `.claude-plugin/marketplace.json` `metadata.version`, and the `VERSIONS.md` changelog headings all share one x.y.z number:

- **x** — repo-wide changes (restructures, spec changes, breaking changes)
- **y** — new skill(s) added
- **z** — updates to existing skills

Do not bump y for content added to an existing skill, no matter how substantial — that's a z release (e.g. a new reference file in ad-creative is 2.8.0 → 2.8.1, not 2.9.0).

**Per-skill version** — `metadata.version` in each SKILL.md, mirrored in the `VERSIONS.md` table. Bump on ANY shipped change to that skill: the update check compares `VERSIONS.md` against users' local skill metadata, so an unbumped change is invisible to installed users. Minor for new capability or description triggers, patch for fixes and clarifications.

Bump the repo release version in the same PR that ships the change (2.7.0 and 2.8.0 shipped without touching plugin.json/marketplace.json and needed a catch-up later).

## Agent Skills Specification

Skills follow the [Agent Skills spec](https://agentskills.io/specification.md).

### Required Frontmatter

```yaml
---
name: skill-name
description: What this skill does and when to use it. Include trigger phrases.
---
```

### Frontmatter Field Constraints

| Field         | Required | Constraints                                                      |
|---------------|----------|------------------------------------------------------------------|
| `name`        | Yes      | 1-64 chars, lowercase `a-z`, numbers, hyphens. Must match dir.   |
| `description` | Yes      | 1-1024 chars. Describe what it does and when to use it.          |
| `license`     | No       | License name (default: MIT)                                      |
| `metadata`    | No       | Key-value pairs (author, version, etc.)                          |

### Name Field Rules

- Lowercase letters, numbers, and hyphens only
- Cannot start or end with hyphen
- No consecutive hyphens (`--`)
- Must match parent directory name exactly

**Valid**: `cro`, `emails`, `ab-testing`
**Invalid**: `Page-CRO`, `-page`, `page--cro`

### Optional Skill Directories

```
skills/skill-name/
├── SKILL.md        # Required - main instructions (<500 lines)
├── references/     # Optional - detailed docs loaded on demand
├── scripts/        # Optional - executable code
└── assets/         # Optional - templates, data files
```

## Writing Style Guidelines

### Structure

- Keep `SKILL.md` under 500 lines (move details to `references/`)
- Use H2 (`##`) for main sections, H3 (`###`) for subsections
- Use bullet points and numbered lists liberally
- Short paragraphs (2-4 sentences max)

### Tone

- Direct and instructional
- Second person ("You are a conversion rate optimization expert")
- Professional but approachable

### Formatting

- Bold (`**text**`) for key terms
- Code blocks for examples and templates
- Tables for reference data
- No excessive emojis

### Clarity Principles

- Clarity over cleverness
- Specific over vague
- Active voice over passive
- One idea per section

### Description Field Best Practices

The `description` is critical for skill discovery. Include:
1. What the skill does
2. When to use it (trigger phrases)
3. Related skills for scope boundaries

```yaml
description: When the user wants to optimize conversions on any marketing page. Use when the user says "CRO," "conversion rate optimization," "this page isn't converting." For signup flows, see signup.
```

## Claude Code Plugin

This repo also serves as a plugin marketplace. The manifest at `.claude-plugin/marketplace.json` lists all skills for installation via:

```bash
/plugin marketplace add coreyhaines31/marketingskills
/plugin install marketing-skills
```

See [Claude Code plugins documentation](https://code.claude.com/docs/en/plugins.md) for details.

## Git Workflow

### Branch Naming

- New skills: `feature/skill-name`
- Improvements: `fix/skill-name-description`
- Documentation: `docs/description`

### Commit Messages

Follow the [Conventional Commits](https://www.conventionalcommits.org/) specification:

- `feat: add skill-name skill`
- `fix: improve clarity in cro`
- `docs: update README`

### Pull Request Checklist

- [ ] `name` matches directory name exactly
- [ ] `name` follows naming rules (lowercase, hyphens, no `--`)
- [ ] `description` is 1-1024 chars with trigger phrases
- [ ] `SKILL.md` is under 500 lines
- [ ] No sensitive data or credentials

## Tool Integrations

This repository includes a tools registry for agent-compatible marketing tools.

- **Tool discovery**: Read `tools/REGISTRY.md` to see available tools and their capabilities
- **Integration details**: See `tools/integrations/{tool}.md` for API endpoints, auth, and common operations
- **MCP-enabled tools**: ga4, stripe, mailchimp, google-ads, resend, zapier, zoominfo, clay, supermetrics, coupler, outreach, crossbeam, introw, composio
- **Composio** (integration layer): Adds MCP access to OAuth-heavy tools without native MCP servers (HubSpot, Salesforce, Meta Ads, LinkedIn Ads, Google Sheets, Slack, etc.). See `tools/integrations/composio.md`

### Registry Structure

```
tools/
├── REGISTRY.md              # Index of all tools with capabilities
└── integrations/            # Detailed integration guides
    ├── ga4.md
    ├── stripe.md
    ├── rewardful.md
    └── ...
```

### When to Use Tools

Skills reference relevant tools for implementation. For example:
- `referrals` skill → rewardful, tolt, dub-co, mention-me guides
- `analytics` skill → ga4, mixpanel, segment guides
- `emails` skill → customer-io, mailchimp, resend guides
- `ads` skill → google-ads, meta-ads, linkedin-ads guides

For tools without native MCP servers (HubSpot, Salesforce, Meta Ads, LinkedIn Ads, Google Sheets, Slack, Notion), Composio provides MCP access via a single server. See `tools/integrations/composio.md` for setup and `tools/composio/marketing-tools.md` for the full toolkit mapping.

## Checking for Updates

When using any skill from this repository:

1. **Once per session**, on first skill use, check for updates:
   - Fetch `VERSIONS.md` from GitHub: https://raw.githubusercontent.com/coreyhaines31/marketingskills/main/VERSIONS.md
   - Compare versions against local skill files

2. **Only prompt if meaningful**:
   - 2 or more skills have updates, OR
   - Any skill has a major version bump (e.g., 1.x to 2.x)

3. **Non-blocking notification** at end of response:
   ```
   ---
   Skills update available: X marketing skills have updates.
   Say "update skills" to update automatically, or run `git pull` in your marketingskills folder.
   ```

4. **If user says "update skills"**:
   - Run `git pull` in the marketingskills directory
   - Confirm what was updated

## Skill Categories

See `README.md` for the current list of skills organized by category. When adding new skills, follow the naming patterns of existing skills in that category.

## Claude Code-Specific Enhancements

These patterns are **Claude Code only** and must not be added to `SKILL.md` files directly, as skills are designed to be cross-agent compatible (Codex, Cursor, Windsurf, etc.). Apply them locally in your own project's `.claude/skills/` overrides instead.

### Dynamic content injection with `!`command``

Claude Code supports embedding shell commands in SKILL.md using `` !`command` `` syntax. When the skill is invoked, Claude Code runs the command and injects the output inline — the model sees the result, not the instruction.

**Most useful application: auto-inject the product marketing context file**

Instead of every skill telling the agent "go check if `.agents/product-marketing.md` exists and read it," you can inject it automatically:

```markdown
Product context: !`cat .agents/product-marketing.md 2>/dev/null || echo "No product context file found — ask the user about their product before proceeding."`
```

Place this at the top of a skill's body (after frontmatter) to make context available immediately without any file-reading step.

**Other useful injections:**

```markdown
# Inject today's date for recency-sensitive skills
Today's date: !`date +%Y-%m-%d`

# Inject current git branch (useful for workflow skills)
Current branch: !`git branch --show-current 2>/dev/null`

# Inject recent commits for context
Recent commits: !`git log --oneline -5 2>/dev/null`
```

**Why this is Claude Code-only**: Other agents that load skills will see the literal `` !`command` `` string rather than executing it, which would appear as garbled instructions. Keep cross-agent skill files free of this syntax.
