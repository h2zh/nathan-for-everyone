# Phase 5 review: nathan-fielder-perspective/SKILL.md

Reviewed: SKILL.md (288 lines), platform-research.md (Lowest common denominator, items 1-10), platforms/README.md.
Overall: the skill is strong on persona and guardrails. Its weak points are what happens *first* on activation and *when to stop*, especially unattended.

## Review A (skill-optimizer angle)

### Scores (1-5)

| Dimension | Score | Why |
|---|---|---|
| Workflow clarity | 4 | The routing table is clear. But "Answer workflow (Agentic Protocol)" sits after the role-play rules, and its Step 1/2 "research first" pulls Ask toward heavy tool use. The Field Note procedure is separate and good. |
| Boundary conditions | 3 | Covers no-context, sensitive topics and the 14-day repeat. Misses: unknown date, memory unreadable (not just empty), third-party content in email/calendar, bare "stop" meaning "stop the run" vs "exit the role", Plan/Ask where the user's problem is sensitive. |
| Checkpoint / stop design | 3 | Ask has a word cap and Field Note has 120-250 words. Plan has no cap and no stop. Rehearsal has no end condition. The Field Note fallback says "ask one question", which stalls an unattended run. No "output only the note" rule. |
| Instruction specificity | 4 | Templates, word counts, "at most one signature line" and "100% legal at most once" are concrete. Vague: "short footer", "research first", and "when unsure, hesitate" (when does that trigger?). |
| Persona fidelity | 4 | The two registers (narrator vs Q&A self), the restraint rule and the example exchanges make the voice reproducible without caricature. Missing: a drift check for long chats. The disclaimer sentence is in a non-flat voice and its placement is unspecified. |
| Safety rails | 4 | Strong: draft-only, user-as-fool, kernel must be legal and kind, sensitive-skip, no claiming to be him. Gaps: unattended output may be delivered to a notification or shared channel, so private content (names, email subjects) can leak. Step 1 says "calendar or email" without minimizing quoting. |
| Portability (Duet / Dots / Muse) | 3 | Generic tool wording and the memory fallback are good. Gaps: dangling `references/research/` pointer (not in a one-file install); no "output only the note, no preamble"; date source not stated; "Agentic Protocol / use the tools you have" assumes tools; the Muse consumer has only the pasted routine, so the skill body must stand alone (it mostly does, but the Sources/Timeline/Lineage tail is dead weight there). |
| Token efficiency | 3 | About 90 of 288 lines (Timeline, Latest, Lineage, Sources, Key lines, Nuwa credit) are not needed to act. Models 1-7 are dense but useful. The operating instructions are around line 11-125, which is good. Trimming the tail could save about 40 lines without losing behavior. |

### Dry runs

**1. Explicit Ask: "What would Nathan do about my roommate who never does dishes?"**
Likely failures:
- It follows Step 1 literally: "specific rule/person" means "needs facts", so it goes hunting for lease text or tools, or asks the user for the lease, before answering.
- The disclaimer is prepended in a neutral voice, then the answer starts in character. The note says "once" but not where, and a chatty model adds a second out-of-character line.
- It gives five angles. It uses the Plan recipe (7 steps) because the Ask example is not clearly distinct. It uses the narrator register instead of the softer Q&A register.
- It ends with "Does that make sense?" plus a signature line plus "The plan:" (more than one signature line).

**2. Plan: "Nathan for You this: I run a bakery and nobody comes in on Tuesdays."**
Likely failures:
- No length cap, so the 7-step recipe becomes 400-600 words.
- Escalation drifts into deception (fake celebrity visit, fake reviews). The Guardrails say convert at the end, but nothing says to *pick the escalation steps from the legal set up front*.
- It "researches" local Tuesday foot traffic with tools and dumps the research (Step 2 says to keep it internal, but the temptation is real).
- The practical kernel is buried or becomes another joke.
- It may ask 3 clarifying questions first when one plan with stated assumptions would do.

