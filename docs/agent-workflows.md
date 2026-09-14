# Agent Workflows for Aliens of Brooklyn

Step-by-step workflows for the marketing tasks this repo supports. Each names the skills to invoke (from `skills/`), the inputs to gather, the output format, and the review gate. Claude Code runs the workflow; Codex reviews the result against `AGENTS.md` and `docs/claims-and-disclaimers.md`.

Every workflow starts the same way:

1. Read `.agents/product-marketing.md` (skills do this automatically, but confirm).
2. Read `.agents/aliens-of-brooklyn-brand-context.md` and `.agents/ecommerce-marketing-context.md`.
3. Fetch the live page or pages the task touches and note the date.
4. Work in a branch named `docs/...`, `content/...`, or `seo/...`.

Every workflow ends the same way:

1. Run `scripts/validate-agent-docs.sh`.
2. Write a handoff summary: what changed, sources used, open questions, every `[CLIENT REVIEW]` and `[ASSUMPTION]` tag.
3. Paste the checklist from `docs/claims-and-disclaimers.md` section 12 with each line checked or explained.

Deliverables go in a task folder the owners specify (or the deliverable is returned in chat). Deliverables are not committed to this repo unless they are documentation about how to do the work.

---

## 1. Product page rewrite

**Skills:** `copywriting`, `copy-editing`, `seo-audit` (on-page section), `schema`.

1. Fetch the live product page. Capture title, price, variants, description, images, and any SEO fields the owners share.
2. Separate facts (materials, sizes, turnaround, custom steps, made-in) from supplier boilerplate. Facts stay; boilerplate goes.
3. Draft using the formula in `.agents/ecommerce-marketing-context.md` section 1: hook, benefit, details, vibe, CTA.
4. Draft the SEO title (`Product | Aliens of Brooklyn`, under 60 characters), meta description (under 160), and alt text per image (under 125).
5. Propose Product JSON-LD using only facts on the page.
6. Output: a table with before and after for each field, plus a "facts preserved" list and an open questions list.
7. Gate: owner review. Do not publish through any connector without explicit approval per page.

Prompt to start: "Rewrite the product page at [URL] using the AOB brand context. Preserve every product fact. Output before/after per field."

## 2. Collection page SEO

**Skills:** `seo-audit`, `site-architecture`, `copywriting`, `schema`.

1. List the collections in the main menu with their handles. Flag handles that do not match their contents and empty collections.
2. Assign one target keyword per collection from the working list in `.agents/ecommerce-marketing-context.md` section 2, or propose one with search intent stated.
3. Draft a 60 to 120 word description per collection plus SEO title and meta description.
4. Propose the collection order and any redirects (old handle to new handle) as a table for the owners to apply.
5. Propose ItemList and BreadcrumbList JSON-LD.
6. Output: one row per collection with keyword, description, SEO fields, and any structural change.

## 3. Homepage audit

**Skills:** `cro`, `copywriting`, `seo-audit`, `ai-seo`.

1. Fetch the homepage. Record the title tag, meta description, H1 (or its absence), above-the-fold content, buttons, announcement bar, footer content, and links to stores and social.
2. Score against: does a first-time visitor learn what the brand sells, for whom, and where, in five seconds?
3. Draft: title tag, meta description, a text H1, a two-sentence brand statement built from the FAQ one-liner, one primary button to the Choose Your Word caps, and footer text with both addresses.
4. Propose Organization and ClothingStore JSON-LD.
5. Output: audit table (finding, evidence, recommendation, priority) plus draft copy. Store hours and any offer are `[CLIENT REVIEW]`.

## 4. Custom order flow optimization

**Skills:** `cro`, `copywriting`, `emails`.

1. Walk the flow on the live site: product page, variant dropdown, custom option, cart, checkout, and the post-purchase email step described on the page.
2. List each point where the buyer has to leave the site or guess (what to email, how many characters, when they will hear back).
3. Draft: product-page microcopy for the custom option, a cart note, a post-purchase email for custom orders ("send us your word," turnaround, final sale), and an FAQ entry.
4. Recommend the structural fix (a line item property text field for the word) with an implementation note for the owners, and keep the current email flow documented as the truth until it ships.
5. Output: flow map with friction points, copy drafts, and the structural recommendation.

## 5. Email campaign

**Skills:** `emails`, `copywriting`, `offers` (only if an offer is confirmed), `sms` (only if an SMS program exists).

1. Confirm the platform and which flows already exist. Do not duplicate a live automation.
2. Pick the flow: welcome, abandoned checkout, post-purchase (standard and custom-item variants), back-in-stock or new drop, win-back.
3. Draft each email with subject line, preview text, body, and CTA, in the brand voice, with placeholders for any code or threshold.
4. State the trigger, delay, and exit conditions for each email as a recommendation.
5. Output: one section per email plus a flow table. Real customer data never appears; use placeholders.

## 6. Social launch

**Skills:** `social`, `launch`, `copywriting`, `image` (for creative direction only), `video` (for concept outlines only).

