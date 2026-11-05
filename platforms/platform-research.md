# Platform research: custom Agent Skills on Claude Duet, OpenAI Dots, Meta Muse

Researched 2026-11-04. Tags: [official] = vendor docs/help/product pages; [third-party] = blogs/reviews; [unverified] = inferred or contradicted. Several vendor pages could not be fetched (help.openai.com returned 403), so some "official" facts come from search-snippet summaries of those pages and are marked as such.

## Baseline: Claude.ai skill format (the reference format)

- Skill = folder named after the skill, with required `SKILL.md`; optional `references/`, `assets/`, `scripts/`. [official] https://claude.com/docs/skills/how-to
- Frontmatter: both `name` and `description` required. `name`: lowercase letters, numbers, hyphens only, max 64 chars, must match the directory name. `description`: max 1,024 chars (Agent Skills spec limit). [official] https://claude.com/docs/skills/how-to
- A web search summary claimed claude.ai caps descriptions at 200 chars; the official how-to page says 1,024. Treat the 200 claim as wrong. [unverified]
- Keep SKILL.md under 500 lines; move detail to separate files. [official] https://claude.com/docs/skills/how-to
- Upload as a ZIP whose top level is the skill directory (`my-skill.zip` -> `my-skill/SKILL.md`). A SKILL.md at the zip root is not recognized. Build with `zip -r my-skill.zip my-skill/`, check with `unzip -l`. [official] https://claude.com/docs/skills/how-to
- After upload, turn the skill on at Customize > Skills (claude.ai/customize/skills). [official] https://claude.com/docs/skills/how-to
- Third-party summary: upload is under Settings > Features on Pro/Max/Team/Enterprise with code execution enabled. Newer official wording is Customize > Skills. [third-party] https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview
- Other frontmatter fields: the how-to lists only name and description; `skills-ref validate` flags "a frontmatter field the specification doesn't define". Safest to use only these two. [official] https://claude.com/docs/skills/how-to

---

## 1. Claude Duet (Anthropic)

**a) Custom skills?** Yes via inheritance, confidence medium-high. No Duet-specific upload path.
- "Skills you've set up in Claude are available from your first Claude Duet message." [official] https://support.claude.com/en/articles/17631495-get-started-with-claude-duet
- The article does not explain how to create or edit skills in Duet. Do it in claude.ai (Customize > Skills, ZIP upload as above). [official] same URL
- Duet also supports plugins and can suggest them. [official] same URL
- Launch coverage repeats that Duet brings over "account memory, skills and existing app connections". [third-party] https://venturebeat.com/technology/anthropics-answer-to-muse-is-here-claude-duet-a-mobile-and-desktop-ai-agent-that-takes-actions-proactively
- Not documented: whether every uploaded skill (e.g., ones needing code execution) works in Duet's cloud environment. [unverified]

**b) Frontmatter limits:** same as the Claude.ai baseline above (name <=64, lowercase/digits/hyphens, matches folder; description <=1,024; only these two fields). [official] https://claude.com/docs/skills/how-to

**c) Recurring runs**
- Support article describes no user-configurable schedule in Duet; only the morning brief (reviews email and calendar, drafts first steps) and periodic background check-ins at set intervals, which count toward usage limits. Users can adjust subjects flagged and update frequency per launch coverage. [official] https://support.claude.com/en/articles/17631495-get-started-with-claude-duet ; [third-party] VentureBeat URL above.
- Duet has a Tasks tab to review tasks. [official] same support URL
- One early review reports Duet scheduled tasks cannot use custom connectors. [third-party] https://superpowerdaily.com/posts/anthropic-opens-claude-duet-preview-for-ai-work-that-keeps-going-between-chats (single reviewer; unverified)
- Whether the morning brief or check-ins invoke a user skill is undocumented. [unverified]
- Fallback: Claude scheduled tasks (Cowork / new Claude experience). Create: Cowork > "Scheduled" in sidebar > New task > "Create with Claude" or "Set up manually" (name, prompt, approval mode, frequency, optional model/folder); in the new Claude experience describe the task and cadence in a conversation and click "Schedule". Frequencies: hourly, daily, weekly, weekdays, manual. Runs remotely even if the computer is asleep, except tasks needing local files/apps. All paid plans. Scheduled tasks have the same capabilities as regular Cowork tasks, including connected tools, skills and plugins. The article does not mention memory access. [official] https://support.claude.com/en/articles/13854387-schedule-recurring-tasks-in-cowork (older versions of this article said the computer must be awake; the current one says remote; [unverified] which applies to a given account)