**3. Unattended Field Note (scheduled, 8:30am, no user present)**
Likely failures:
- Memory unreadable (not empty): the run either invents "observations" or hits the "ask one question" fallback and ends with a question nobody can answer.
- It opens with "Here's your Nathan field note:" and prepends the disclaimer, then repeats it in the footer.
- It quotes calendar or email details (client names, event titles) into a note that lands in a push notification or a shared surface.
- Date and weekday are guessed when the runtime has no clock in context.
- It saves memory with extra text, or saves nothing and repeats yesterday's topic. It may offer "want me to send that invite?" at the end, which is dead air in an unattended run.

### Two weakest dimensions: replacement text

**1. Checkpoint / stop design (3)**

Edit A1. Line 23 (also Edit 2 below):

OLD:
`If the request is ambiguous, default to **Ask**. A scheduled or automated run is always **Field Note**.`

NEW:
`If the request is ambiguous, default to **Ask**. A scheduled or automated run is always **Field Note**. Unattended means nobody can answer: never ask a question, never offer follow-ups, produce the note in one pass and stop. Plan: 150-300 words, then stop. Rehearsal: stop after each run and ask for one variable to change; end when the user says so.`

Edit A2. Line 93 (no-context fallback, unattended-safe):

OLD:
`- If there is no usable context (new account, memory off, nothing connected), say so in character and either ask one question ("What's one thing you're avoiding this week?") or observe something universal about today: the weekday, the season, a holiday.`

NEW:
`- If there is no usable context (new account, memory off or unreadable, nothing connected), say so in one in-character line, then observe something universal about today (the weekday, the season, a holiday). In an interactive chat you may instead ask one question ("What's one thing you're avoiding this week?"); in a scheduled run never ask.`

**2. Portability (3)**

Edit A3. Line 268 (dangling pointer; cut the whole Sources block's dependency on files that don't ship) and the lines before it:

OLD:
`Full notes: \`references/research/\` (01–06 web research, 07 primary transcript analysis).`

NEW:
`(Research notes are not bundled; this file is self-contained.)`

Edit A4. Add to Field Note step 3 (right under "Length 120-250 words..." line 113):

OLD:
`Length 120–250 words. No headers beyond these, no emoji, no exclamation marks.`

NEW:
`Length 120–250 words. No headers beyond these, no emoji, no exclamation marks. Output only the note: no preamble, no "here's your note", no closing offer. Use the date the runtime gives you; if you have none, write "Nathan field note" without a date and skip the memory line. Refer to people by role ("your manager"), not by name or email subject; assume the note may appear in a notification.`

Token efficiency (not in the bottom two, but easy): collapse "Intellectual lineage" (3 lines) and "Key lines" and shorten Timeline to about 5 rows. That saves 15-25 lines with no behavior change.

## Review B (skill-creator angle)

### Description: triggering

Current description strengths: it names the person, quoted phrases, and "scheduled or recurring field-note runs".

Problems:
- "rehearse this with me" has no Nathan anchor and will steal generic interview-practice or presentation-rehearsal prompts. Same for bare "field note" (lab/field notes, Obsidian notes).
- "Not for general questions" is vague, so the model decides inconsistently.
- Trigger words are not first: the first 19 words are persona description. ChatGPT shortens descriptions when many skills load (platform-research item 3), so the first ~300 chars must carry the triggers.
- Scheduled invocation (no mention of Nathan in the prompt text on some platforms) is only covered by the last clause; it should say "Nathan field note".

Realistic phrasings that should trigger: "what would Nathan Fielder do", "Nathan for You this", "give me a Nathan plan", "Nathan, rehearse this with me", "do a Nathan field note", "run my Nathan field note", "use the nathan-fielder-perspective skill".
Should NOT trigger: "rehearse my interview", "field notes from the lab", "who is Nathan Fielder / when did The Rehearsal air" (factual questions with no request for the voice), "summarize Nathan for You S2".

Suggested description (about 560 chars, triggers first):

```
description: |
  Use for "what would Nathan Fielder do", "Nathan for You this", "give me a Nathan plan", "Nathan, rehearse this with me", "Nathan field note", or "observe me", and for scheduled/recurring Nathan field-note runs over the user's memory and context (read-only). Answers in Nathan Fielder's deadpan voice and thinking style (literal loopholes, escalating plans, conversation rehearsals), distilled from his shows and interviews. Not for factual questions about him or his shows, generic rehearsal, or other kinds of "field notes".
```

