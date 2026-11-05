# Installing and scheduling on Claude Code, Claude Duet, OpenAI Dots and Meta Muse

The skill lives in [`../nathan-fielder-perspective/`](../nathan-fielder-perspective/SKILL.md). It is one portable `SKILL.md` (Agent Skills standard: only `name` + `description` in the frontmatter, body under 500 lines, no scripts), so the same folder works everywhere that loads skills. Meta's consumer Muse app cannot load skills, so it gets a paste-in routine instead.

Platform facts below come from [platform-research.md](platform-research.md) (researched 2026-11-04). Items marked **unverified** are not covered by vendor docs. Test them once before relying on them.

Build the upload ZIP first (needed for claude.ai and ChatGPT):

```bash
scripts/package.sh
```

This writes `dist/nathan-fielder-perspective.zip`, with a single top-level folder as both vendors require.

---

## The scheduled prompt (same text everywhere)

Paste this as the task/prompt for any recurring run:

> Use the nathan-fielder-perspective skill in Field Note mode. Look at what you know about me (memory, recent chats, and today's calendar or email if connected) and write today's Nathan Fielder field note. Read only; don't send, book, buy or contact anyone. Afterwards, remember one line: "Nathan field note <date>: <topic>", so future notes don't repeat it.

Suggested cadence: weekdays at 8:30, or 2–3 times a week if daily feels like too much Nathan.

---

## Claude Code (this machine)

Already installed. `scripts/link-claude-code.sh` symlinks the skill into `~/.claude/skills/`, so edits in this repo apply live.

- Explicit: "what would Nathan Fielder do about …", "give me a Nathan plan for …", "rehearse this conversation with me, Nathan-style", "/nathan-fielder-perspective".
- Scheduled (optional): in the Claude desktop app, create a scheduled task with the prompt above.

## Claude Duet (Anthropic)

Duet inherits skills, memory and connectors from your claude.ai account.

1. Install: claude.ai → **Customize → Skills** → upload `dist/nathan-fielder-perspective.zip` → toggle on.
2. Explicit: in Duet, say "Use the nathan-fielder-perspective skill: …".
3. Scheduled:
   - Duet has no user-defined schedule of its own, only its morning brief and periodic check-ins. Ask Duet: "In my morning brief, add a Nathan Fielder field note using the nathan-fielder-perspective skill." **Unverified** whether the brief calls a skill. Check the next morning.
   - Documented fallback: a Claude scheduled task. In claude.ai or Cowork, describe the cadence in chat and click **Schedule**, or go to **Scheduled → New task → Set up manually**. Use the prompt above with frequency set to Weekdays. Scheduled tasks can use skills and connectors. **Unverified** whether they read Claude memory.

## OpenAI Dots / ChatGPT

1. Install: ChatGPT → **Plugins → Skills → Create → Upload from your computer** → choose the ZIP and wait for the scan.
   - The Skills tab is confirmed on Business, Enterprise and Edu plans. It may not appear on personal plans.
   - Check it works by typing `$nathan-fielder-perspective` or `@nathan-fielder-perspective` in a chat.
2. Explicit: "$nathan-fielder-perspective what would Nathan do about my landlord?"
3. Scheduled: tell your dot (or any ChatGPT chat) "Every weekday at 8:30am, run $nathan-fielder-perspective in Field Note mode …" (the prompt above). Manage it under **Scheduled**, or in the dot profile's **Scheduled** tab. Scheduled tasks can use skills (documented).
   - **Unverified:** whether a dot loads account-level skills.
   - If it doesn't, paste the contents of [muse-routine.md](muse-routine.md) into the scheduled task instead.

## Meta Muse

The consumer Muse app has no custom-skill install. Use the paste-in routine:

1. Open [muse-routine.md](muse-routine.md), copy everything below its line, paste it into a Muse chat, and say "Save this as my Nathan field note routine."
2. Optional: in **Assistant → Identity → Memory**, add one line: "When I say 'Nathan, observe', run my Nathan field note routine."
3. Schedule: ask Muse "Every weekday at 8:30am, run my Nathan field note routine." Check it under **Assistant → Upcoming**. **Unverified** whether the scheduled run uses the saved routine. If the first run comes out generic, paste the routine into the scheduled request itself.
4. Muse Code (Meta's developer agent) reads `~/.claude/skills`, so the symlinked skill works there unchanged. You can also run `muse skills import --from claude`.
