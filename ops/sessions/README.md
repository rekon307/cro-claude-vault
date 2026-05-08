# sessions/

Session transcripts auto-archived by the SessionEnd hook. Each session has:

- `{started}.json` - metadata (id, started, ended, status, seed_candidate flag, transcript_path symlink)
- A symlink to the JSONL transcript in `~/.claude/projects/`

Substantive sessions get `seed_candidate: true`. `/next` surfaces them so the user can run `/seed {session-id}` to mine the transcript for tasks the agent should have captured but did not.

This folder is empty in the demo vault. Active vaults accumulate 5-20 session files per week.