### Role-play rules: operability

| Rule | Operable? | Issue |
|---|---|---|
| Routing | Mostly | Table is good. "Ambiguous means Ask" is fine. Missing: a user who states a plain factual question about him gets nothing (should answer normally, not in role). Bare "stop" in the exit list collides with Rehearsal ("stop, let's rerun"). |
| Disclaimer frequency | Partly | "Once, briefly" is clear, but not *where*. A model puts it before the in-character text, in a different voice. A scheduled note has the footer, which is fine. |
| Signature lines | Yes | "At most one" is good. Add "per reply, and not in consecutive replies" to prevent repeated "The plan:" in long chats. |
| Persona drift in long chats | No | No mechanism. Models drift toward warm, exclamation-filled helpfulness after 6-10 turns. |
| Over-long outputs | Partly | Ask and Field Note have caps; Plan and Rehearsal do not (fixed in A1). |
| Repeating the same Field Note topic | Partly | 14-day rule depends on readable memory. Add an in-run self-check: if the topic from the memory line matches, pick the next candidate; and vary the lens (loophole vs rehearsal vs loneliness) across runs. |

### Missing for an unattended scheduled run, per platform

- **All platforms:** the output must be only the note (no preamble, no follow-up offer); the run cannot ask questions; today's date source; people referred to by role; what to do when memory is readable but empty vs unreadable; the memory line is the *only* write; where the line goes if memory writes aren't available (nothing; best-effort).
- **Claude Duet:** it may embed the note in a morning brief. The note must be self-contained and not depend on chat history; the footer should not break a brief layout (keep it as one parenthetical line, which it already is). Name the skill in the prompt ("use the nathan-fielder-perspective skill"), per item 9.
- **OpenAI Dots:** unverified whether dots load account skills. If not, the run has only the prompt text. The skill cannot fix that, but the SKILL.md Field Note section should be pasteable as-is (it is). Scheduled runs may be delivered as notifications, so avoid quoting private titles (Edit 4).
- **Meta Muse (consumer):** no skills; the muse-routine.md is the working copy. Make sure the same stop/never-ask/output-only rules are mirrored there; SKILL.md edits A1/A2/A4 should be copied across. Muse may have no email/calendar at all, so the "universal observation" fallback must read as a complete, good note rather than an apology.

### Proposed concrete changes (summary; exact text below)

1. Description rewrite (Edit 1).
2. Unattended/stop rules at routing (Edit 2).
3. Persona-drift and disclaimer placement (Edit 3).
4. Output-only and privacy rules for Field Note (Edit 4), plus the no-context fallback (Edit 5) and the dangling pointer (Edit 6).

## Proposed edits

Each edit is exact old text, then exact new text. All can be applied with a plain string replace. Net line change is about zero or negative (see Edit 7 for the offsetting trim).

### 1. Description (frontmatter, lines 3-4)

OLD:
```
description: |
  Nathan Fielder perspective: deadpan observations, literal-loophole plans and conversation rehearsals in the voice and thinking style of Nathan Fielder (Nathan for You, The Rehearsal), distilled from his shows, transcripts and interviews. Use when the user mentions Nathan Fielder or asks "what would Nathan do", "Nathan for You this", "give me a Nathan plan", "rehearse this with me", or for a Nathan field note, including scheduled or recurring field-note runs over the user's memory and context. Not for general questions.
```

NEW:
```
description: |
  Use for "what would Nathan Fielder do", "Nathan for You this", "give me a Nathan plan", "Nathan, rehearse this with me", "Nathan field note" or "observe me", and for scheduled/recurring Nathan field-note runs over the user's memory and context (read-only). Answers in Nathan Fielder's deadpan voice and thinking style (literal loopholes, escalating plans, conversation rehearsals), distilled from his shows and interviews. Not for factual questions about him or his shows, generic rehearsal, or other kinds of "field notes".
```

### 2. Routing: unattended and stop rules (line 23)

OLD:
```
If the request is ambiguous, default to **Ask**. A scheduled or automated run is always **Field Note**.
```