**d) User context and saving**
- Runs on the user's Claude account: Claude memory applies; searches Duet chats and Claude chats outside projects ("Search and reference chats" in Settings > Your Claude, can be turned off). Connectors (Gmail, Calendar, Drive, Slack with limits, QuickBooks, HubSpot, Docusign, Calendly; no Microsoft 365 yet; cloud browser for sites without a connector). Disconnecting an app keeps memory of past info. [official] https://support.claude.com/en/articles/17631495-get-started-with-claude-duet
- Duet "can read your Claude work but can't change it"; cannot see local files or all projects. [official] same URL
- How a skill saves to memory: no documented memory-write API. Practical: instruct the skill to tell the agent "remember that ..." in natural language (relies on Claude memory behavior). [unverified]. For reliable state use a connector-backed store (Drive doc, Notion, etc.). [unverified]

**e) Equivalents if skills fail:** personal preferences / project instructions (always loaded) per the Claude how-to note; Cowork scheduled task prompt itself. [official] https://claude.com/docs/skills/how-to . Size limits not found. [unverified]

**Availability:** research preview, US, Pro/Max/Ultra, waitlist; not Team/Enterprise; shares plan usage limits; no model choice. [official] same support URL

---

## 2. OpenAI Dots / ChatGPT

**a) Custom skills?** Yes in ChatGPT generally (partial/uncertain for dots specifically), confidence medium.
- ChatGPT skills: skill = directory with required `SKILL.md`; optional `scripts/`, `references/`, `assets/`, `agents/openai.yaml`. Standalone skills appear under Skills in the desktop app sidebar; invoke with `@` or `$skill-name` (desktop). `@skill-creator` exists in ChatGPT Work. [official] https://learn.chatgpt.com/docs/build-skills
- Upload UI per third-party guides: sidebar Plugins > Skills tab > Create > "Upload from your computer"; uploads are scanned (Ready / Needs Review / Blocked). Plans: eligible Business, Enterprise, Healthcare, Edu (admin-controlled on Enterprise/Edu); a personal plan may not show the Skills tab. [third-party] https://www.lilachbullock.com/how-to-use-skills-in-chatgpt/ , https://support.csuchico.edu/TDClient/1984/Portal/KB/Article/115443/ChatGPT-Skills . No official page found for the exact UI; Pro availability [unverified].
- Zip: API docs say upload a .zip containing a single top-level folder; max 50 MB zip, 500 files, 25 MB uncompressed per file; exactly one SKILL.md (case-insensitive). These are API limits; applicability to ChatGPT UI [unverified]. [official] https://developers.openai.com/api/docs/guides/tools-skills
- Dots: the help article (via summary) mentions local skills only as usable once local machine access is enabled (off by default); no general skills feature for dots described. [third-party summary of official] https://www.datacamp.com/blog/openai-dots ; official page https://help.openai.com/en/articles/20001530-getting-started-with-your-dot (403 to fetcher; a search summary says a dot starts from ChatGPT memory). Whether a dot can load account-level ChatGPT skills is [unverified].
- Muse Code and ChatGPT both read plain SKILL.md, so one file can work across.

**b) Frontmatter:** `name` and `description` required; no character limits stated in ChatGPT docs; advice: concise description with key use case and trigger words first. `agents/openai.yaml` optional (UI metadata, `allow_implicit_invocation` default true, tool deps). [official] https://learn.chatgpt.com/docs/build-skills . A community report: minimal zip failed with name/description mismatch in dashboard chat; keep name == folder name. [third-party] https://community.openai.com/t/does-dashboard-chat-currently-support-skills/1374792
- Skills list budget: initial skill list uses ~2% of context or 8,000 chars (Codex); descriptions get shortened first when many skills. [official] https://learn.chatgpt.com/docs/build-skills (stated for Codex)

**c) Recurring runs**
- Create by asking ChatGPT in chat (describe work, schedule, new chat per run vs return to current chat) or via the Scheduled view on web/desktop. Custom cadences via RRULE. Event triggers (Gmail, Slack, GitHub) on web/mobile. [official] https://learn.chatgpt.com/docs/automations
- Scheduled tasks "can also use skills"; a skill can create or update a scheduled task. Standalone tasks start a new chat each run; in-chat tasks keep the chat context. Page doesn't mention memory for scheduled tasks. [official] same URL
- Dots: schedule work directly (e.g., morning calendar review); Scheduled tab in dot profile shows active/paused/completed; reset deletes tasks. [official] https://help.openai.com/en/articles/20001530-getting-started-with-your-dot (via search summary) ; [third-party] DataCamp URL above
- Dot setup needs desktop app or desktop web. Pro (not EEA/CH/UK) and Business Premium; Enterprise/Edu beta by admin. [third-party] DataCamp

