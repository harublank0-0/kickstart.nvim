# Diffview & Octo quick reference

Leader and local leader are both `Space`. Shortcuts below use normal mode.

## Diffview — review local and branch changes

| Shortcut | Action |
|---|---|
| `Space g d` | Open changed files and diffs |
| `Space g e` | Focus the changed-files sidebar |
| `Space g q` | Close Diffview |
| `j` / `k`, then `Enter` | Select a file in the sidebar |
| `Tab` / `Shift-Tab` | Next / previous file |
| `]c` / `[c` | Next / previous changed block in a diff pane |
| `s` | Stage / unstage the selected file in the sidebar |
| `R` | Refresh the sidebar |
| `g?` | Show shortcuts |

Daily: `Space g d` → inspect changes → edit the working-tree pane and `:w` → stage reviewed files → commit with your usual Git workflow.

```vim
:DiffviewOpen --cached                 " Review staged changes
:DiffviewOpen origin/main...HEAD       " Review a PR targeting main
:DiffviewOpen origin/pre-dev...HEAD    " Review branch changes against PR base
:DiffviewOpen origin/main...HEAD --imply-local " Keep working-tree files on the right
:DiffviewFileHistory %                 " Current file's history
:Octo pr diff                          " Show the current PR diff in Octo
```

For a GitHub PR, run `git fetch origin` and `gh pr checkout 123` in your terminal first. Replace `123` with the PR number and `main` or `pre-dev` with the PR's actual target branch. The three dots (`...`) show the complete changes introduced by the PR since it diverged from that target branch.

## Octo — GitHub PRs, comments, and reviews

| Shortcut / command | Action |
|---|---|
| `Space o p` | Browse PRs; `Enter` opens one |
| `Space o r` | Start / resume review of the open PR or current branch |
| `Space o a` | Show Octo actions |
| `]q` / `[q` | Next / previous file during review |
| `Space c a` | Add a review comment; also works on visually selected lines |
| `Space s a` | Add a code suggestion during review |
| `:Octo review submit` | Open the review submission form |
| `:Octo review close` | Close review and return to PR |

Review: `Space o p` → `Enter` → `Space o r` → inspect files → add comments and `:w` → `:Octo review submit`.

In the submission form, write a summary, return to normal mode, then:
- `Ctrl-m`: submit a comment-only review
- `Ctrl-a`: approve
- `Ctrl-r`: request changes

**Octo's `:w` syncs comment edits to GitHub.** Review comments remain pending until you submit the review.

Open a specific PR: `:Octo https://github.com/OWNER/REPO/pull/123`.
Troubleshoot: `:checkhealth octo` (requires authenticated `gh`).