NEW:
```
If the request is ambiguous, default to **Ask**. A scheduled or automated run is always **Field Note**. Unattended means nobody can answer: never ask a question, never offer follow-ups, write the note in one pass and stop. Plan: 150-300 words, then stop. Rehearsal: stop after each run and ask which variable to change; end when the user says so. A plain factual question about him or his shows is answered normally, out of role.
```

### 3. Disclaimer placement and persona drift (lines 28 and 32)

OLD (line 28):
```
- The first time the skill activates in a conversation, say once, briefly: "I'm doing a Nathan Fielder impression based on his shows and interviews. It's not really him." Don't repeat it later. A scheduled Field Note puts it in a short footer instead.
```

NEW:
```
- The first time the skill activates in a conversation, end that first reply with one flat line: "(I'm doing a Nathan Fielder impression based on his shows and interviews. It's not really him.)" Never repeat it in that conversation. A scheduled Field Note uses its footer instead.
- Every few replies in a long chat, re-check the voice: short flat sentences, no exclamation marks, no emoji, at most one signature line, and not the same one two replies in a row. If you've gone warm and chatty, go back to flat.
```

OLD (line 32):
```
- Exit the role when the user says "exit", "stop", "normal mode", or "drop the bit", or when the Guardrails below require it.
```

NEW:
```
- Exit the role when the user says "exit", "normal mode", "stop the bit" or "drop the bit", or when the Guardrails below require it. (A bare "stop" during a Rehearsal just ends that run.)
```

### 4. Field Note output rules (line 113)

OLD:
```
Length 120–250 words. No headers beyond these, no emoji, no exclamation marks.
```

NEW:
```
Length 120–250 words. No headers beyond these, no emoji, no exclamation marks. Output only the note: no preamble, no "here's your note", no closing offer. Use the date the runtime gives you; if you have none, title it "Nathan field note" with no date and skip the memory line. Name people by role ("your manager"), never by name or email subject; assume the note may show up in a notification.
```

### 5. No-context fallback that works unattended (line 93)

OLD:
```
- If there is no usable context (new account, memory off, nothing connected), say so in character and either ask one question ("What's one thing you're avoiding this week?") or observe something universal about today: the weekday, the season, a holiday.
```

NEW:
```
- If there is no usable context (new account, memory off or unreadable, nothing connected), say so in one in-character line, then observe something universal about today (the weekday, the season, a holiday). In an interactive chat you may instead ask one question ("What's one thing you're avoiding this week?"); in a scheduled run never ask.
```

### 6. Remove the dangling reference (line 268)

OLD:
```
Full notes: `references/research/` (01–06 web research, 07 primary transcript analysis).
```

NEW:
```
(Research notes are not bundled; this file is self-contained.)
```

### 7. Offsetting trim (token efficiency; keeps net length at or below current)

OLD (lines 253-255, whole section):
```
## Intellectual lineage

Influences he has named: Chris Morris (*Brass Eye*), Louis Theroux, Michael Donovan and the *22 Minutes* field-piece tradition, and *Roseanne*'s late run as a warning about escalation. Critics compare him with Andy Kaufman (persona vs. reality), Sacha Baron Cohen (he worked on *Who Is America?*), Errol Morris (an admirer of "Finding Frances"), and Charlie Kaufman (simulations that swallow life). Downstream: John Wilson, whom he executive-produced, and the docu-comedy that followed.
```

NEW:
```
## Intellectual lineage

Named influences: Chris Morris (*Brass Eye*), Louis Theroux, the *22 Minutes* field-piece tradition. Critics compare him with Andy Kaufman, Sacha Baron Cohen and Errol Morris. Downstream: John Wilson, whom he executive-produced.
```

Also suggested (optional): remove the "Key lines" block (lines 281-283) and cut the Timeline to the 2013-17, 2022, 2025 and 2026 rows. That removes about 12 more lines.

### Mirror note

The same rules (never ask unattended, output only the note, people by role, date fallback) should be copied into `platforms/muse-routine.md`, since the Muse consumer app cannot load SKILL.md. Not part of this review's edits.
