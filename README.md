# nathan-for-everyone

A Nathan Fielder perspective skill, distilled with [Nuwa (女娲)](https://github.com/alchaincyf/nuwa-skill) from his shows, transcripts and interviews. It gives Nathan-style observations, literal-loophole plans and conversation rehearsals. It can be called explicitly, or run on a schedule by an always-on agent (Claude Duet, OpenAI Dots, Meta Muse) to write a "field note" about your week from your memory and context.

It's an impression built from his public work, not Nathan Fielder.

## What's here

| Path | What it is |
|---|---|
| [`nathan-fielder-perspective/SKILL.md`](nathan-fielder-perspective/SKILL.md) | The skill: one portable file, with only `name` + `description` in the frontmatter |
| `nathan-fielder-perspective/references/research/` | Nuwa research notes: 01–06 from the web, 07 from transcripts and interviews (analysis only, no transcript copies) |
| [`platforms/README.md`](platforms/README.md) | How to install and schedule it on Claude Code, Claude Duet, OpenAI Dots and Meta Muse |
| [`platforms/muse-routine.md`](platforms/muse-routine.md) | Paste-in version for apps that can't load skills |
| `tests/` | Nuwa phase 4–5 test runs and review |
| `scripts/package.sh` | Builds `dist/nathan-fielder-perspective.zip` for claude.ai / ChatGPT upload |
| `scripts/link-claude-code.sh` | Symlinks the skill into `~/.claude/skills` |

## Modes

- **Ask:** "What would Nathan Fielder do about my roommate?"
- **Plan:** "Nathan for You this: my food truck gets no customers on Mondays."
- **Rehearsal:** "Rehearse asking my boss for a raise." It builds a branching flowchart and plays the other person.
- **Field Note:** a scheduled run, or "Nathan, observe." It reads your memory and context, writes one deadpan observation with a plan, a rehearsal and one sincere line, and saves a one-line note so it doesn't repeat itself. Read-only: it never sends, books or buys anything.

## Quick start

```bash
scripts/link-claude-code.sh   # Claude Code (already done on this machine)
scripts/package.sh            # ZIP for claude.ai (Duet) and ChatGPT (Dots)
```

Then follow [`platforms/README.md`](platforms/README.md) for each platform's upload and schedule steps.

## License

[MIT](LICENSE) for the original text and scripts in this repo. Short quotes from the shows, interviews and criticism in the research notes belong to their owners. This is an unofficial impression, not affiliated with or endorsed by Nathan Fielder or his networks. Built with [Nuwa](https://github.com/alchaincyf/nuwa-skill) (MIT).
