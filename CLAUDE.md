# CLAUDE.md

Claude Code instructions for this repository. Read `AGENTS.md` first; it is the cross-agent rulebook and everything there applies here. This file adds what is specific to Claude Code.

Note for maintainers: upstream `coreyhaines31/marketingskills` ships `CLAUDE.md` as a symlink to `AGENTS.md`. This fork replaces it with a real file so Claude-only guidance can live here without leaking into cross-agent files, and so Windows checkouts do not break the link. When merging upstream, keep this file.

## What this repo is, in one paragraph

A fork of Marketing Skills (50 agent skills for CRO, copywriting, SEO, email, social, ads, and growth) set up to support Aliens of Brooklyn, a queer-owned 90s and Y2K pop culture streetwear brand with a Shopify store and two retail locations (East Village NYC and East Austin). Claude Code does the implementation work; OpenAI Codex reviews it. Client context lives in `.agents/`, governance in `docs/`.

## Start every session here

```bash
# Confirm the context files exist and are current
head -5 .agents/product-marketing.md
head -5 .agents/aliens-of-brooklyn-brand-context.md

# Validate before and after edits
scripts/validate-agent-docs.sh

# Skill checks (only if a SKILL.md changed)
./validate-skills.sh
```

Then read, in order: `.agents/product-marketing.md`, `.agents/aliens-of-brooklyn-brand-context.md`, `.agents/ecommerce-marketing-context.md`, and `docs/claims-and-disclaimers.md` when the task produces customer-facing copy.

## When to use the installed marketing skills

The skills are in `skills/<name>/SKILL.md`. Invoke them by name (`/cro`, `/copywriting`) or let the description match the task. Every skill checks `.agents/product-marketing.md` first, which is already populated for this client.

| Task | Skill(s) |
|------|----------|
| Audit product or collection pages for SEO | `seo-audit`, `schema`, `ai-seo` |
| Rewrite product descriptions and preserve every product fact | `copywriting`, then `copy-editing` |
| Improve product page to cart flow | `cro` |
| Abandoned cart, new drop, back in stock, custom order emails | `emails` (and `sms` only if a program exists) |
| Instagram and TikTok captions | `social` |
| Meta and TikTok ad concepts without unsupported claims | `ads`, `ad-creative` |
| Analytics questions, sanitized data only | `analytics`, `attribution` |
| Buyer segments, positioning, launch angles | `product-marketing`, `launch` |
| Merchandising pattern research without copying competitors | `competitor-profiling`, `customer-research` |
| Creator gifting and UGC | `influencer-marketing` |
| Popups and email capture | `popups` |

Full workflows with steps and output formats: `docs/agent-workflows.md`.

## Working with `.agents/aliens-of-brooklyn-brand-context.md`

- It is the durable fact file. Product facts, prices, custom order steps, policies, addresses, voice, and CTAs are there with source tags (`[SITE]`, `[BRIEF]`, `[CLIENT REVIEW]`, `[ASSUMPTION]`).
- Before quoting a price, size, material, or turnaround, re-fetch the live product page. The file records what was true on its verification date; the page is the truth today.
- If you find a fact that changed, update the file in the same branch, bump its change log, and say so in the handoff.
- Do not remove a `[CLIENT REVIEW]` or `[ASSUMPTION]` tag. Only the owners confirm facts.
- `.agents/product-marketing.md` is the short version every skill reads. Keep the two in sync when positioning changes; bump its document version and add a changelog line as the `product-marketing` skill expects.

## Claude Code specifics that do not belong in AGENTS.md

- **Dynamic injection.** Claude Code supports `` !`command` `` in skill files. Do not add it to `skills/*/SKILL.md` (cross-agent files). If you want the brand context injected automatically, create a local override in `.claude/skills/` (gitignored) per the "Claude Code-Specific Enhancements" section of `AGENTS.md`.
- **Plan mode for multi-page changes.** Any task touching more than three pages, a menu, a redirect set, or a theme file: plan first, list the pages, get approval, then execute.
- **Subagents for review.** After drafting customer-facing copy, run a read-only review pass against `docs/claims-and-disclaimers.md` (a separate agent with Read and Grep only). Fix findings before the handoff.
- **Web fetches.** Use the live site to verify facts. Do not fetch third-party mirrors or stat sites as sources of brand facts; they are supporting context at best (`docs/source-of-truth.md`).
- **Connectors.** If a Shopify or email connector is available in the session, treat every write as an owner-approved, per-item action. Read freely; write only what the owners approved in this conversation. Never unpublish, delete, or bulk-edit without an explicit instruction naming the items.
- **Memory and project docs.** Session notes and change logs for store edits belong in the owners' shared change log, not in this repo.

## Suggested Claude Code workflows for this client

1. **Product page pass.** `/copywriting` on one product URL, preserve facts, produce a before/after table, then `/seo-audit` for the SEO fields, then a review subagent, then handoff.
2. **Collection cleanup.** `/site-architecture` to map handles and menu links, `/copywriting` for descriptions, output a redirect table for the owners.
3. **Custom order flow.** `/cro` on the Choose Your Word cap, draft the microcopy and the post-purchase custom-item email with `/emails`, recommend the text-field fix.
4. **Lifecycle email set.** `/emails` for welcome, abandoned checkout, post-purchase, win-back, with placeholders for any code.
5. **Launch or drop.** `/launch` for the sequence, `/social` for captions, `/emails` for the announcement, all with soft opening language and owner-confirmed facts.
6. **Monthly SEO check.** `/seo-audit` on homepage, two collections, and the top five products; `/schema` for any missing structured data; report as a prioritized table.

## Boundaries

- **Customer data:** never request, open, summarize, or store customer lists, order exports, email lists, or anything with names, emails, phones, addresses, or payment details. Aggregates supplied for a task stay in that task's deliverable.
- **Shopify and ecommerce data:** read-only unless the owners approve a specific write. No theme edits on the live theme without an explicit per-file instruction.
- **Analytics data:** aggregated only; note the datacenter-traffic caveat in any interpretation.
- **Ad accounts:** never connect to, read, or modify. Draft concepts only.
- **Credentials:** never write tokens, keys, property IDs, or `.env` contents anywhere. Use `{{PLACEHOLDER}}` in samples. If a credential appears in a message or file, say so and do not repeat it.
- **Claims:** follow `docs/claims-and-disclaimers.md`. No celebrity endorsement, no invented materials, no shipping or returns promises, no store hours, no "grand opening."

## Before you finish

- [ ] `scripts/validate-agent-docs.sh` passes.
- [ ] Every product fact in the deliverable was checked against the live page today.
- [ ] Custom order steps, turnaround, and "final sale" are intact wherever they apply.
- [ ] No new third-party names, endorsements, discounts, hours, or superlatives.
- [ ] No customer data, credentials, or internal metrics in the repo or the deliverable.
- [ ] No em-dashes in customer-facing copy.
- [ ] `[CLIENT REVIEW]` and `[ASSUMPTION]` items are listed in the handoff summary.
- [ ] Context files updated and version-bumped if a fact changed.
- [ ] Branch follows `AGENTS.md` naming; commit messages follow Conventional Commits.
- [ ] Handoff summary written for Codex review (what changed, sources, open questions, checklist).
