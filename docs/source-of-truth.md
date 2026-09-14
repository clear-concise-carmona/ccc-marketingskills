# Source of Truth for Aliens of Brooklyn Marketing Work

This file governs where facts come from, what to do when sources disagree, and what must be reviewed by the owners before anything is published.

## 1. Source hierarchy

When two sources conflict, the higher one wins. Cite the source you used.

| Rank | Source | Tag | Responsible for |
|------|--------|-----|-----------------|
| 1 | Owner-approved brand materials shared by the Aliens of Brooklyn owners (brand brief, written approvals, signed-off copy) | `[BRIEF]` or `[APPROVED]` | Positioning, founder story, tagline, values, voice, target audiences, visual system, offers, partners |
| 2 | The official website, https://www.aliensofbrooklyn.com | `[SITE]` | Product facts, prices, sizes, materials, custom order steps, turnaround, shipping, returns, addresses, contact |
| 3 | Official Instagram @aliensofbrooklyn and other official channels, only when the owners provide the content or it is clearly verified | `[SOCIAL]` | Store hours, event announcements, current drops |
| 4 | This repository's existing documentation (`README.md`, `AGENTS.md`, `skills/*/SKILL.md`, `tools/`) | `[REPO]` | How skills work, install methods, skill conventions |
| 5 | Claude and OpenAI cookbook conventions | `[COOKBOOK]` | Documentation structure, agent-instruction patterns, validation habits |
| 6 | Third-party press, directories, and interviews | `[PRESS]` | Supporting context only. Never the sole source for a public claim |
| 7 | Agent inference | `[ASSUMPTION]` | Working hypotheses. Never published |

Anything that needs owner sign-off before publishing carries `[CLIENT REVIEW]` in addition to its source tag.

## 2. What each source may and may not settle

- The brand brief may name the founder, define the voice, and set audiences. It cannot override a price, policy, or address printed on the site. When the brief and the site disagree on a store or location, the site wins and the brief is treated as outdated.
- The site settles product facts. It cannot settle brand history beyond what the FAQ states, and it does not publish store hours.
- Social channels settle time-sensitive facts (hours, events) only when the owners confirm the post or the agent can read it directly. Third-party mirrors and stat sites do not count.
- Repo documentation settles how to use the skills. It says nothing about the brand.
- Press settles nothing on its own. It can point an agent to a question to ask the owners.

## 3. Handling conflicts

1. State both values and their sources in the deliverable.
2. Use the higher-ranked source in the draft.
3. Add a line to the handoff summary: "Conflict: [fact]. Site says X, brief says Y. Draft uses X. Confirm."
4. If the conflict is about a policy, a price, a claim of origin, or a partner, do not publish either value until the owners answer.

## 4. Marking assumptions

- Inline: `[ASSUMPTION]` right after the sentence.
- In tables: a dedicated Source column.
- In a deliverable: a closing section titled "Assumptions and open questions" that lists every tagged line.
- Never delete a tag to make a draft look finished. Tags are removed by the owners when they confirm the fact.

## 5. Requesting missing brand information

Ask in one batch at the end of the task, not one question at a time. Format:

```
Open questions for Aliens of Brooklyn owners (task: product page rewrite, 2026-09-14)
1. Materials for the Am I the Drama sweatshirt (page does not state them).
2. Is the WELCOME15 code live? Copy references it only if yes.
3. Store hours for both locations for the FAQ.
```

Do not fill the gap with a plausible answer until the owners answer.

## 6. What must receive owner review before publishing

- Any copy that goes on the site, in email or SMS, on social, in ads, or in press materials.
- Any claim about origin, materials, manufacturing, shipping time, returns, exchanges, or discounts.
- Any use of the founder's name, the brand's history, or identity descriptors.
- Any celebrity, character, franchise, artist, festival, venue, or partner name.
- Any store hours, event, opening, or "grand opening" language.
- Any structured data, theme code, menu change, redirect, or collection restructure.
- Any influencer brief, creator agreement, or usage-rights language.
- Any analytics interpretation that will inform spend.

The review checklist is in `docs/claims-and-disclaimers.md`, section 12.

## 7. Privacy and customer data boundaries

- Customer names, emails, phone numbers, addresses, order histories, payment details, and analytics exports never enter this repository, an agent prompt, or a deliverable. Aggregated numbers supplied by the owners for a specific task are acceptable in that task's deliverable only.
- Credentials of any kind (Shopify access tokens, API keys, ad account tokens, email platform keys, analytics property credentials, `.env` files) are never written to files, docs, examples, or commit messages. Code samples use `{{PLACEHOLDER}}` values.
- Fabricated examples use obviously fake data: "Alex Example," "alex@example.com," "order #1001."
- If real data appears in a file or message by mistake, stop, say so, and do not process or restate it.
- The `.gitignore` excludes `.env*`, CSV exports outside the skill and tool folders, and `data/` and `exports/` directories. Do not work around it.

## 8. Dating and versioning facts

- Prices, policies, addresses, and menu words change. Record the verification date next to any fact that can change.
- `.agents/product-marketing.md` and `.agents/aliens-of-brooklyn-brand-context.md` carry version numbers and change logs. Bump them when a fact changes, and say which source changed.
