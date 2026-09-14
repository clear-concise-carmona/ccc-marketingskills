# Ecommerce Marketing Context: Aliens of Brooklyn

Operating rules for agents working on the Aliens of Brooklyn Shopify store and its marketing channels. Product facts live in `aliens-of-brooklyn-brand-context.md`; claim rules live in `docs/claims-and-disclaimers.md`. This file says how to do the work.

Every rule below applies to drafts. Nothing an agent produces goes live without owner review (`docs/source-of-truth.md`, section 6).

## 1. Product page rules

Use the owner's product description formula in this order: hook, benefit, details, vibe, call to action.

1. **Hook:** one playful line in the brand voice. No celebrity names beyond what is already in the product title.
2. **Benefit:** what the piece does for the wearer (the word, the reference, the fit).
3. **Details:** materials, fit, sizes, care, and made-in claims copied from the current product page or supplied by the owners. Never invent a material, weight, or origin. If the page has no material, write `[CLIENT REVIEW: material]` and move on.
4. **Vibe:** where and how it gets worn.
5. **CTA:** one line. Branded CTAs from the brief are allowed in the body; the button label stays a Shopify decision.

Hard rules:
- Preserve the custom order instructions on every custom product exactly as the live page states them (check out, then email or DM the word or image). On cap pages the "custom option" the copy mentions does not exist in the dropdown as of 2026-09-14; do not direct cap buyers through it. Flag the conflict and see `aliens-of-brooklyn-brand-context.md` section 2. `[CLIENT REVIEW]`
- State the turnaround the page already states. Do not shorten it.
- State "final sale" on custom items.
- Keep the SEO title under 60 characters in the form `Product | Aliens of Brooklyn` and the meta description under 160 characters. This matches the format the owners used in their September 2026 metadata pass. `[BRIEF]`
- Write one descriptive alt text per image: product, color, word shown, context. Under 125 characters.
- Sizing: link to or restate the FAQ sizing. Never claim "true to size" unless the owners confirm.
- Supplier boilerplate (blank-garment marketing copy, color charts that are not on the page) gets removed, not rewritten.

## 2. Collection page rules

- One target keyword per collection, stated in the brief for the task. Working targets: `custom word dad hat` (caps), `custom word beanie` (beanies), `y2k pop culture t-shirt` (shirts), `y2k streetwear nyc` (homepage). Confirm with the owners before locking them.
- Write a 60 to 120 word description that says what is in the collection, who it is for, and how customization works if it applies. No keyword stuffing.
- Collection handles are being cleaned up (older handles like `/collections/hoodies` still exist alongside new ones like `/collections/tote-bags`). Link to the handle in the current main menu, and flag any mismatch you find.
- Do not promote a collection without confirming it has stock. Some collections were empty in September 2026.
- Suggest merchandising order (featured, best selling) as a recommendation; the owners set it in Shopify.

## 3. SEO rules

- Scope: on-page and technical recommendations for a Shopify store on an older theme. Theme file edits are proposals with exact code, applied by the owners.
- Every recommendation names the page URL, the current value, the proposed value, and the reason.
- Structured data: propose JSON-LD for Organization, ClothingStore (both locations), Product with offers, BreadcrumbList, and FAQPage. Only include facts that appear on the page the schema describes. No aggregateRating without real reviews.
- Local SEO copy must use the two addresses exactly as the site prints them. No hours unless confirmed.
- Blog and content ideas must map to a search intent and a product or store. Suggested first topics from the owners' audit `[BRIEF]`: the East Village store story (history is `[CLIENT REVIEW]`), how custom word hats work, a Y2K festival outfit guide, and an Austin store guide. Drafts are `[CLIENT REVIEW]`; they contain brand history.
- AI search (`ai-seo` skill): the canonical one-liner is the FAQ self-description. Use it consistently across pages and profiles.
- Never propose buying links, cloaking, doorway pages, or copying competitor text.

## 4. Email and SMS rules

- Platform: confirm before drafting. Per the owners' September 2026 audit the store used Shopify Email and had no SMS program `[BRIEF]`; this can change without notice. Draft in platform-neutral text with a subject line, preview text, body, and CTA.
- Flows worth drafting, in priority order: welcome, abandoned checkout, post-purchase (with a custom-item variant that explains the email-your-word step and the turnaround), back-in-stock or new-drop, win-back.
- Subject lines under 50 characters; one emoji at most, at the start if used. Preview text around 40 characters.
- Discounts, codes, and free-shipping thresholds appear only if the owners confirm they exist. Use `{{DISCOUNT_CODE}}` and `{{THRESHOLD}}` placeholders otherwise.
- Sending cadence recommendations: two to three campaign sends per week at most; Tuesday to Thursday mid-day Eastern as a starting hypothesis.
- SMS requires express written consent and a clear opt-out in every message. Do not draft SMS that implies consent exists. Do not draft quiet-hours sends.
- Never include real customer names, emails, or order details in examples. Use "Alex" and "order #1001" style placeholders.

