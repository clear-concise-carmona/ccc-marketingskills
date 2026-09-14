# .agents/ directory

This directory holds the client context that every marketing skill reads before it does any work, plus the installed skills themselves.

## What lives here

| Path | Tracked in git | Purpose |
|------|----------------|---------|
| `product-marketing.md` | Yes | The context file every skill in this library checks first. Populated for Aliens of Brooklyn. Keep it short; it links to the two files below for detail. |
| `aliens-of-brooklyn-brand-context.md` | Yes | Durable brand facts: products, prices, custom order flow, locations, voice, CTAs, and the list of claims that still need owner review. |
| `ecommerce-marketing-context.md` | Yes | Operating rules for product pages, collection pages, SEO, email and SMS, social, ads, CRO, and analytics privacy. |
| `skills/` | No (gitignored) | Where `npx skills add` installs skills for cross-agent use. |
| `marketingskills/` | No (gitignored) | Where a git submodule install lands, if that method is used. |

## Installing the skills

The skills live in `skills/` at the repo root, so an agent running inside this repo can read them directly. Install them into a client project or a second agent like this:

```bash
# Claude Code (reads .claude/skills/)
npx skills add coreyhaines31/marketingskills -a claude-code

# Universal location (.agents/skills/) for Codex and other agents
npx skills add coreyhaines31/marketingskills

# Or, from this fork, copy the skills folder
cp -r skills/* .agents/skills/
```

The `README.md` at the repo root lists every install method. Codex reads `AGENTS.md`; Claude Code reads `CLAUDE.md` and then `AGENTS.md`.

## How agents should use the context files

1. Read `product-marketing.md` first. Every skill already looks for it at this path.
2. Before writing any customer-facing copy, read `aliens-of-brooklyn-brand-context.md` for product facts and `docs/claims-and-disclaimers.md` for what can and cannot be claimed.
3. Before touching product pages, collections, email flows, or ads, read `ecommerce-marketing-context.md`.
4. When a fact is missing, do not guess. Mark it `[CLIENT REVIEW]` in the output and list the question in the handoff summary.
5. Keep customer data, order exports, analytics exports, and credentials out of this directory and out of the repo. Use the placeholders described in `docs/source-of-truth.md`.

## Updating the context files

- Any change to a product fact, price, policy, or location must cite where it was verified (a live URL on aliensofbrooklyn.com or an owner-provided document) and the date.
- `product-marketing.md` carries a document version and changelog at the bottom. Bump it on any substantive change, as the `product-marketing` skill expects.
- Run `scripts/validate-agent-docs.sh` before opening a pull request.