**d) Context and saving**
- Dot inherits ChatGPT memories, forms its own (including from connected apps), 4,000+ app plugins, reachable in ChatGPT/Slack/Teams. Deleting a dot's own memories requires deleting the dot. [official summary] help URL ; [third-party] DataCamp
- Scheduled-run memory use undocumented; advice from one blog: put procedure in the skill, state in an external store. [third-party] https://www.memorylake.ai/en/blogs/stop-chatgpt-scheduled-tasks-starting-over
- Saving: dot "notes to itself" exist per DataCamp. Instruct the skill to "remember ..." and/or keep a state file/doc via a connector. [unverified]

**e) Equivalents:** ChatGPT custom instructions / Projects (not researched in official docs; limits [unverified]); dot Custom Rules (act/ask/hand off behaviors) govern autonomy, not content. [third-party] DataCamp. Putting the whole procedure in the scheduled task prompt works as a fallback.

---

## 3. Meta Muse

**a) Custom skills?** Consumer Muse: No (confidence medium-high). Muse Code: Yes.
- Meta's help center documents only one skill (the built-in "forget" skill); no custom skill install. [official] https://www.meta.com/help/artificial-intelligence/2225571704857152/
- Third-party: no way to upload SKILL.md in the consumer app; Meta has not announced one; workaround is pasting/attaching instructions in a chat (reported to work in a test) or saving a pasted workflow when Muse offers (undocumented, persistence unknown). [third-party] https://metaflow.life/blog/how-to-create-meta-muse-skills , https://www.aiagentslibrary.com/blog/meta-muse-skills/
- Muse Code (developer agent): discovers skills in `<repo>/.agents/skills/<skill-id>/SKILL.md`, `~/.agents/skills`, `$XDG_CONFIG_HOME/muse/skills`, `~/.claude/skills`, `$CODEX_HOME/skills` (or `~/.codex/skills`), plus repo `.claude/skills`/`.codex/skills`. Install: `muse skills validate ./my-skill`, `muse skills install ./my-skill --scope user`, `muse skills enable <id> --scope project`, `muse skills import --from claude|codex`, `muse skills list|inspect`. [official] https://dev.meta.ai/docs/muse-code/extending
- Muse Code is a coding agent; it does not appear to be the consumer agent that reads Memory.md. [unverified]

**b) Frontmatter:** Meta's docs do not list fields, name rules, or description limits; use `muse skills validate`. [official] https://dev.meta.ai/docs/muse-code/extending (silent). Claude format is accepted via import, so assume the standard spec. [unverified]

**c) Recurring runs**
- Scheduled tasks and reminders exist; view under Assistant icon > Upcoming; change/delete by asking Muse in chat. Creation presumably by asking in chat. [official] https://www.meta.com/help/artificial-intelligence/2225571704857152/
- Goals tab: goals used to track progress and send check-ins; delete via three-dot menu. Editing not described. [official] same URL
- Whether a scheduled run can use pasted/saved instructions or read memory is undocumented. [unverified]. Muse Code docs don't cover scheduling. [official] https://dev.meta.ai/docs/muse-code/configuration

**d) Context and saving**
- Files editable in-app: Memory.md (Assistant > Identity > Memory), Soul.md (core truths, boundaries, personality), Identity.md; Goals; chat history; connector data; artifacts/system files in Library. [official] https://www.meta.com/help/artificial-intelligence/2225571704857152/
- Saving: information shared "may be saved" to Memory.md; ask Muse in chat ("remember ..."). Deleting is best-effort. [official] same URL
- Muse Code: instructions from `AGENTS.md`, `CLAUDE.md`, `.agents/AGENTS.md`, `.claude/CLAUDE.md` (first per directory wins); project memory in `<repo>/.agents/memory/` with `MEMORY.md` index (index injects up to 48 files). [official] https://dev.meta.ai/docs/muse-code/configuration

**e) Equivalents:** consumer Muse: Soul.md/Memory.md (editable), Goals, Library instruction blocks; a 5-part instruction block (Task, Trigger, Approval gate, Output format, Boundaries). [third-party] https://metaflow.life/blog/how-to-create-meta-muse-skills . Size limits: none documented. [unverified]