## 5. Social content rules

- Instagram first, TikTok second, Facebook for retargeting. Draft for the platform, not one caption for all.
- Content mix from the brand brief: product 40 percent, community and UGC 30 percent, nostalgia 20 percent, behind the scenes 10 percent.
- Product posts need the price and a way to buy (link in bio, product tag). Store posts need the address. Custom posts can use "DM us your word."
- Hashtags: brand tags plus a few category tags (Y2K fashion, custom hat, festival fashion) plus a location tag. Keep it to a short set; no hashtag walls.
- Pop culture and meme references are the voice, but do not write captions that imply a celebrity, artist, or franchise endorses or partners with the brand.
- Reposting customer content requires permission and credit. Draft the ask; do not assume it.
- No captions that mock, exclude, or reduce anyone. Cheeky about the brand, warm about people.
- Store hours, events, and openings: "soft opening" language only until the owners say otherwise; no invented event features.

## 6. UGC and influencer cautions

- Gifting before paid deals. Micro-creators (roughly 10K to 50K followers) in NYC and Austin whose aesthetic fits.
- Every sponsored or gifted post needs a clear disclosure (#ad or #gifted as the platform requires). Put the disclosure requirement in every creator brief.
- Do not promise reach, sales, or results to a creator or from a creator.
- Content rights: draft usage terms as a proposal for the owners; never state that rights were secured.
- Do not name a creator as a partner unless the owners confirm the relationship in writing.
- Reviews and testimonials: only real ones, with permission, unedited except for length. None exist on the site today.

## 7. Paid ad copy cautions

- Draft concepts for Meta and TikTok only with owner confirmation that pixels and ad accounts exist. Agents never touch ad accounts.
- Explicit menu words and celebrity-named products will fail platform review. Build ad concepts around the clean subset of the word menu, the made-in-NYC story, the custom option, and the stores.
- No claims about delivery speed, discounts, returns, quality guarantees, or "best" anything without a source.
- No targeting or copy that references sexual orientation, gender identity, race, religion, disability, or age as a targeting criterion, and nothing that body-shames or excludes. Inclusive brand tone is fine; protected-class targeting is not.
- No before-and-after framing, no medical or wellness implications from apparel.
- UTM every landing link with a proposed scheme (`utm_source`, `utm_medium`, `utm_campaign`) so the owners can attribute.

## 8. Conversion rate optimization rules

- The two flows that matter most: product page to add-to-cart on Choose Your Word caps and beanies, and the custom order submission step.
- Every CRO recommendation states the hypothesis, the page, the change, the expected effect, and how to measure it in Shopify analytics.
- Trust elements to propose, in order: size guide on product pages, shipping and returns summary near the add-to-cart button, the custom-item final sale note before checkout, a "what happens after you order a custom item" block, real reviews once they exist.
- Urgency and scarcity only when true (real stock counts, real drop windows). No fake countdowns.
- Popups: one at most, delayed or exit intent, with an incentive only if the owners confirm one. Mobile first.
- Recommend a product-page text field for the custom word as the long-term fix; document the current email flow accurately until then.

## 9. Analytics and customer data privacy rules

- Work only from aggregated metrics or sanitized exports the owners hand over for a specific task. Never request a full customer export, order export, or email list.
- Nothing with names, emails, phone numbers, addresses, order IDs, payment details, or IP addresses enters this repo, a prompt log, or a deliverable.
- If a file with customer data is shared by mistake, stop, say so, and do not summarize its contents beyond counts.
- Before interpreting session or conversion figures, ask the owners whether bot and datacenter traffic has been filtered. Unfiltered Shopify session data understates real conversion; say so in any analysis that uses it.
- Analytics setup recommendations (GA4, Search Console, pixels) are instructions for the owners to apply. Agents never hold or store credentials, property IDs, or tokens; use `{{GA4_MEASUREMENT_ID}}` style placeholders in any code sample.
- Reports go in the deliverable, not in the repo. This repo holds rules and context, not results.

## 10. Seasonal campaign ideas (all require owner approval)

From the brand brief calendar. Each is a starting point, not a commitment; dates, drops, and offers are owner decisions.

| Window | Idea | Notes |
|--------|------|-------|
| Q1 | New year custom word push; Valentine's self-love and gift words; SXSW Austin activation | SXSW claims need confirmation that the brand is participating |
| Q2 | Pride month | The brand is queer-owned; celebrate without tokenizing. Any Pride collection or donation claim needs owner confirmation |
| Q2 to Q3 | Festival season pieces | Do not name a festival as a partner; "festival-ready" is fine |
| Q3 | Back to school word beanies; ACL season in Austin | Same partner caution |
| Q4 | Halloween alien pieces; Black Friday and Cyber Monday; holiday gift guide by word (Cat mom, Dog dad, Papi); New Year's Eve | Sale percentages and codes only if confirmed |
| Any time | New store event, collaboration drop, "Alien of the Week" UGC feature | Soft opening language; permission for UGC |