1. Define the launch: drop, collaboration, store event, or seasonal capsule. Confirm the date and facts with the owners.
2. Build a two-week sequence: teaser, reveal, how-to-buy, social proof (real only), reminder.
3. Draft Instagram captions (feed and reels), TikTok hooks and on-screen text, and story frames. Product posts carry price and link path; store posts carry the address.
4. Apply the pop culture and trademark rules in `docs/claims-and-disclaimers.md` section 9.
5. Output: calendar table plus caption bank. Event details and partner names are `[CLIENT REVIEW]`.

## 7. Paid ad concept

**Skills:** `ads`, `ad-creative`, `marketing-psychology`.

1. Confirm the platform, the objective, and that the pixel and ad account exist. If not confirmed, stop at concept level.
2. Choose the clean subset of products and words that will pass platform review.
3. Draft three to five concepts with hook, primary text, headline, description, and creative direction. No claims from section 4 of the claims file.
4. Propose audiences in plain terms (interest and lookalike categories), never protected-class targeting.
5. Propose UTM scheme and landing pages.
6. Output: concept table plus a compliance note per concept.

## 8. Conversion audit

**Skills:** `cro`, `popups`, `signup` (for account creation only), `ab-testing`.

1. Walk the site as a first-time mobile shopper: homepage, a collection, a product page, cart, checkout start.
2. Record friction: missing size guide, missing shipping summary, custom step clarity, trust signals, returns visibility, popup behavior, page speed proxies.
3. Prioritize by impact and effort. Trust and clarity first, then capture, then experiments.
4. For each fix: hypothesis, page, change, expected effect, and the Shopify analytics metric that would move.
5. Output: prioritized audit table plus a test plan for the top three changes.

## 9. Analytics review (sanitized data only)

**Skills:** `analytics`, `attribution`.

1. Accept only aggregated exports or screenshots the owners provide for the task (sessions by source, add-to-cart counts, orders by channel, top products). Refuse customer-level data.
2. Ask whether bot and datacenter traffic has been filtered; if not, treat session counts as inflated and say so.
3. Answer the question the owners asked, then list the two or three next questions the data cannot answer yet and what setup would answer them.
4. Output: a short findings memo. Numbers stay in the memo; nothing is written to this repo.

## 10. Client review workflow

**Skills:** none; this is process.

1. Package the deliverable with: what changed, sources and dates, the `[CLIENT REVIEW]` list, the `[ASSUMPTION]` list, and the checklist from `docs/claims-and-disclaimers.md` section 12.
2. Hand to Codex (or a second agent) for review against `AGENTS.md`. The reviewer checks facts against the live pages, the claims file, and the privacy rules, and reports findings in priority order.
3. Fix the findings, re-run validation, and send to the owners.
4. Owners approve, edit, or decline per item. Only approved items are published, and only by the owners or with their explicit per-item approval through a connector.
5. Record the outcome in the task's change log. Update `.agents/product-marketing.md` and `.agents/aliens-of-brooklyn-brand-context.md` if a fact changed, with a version bump.

---

## Other tasks this repo supports

Short pointers for tasks that do not need a full workflow.

| Task | Skills | Notes |
|------|--------|-------|
| Homepage copy refresh | `copywriting`, `cro` | Workflow 3 |
| Custom hat and shirt purchase-flow clarity | `cro`, `copywriting` | Workflow 4 |
| Launch campaign planning | `launch`, `social`, `emails` | Workflows 5 and 6 |
| Seasonal campaigns | `launch`, `emails`, `social`, `offers` | Ideas in `.agents/ecommerce-marketing-context.md` section 10; all need approval |
| Instagram captions | `social` | Product posts: price and link path; store posts: address |
| TikTok concept planning | `social`, `video` | Hooks and on-screen text; product video weekly |
| Pop-up or store visit promotions | `social`, `events`, `emails` | Soft opening language; no invented features |
| Austin and NYC location messaging | `copywriting`, `seo-audit` (local) | Addresses exactly as printed; hours `[CLIENT REVIEW]` |
| Gift guide | `copywriting`, `emails`, `social` | Organize by word or by recipient; real prices only |
| Size, fit, and care copy cleanup | `copy-editing` | FAQ sizing is the source; no "true to size" |
| FAQ improvements | `copywriting`, `schema` | FAQPage JSON-LD; keep policies consistent with the policy pages |
| Returns and shipping policy review | `copy-editing` | Propose clearer wording; policy changes themselves are owner decisions |
| Abandoned cart flow copy | `emails` | Workflow 5 |
| Post-purchase flow copy | `emails` | Custom-item variant is required |
| Merchandising review | `cro`, `pricing` (analysis only) | Recommend order and bundles; owners set them in Shopify |
| Competitor pattern research | `competitor-profiling`, `customer-research` | Patterns, not wording; no competitor names in public copy |
| Press page or press pitch | `public-relations` | Every mention and quote is `[CLIENT REVIEW]`; founder availability must be confirmed |