---

## Recommended setup

### Claude Duet
1. Install:
   1. Make folder `my-skill/` with `SKILL.md` (name = folder name, lowercase-hyphen; description <=1,024 chars), optional `references/`.
   2. `cd` to parent; `zip -r my-skill.zip my-skill/`; `unzip -l my-skill.zip` and confirm every entry starts with `my-skill/`.
   3. claude.ai > Customize > Skills > upload the ZIP; toggle on.
   4. Open Claude Duet (same account); skill is available from the first message. Test by naming the skill in a message.
2. Schedule:
   - Preferred: in claude.ai (new Claude experience) or Cowork, describe the task ("Every weekday 8am, use the my-skill skill and ...") then click Schedule; or Cowork > Scheduled > New task > Set up manually, frequency Daily/Weekdays/Weekly. Reference the skill by name in the prompt.
   - Duet itself: morning brief and check-ins only; adjust topics in Duet. Cannot confirm a custom schedule there.

### OpenAI Dots / ChatGPT
1. Install:
   1. Same folder layout; for ChatGPT, keep one top-level folder in the ZIP, name matches folder.
   2. ChatGPT desktop/web > Plugins (sidebar) > Skills tab > Create > Upload from your computer; wait for scan (resolve "Needs Review").
   3. Verify by typing `@` (or `$skill-name` in desktop) in a chat. If the Skills tab is missing, the plan/workspace may not allow it; fallback: paste the SKILL.md body into the scheduled-task prompt.
   4. For a dot: enable skills access if prompted (local skills require local machine access, off by default); otherwise ask the dot to follow the skill.
2. Schedule:
   - In chat or in the dot: "Every weekday at 8am run $my-skill and send me the result"; choose standalone (new chat per run) vs in-chat (keeps context). Manage in Scheduled (web/desktop) or the dot profile's Scheduled tab. Advanced cadence via RRULE.

### Meta Muse
1. Install:
   - Muse Code: `muse skills validate ./my-skill && muse skills install ./my-skill --scope user` (or place in `<repo>/.agents/skills/my-skill/SKILL.md`, or `muse skills import --from claude`).
   - Consumer Muse (no skill install): paste the SKILL.md body (trimmed) into chat and ask "Save this as a routine"; or put a short pointer in Memory.md/Soul.md (Assistant > Identity > Edit) such as "When I say 'run my brief', follow these steps: ..."; add a recurring Goal in the Goals tab.
2. Schedule:
   - Consumer Muse: ask in chat "Every Monday at 10am, do <routine from Memory.md>"; check under Assistant > Upcoming. Execution with saved routine is [unverified]; test it.
   - Muse Code: no documented scheduler; use OS cron calling the CLI [unverified].

---

## Lowest common denominator: constraints for one portable SKILL.md

1. Folder named exactly as `name`; `name` lowercase letters/digits/hyphens, <=64 chars.
2. Frontmatter with only `name` and `description` (no other fields; `agents/openai.yaml` is optional and ignorable).
3. `description` <=1,024 chars (Claude, spec); preferably <=300 and front-load trigger words, since ChatGPT shortens descriptions when many skills load (8,000-char budget).
4. Body under 500 lines; self-contained enough to paste into a prompt (Muse consumer has no install; Duet/ChatGPT may only read SKILL.md). Put long material in `references/` but include a short inline fallback.
5. ZIP with a single top-level folder containing SKILL.md (Claude and OpenAI both require this); <50 MB, <500 files; no credentials in files.
6. No scripts or code-execution dependency; use plain instructions and connector/tool use described generically ("calendar tool", "email tool"), because connector sets and custom-connector support differ.
7. Scheduled runs may start fresh with no chat context: write the skill so each run is self-contained, state in the skill what memory/context to read ("use account memory and recent chats if available"), and degrade gracefully if unavailable.
8. Avoid repeating itself: end with an instruction to save a short "last run" note via the platform's memory ("remember that ...") AND state a fallback (ask user / read a note in a connected doc). No platform documents a deterministic memory-write API.
9. Don't rely on slash/`@`/`$` invocation syntax; say "use the <name> skill" in the task prompt (Claude: name it; ChatGPT: `$name`/`@name`; Muse: paste/follow).
10. Include approval gates (draft, don't send) since all three agents handle sensitive actions via approval rules, and scheduled runs are unattended.
