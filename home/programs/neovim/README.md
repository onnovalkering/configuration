# Keybindings

Leader key: `Space`

---

## Navigation

### Basic Movement

| Key              | Mode | Action                                         |
| ---------------- | ---- | ---------------------------------------------- |
| `h` `j` `k` `l`  | n    | Left / Down / Up / Right                       |
| `w`              | n    | Next word start                                |
| `b`              | n    | Previous word start                            |
| `e`              | n    | Next word end                                  |
| `ge`             | n    | Previous word end                              |
| `W` `B` `E` `gE` | n    | Same as above, but WORD (whitespace-delimited) |
| `0`              | n    | Start of line                                  |
| `^`              | n    | First non-blank character                      |
| `$`              | n    | End of line                                    |
| `gg`             | n    | First line                                     |
| `G`              | n    | Last line                                      |
| `{`              | n    | Previous blank line (paragraph)                |
| `}`              | n    | Next blank line (paragraph)                    |
| `%`              | n    | Matching bracket                               |
| `H` `M` `L`      | n    | Screen top / middle / bottom                   |
| `<C-d>`          | n    | Scroll half-page down (centered)               |
| `<C-u>`          | n    | Scroll half-page up (centered)                 |
| `<C-f>`          | n    | Scroll full page forward                       |
| `<C-b>`          | n    | Scroll full page backward                      |

### Flash (Enhanced Motions)

| Key             | Mode    | Action                                                |
| --------------- | ------- | ----------------------------------------------------- |
| `s`             | n, x, o | Flash jump (type chars, pick label)                   |
| `S`             | n, x, o | Flash treesitter (select node by label)               |
| `r`             | o       | Flash remote (operator-pending from another location) |
| `R`             | x, o    | Flash treesitter search                               |
| `f` `F` `t` `T` | n, x, o | Enhanced with jump labels (Flash char mode)           |
| `;` `,`         | n       | Repeat f/F/t/T forward / backward                     |
| `<C-s>`         | c       | Toggle Flash in search mode                           |

### Search

| Key     | Mode | Action                            |
| ------- | ---- | --------------------------------- |
| `/`     | n    | Search forward                    |
| `?`     | n    | Search backward                   |
| `n`     | n    | Next result (centered)            |
| `N`     | n    | Previous result (centered)        |
| `*`     | n    | Search word under cursor forward  |
| `#`     | n    | Search word under cursor backward |
| `<Esc>` | n    | Clear search highlight            |

### Jumps & Marks

| Key          | Mode | Action                            |
| ------------ | ---- | --------------------------------- |
| `<C-o>`      | n    | Jump back in jumplist             |
| `<C-i>`      | n    | Jump forward in jumplist          |
| `m{a-z}`     | n    | Set mark                          |
| `` `{a-z} `` | n    | Jump to mark (exact position)     |
| `'{a-z}`     | n    | Jump to mark (line start)         |
| ` `` `       | n    | Jump to position before last jump |

---

## File Management

### File Explorer (Oil)

| Key         | Mode | Action                      |
| ----------- | ---- | --------------------------- |
| `<leader>e` | n    | Open file explorer (buffer) |
| `<leader>E` | n    | Open file explorer (float)  |

Inside Oil:

| Key     | Action                   |
| ------- | ------------------------ |
| `<CR>`  | Open file/directory      |
| `<BS>`  | Go to parent directory   |
| `<C-v>` | Open in vertical split   |
| `<C-s>` | Open in horizontal split |
| `<C-t>` | Open in new tab          |
| `<C-p>` | Preview file             |
| `<C-c>` | Close                    |
| `g.`    | Toggle hidden files      |
| `gs`    | Change sort              |
| `gx`    | Open with system app     |
| `g?`    | Show help                |

### Harpoon (Fast File Switching)

| Key               | Mode | Action                           |
| ----------------- | ---- | -------------------------------- |
| `<leader>ha`      | n    | Add current file to Harpoon      |
| `<leader>hh`      | n    | Toggle Harpoon menu              |
| `<leader>h1`-`h5` | n    | Jump to Harpoon file 1-5         |
| `<leader>hp`      | n    | Previous Harpoon file            |
| `<leader>hn`      | n    | Next Harpoon file                |
| `<leader>fe`      | n    | Browse Harpoon files (Telescope) |

### Telescope (Fuzzy Finder)

| Key          | Mode | Action                         |
| ------------ | ---- | ------------------------------ |
| `<leader>ff` | n    | Find files                     |
| `<leader>fg` | n    | Live grep (search content)     |
| `<leader>fw` | n    | Grep word under cursor         |
| `<leader>fb` | n    | Find buffers                   |
| `<leader>fr` | n    | Recent files                   |
| `<leader>fh` | n    | Find help tags                 |
| `<leader>fc` | n    | Colorschemes                   |
| `<leader>fk` | n    | Search keymaps                 |
| `<leader>fd` | n    | Search diagnostics             |
| `<leader>fn` | n    | New file (empty buffer)        |
| `<leader>/`  | n    | Fuzzy search in current buffer |

Inside Telescope:

| Key     | Action              |
| ------- | ------------------- |
| `<C-j>` | Move selection down |
| `<C-k>` | Move selection up   |
| `<Esc>` | Close               |
| `<CR>`  | Confirm selection   |

---

## Editing

### Core Editing

| Key          | Mode | Action                             |
| ------------ | ---- | ---------------------------------- |
| `i`          | n    | Insert before cursor               |
| `I`          | n    | Insert at line start               |
| `a`          | n    | Insert after cursor                |
| `A`          | n    | Insert at line end                 |
| `o`          | n    | New line below + insert            |
| `O`          | n    | New line above + insert            |
| `r`          | n    | Replace single character           |
| `R`          | n    | Replace mode                       |
| `c{motion}`  | n    | Change (delete + insert)           |
| `C`          | n    | Change to end of line              |
| `cc`         | n    | Change entire line                 |
| `d{motion}`  | n    | Delete                             |
| `D`          | n    | Delete to end of line              |
| `dd`         | n    | Delete entire line                 |
| `x`          | n    | Delete character under cursor      |
| `J`          | n    | Join lines (cursor stays in place) |
| `u`          | n    | Undo                               |
| `<C-r>`      | n    | Redo                               |
| `.`          | n    | Repeat last change                 |
| `~`          | n    | Toggle case of character           |
| `gu{motion}` | n    | Lowercase                          |
| `gU{motion}` | n    | Uppercase                          |

### Yank & Paste (Yanky Enhanced)

| Key          | Mode | Action                                             |
| ------------ | ---- | -------------------------------------------------- |
| `y{motion}`  | n    | Yank (copy)                                        |
| `yy`         | n    | Yank line                                          |
| `Y`          | n    | Yank to end of line                                |
| `p`          | n, x | Paste after (Yanky enhanced)                       |
| `P`          | n, x | Paste before (Yanky enhanced)                      |
| `gp`         | n, x | Paste after, cursor after pasted text              |
| `gP`         | n, x | Paste before, cursor after pasted text             |
| `<C-p>`      | n    | Cycle yank ring backward (after paste)             |
| `<C-n>`      | n    | Cycle yank ring forward (after paste)              |
| `<leader>sy` | n    | Browse yank history (Telescope)                    |
| `<leader>p`  | x    | Paste over selection without yanking replaced text |
| `<leader>x`  | n, v | Delete without yanking (black hole register)       |

### Indenting & Moving Lines

| Key     | Mode | Action                        |
| ------- | ---- | ----------------------------- |
| `<`     | v    | Indent left (stay in visual)  |
| `>`     | v    | Indent right (stay in visual) |
| `>>`    | n    | Indent line right             |
| `<<`    | n    | Indent line left              |
| `<A-j>` | n    | Move line down                |
| `<A-k>` | n    | Move line up                  |
| `<A-j>` | v    | Move selection down           |
| `<A-k>` | v    | Move selection up             |

### Surround (mini.surround)

| Key             | Mode | Action                                                |
| --------------- | ---- | ----------------------------------------------------- |
| `gsa{char}`     | n    | Add surrounding (e.g. `gsaiw"` wraps word in quotes)  |
| `gsd{char}`     | n    | Delete surrounding (e.g. `gsd"` removes quotes)       |
| `gsr{old}{new}` | n    | Replace surrounding (e.g. `gsr"'` changes `"` to `'`) |
| `gsf{char}`     | n    | Find next surrounding                                 |
| `gsF{char}`     | n    | Find previous surrounding                             |
| `gsh{char}`     | n    | Highlight surrounding                                 |

### Completion (blink.cmp)

| Key         | Mode | Action                     |
| ----------- | ---- | -------------------------- |
| `<C-space>` | i    | Show / toggle docs         |
| `<C-e>`     | i    | Dismiss completion         |
| `<CR>`      | i    | Accept completion          |
| `<Tab>`     | i    | Snippet next / select next |
| `<S-Tab>`   | i    | Snippet prev / select prev |
| `<C-j>`     | i    | Select next item           |
| `<C-k>`     | i    | Select previous item       |
| `<C-d>`     | i    | Scroll docs down           |
| `<C-u>`     | i    | Scroll docs up             |

### Formatting

| Key          | Mode | Action                            |
| ------------ | ---- | --------------------------------- |
| `<leader>lf` | n, v | Format buffer/selection (conform) |

Format-on-save is enabled automatically (500ms timeout, LSP fallback).

---

## Text Objects & Selections

### Built-in Text Objects

| Key                 | Mode | Action                       |
| ------------------- | ---- | ---------------------------- |
| `iw` / `aw`         | o, x | Inner / around word          |
| `iW` / `aW`         | o, x | Inner / around WORD          |
| `is` / `as`         | o, x | Inner / around sentence      |
| `ip` / `ap`         | o, x | Inner / around paragraph     |
| `i"` / `a"`         | o, x | Inner / around double quotes |
| `i'` / `a'`         | o, x | Inner / around single quotes |
| `` i` `` / `` a` `` | o, x | Inner / around backticks     |
| `i)` / `a)`         | o, x | Inner / around parentheses   |
| `i]` / `a]`         | o, x | Inner / around brackets      |
| `i}` / `a}`         | o, x | Inner / around braces        |
| `it` / `at`         | o, x | Inner / around HTML tag      |

### Treesitter Text Objects

| Key         | Mode | Action                            |
| ----------- | ---- | --------------------------------- |
| `af` / `if` | o, x | Around / inner function           |
| `ac` / `ic` | o, x | Around / inner class              |
| `aa` / `ia` | o, x | Around / inner parameter/argument |

### Treesitter Navigation

| Key         | Mode | Action                         |
| ----------- | ---- | ------------------------------ |
| `]f` / `[f` | n    | Next / previous function start |
| `]F` / `[F` | n    | Next / previous function end   |
| `]c` / `[c` | n    | Next / previous class start    |
| `]C` / `[C` | n    | Next / previous class end      |

### Incremental Selection (Treesitter)

| Key         | Mode | Action                            |
| ----------- | ---- | --------------------------------- |
| `<C-space>` | n    | Start/expand treesitter selection |
| `<BS>`      | x    | Shrink treesitter selection       |

### Git Text Objects

| Key  | Mode | Action          |
| ---- | ---- | --------------- |
| `ih` | o, x | Select git hunk |

---

## LSP (Language Server Protocol)

### Navigation

| Key  | Mode | Action                |
| ---- | ---- | --------------------- |
| `gd` | n    | Go to definition      |
| `gD` | n    | Go to declaration     |
| `gr` | n    | Go to references      |
| `gI` | n    | Go to implementation  |
| `gy` | n    | Go to type definition |

### Information

| Key          | Mode | Action              |
| ------------ | ---- | ------------------- |
| `K`          | n    | Hover documentation |
| `<leader>lh` | n    | Signature help      |

### Actions

| Key          | Mode | Action                        |
| ------------ | ---- | ----------------------------- |
| `<leader>lr` | n    | Rename symbol                 |
| `<leader>la` | n    | Code action                   |
| `<leader>ld` | n    | Line diagnostics (float)      |
| `<leader>ls` | n    | Document symbols (Telescope)  |
| `<leader>lS` | n    | Workspace symbols (Telescope) |

### Diagnostics Navigation

| Key  | Mode | Action              |
| ---- | ---- | ------------------- |
| `]d` | n    | Next diagnostic     |
| `[d` | n    | Previous diagnostic |

### Trouble (Diagnostics Panel)

| Key          | Mode | Action                |
| ------------ | ---- | --------------------- |
| `<leader>xx` | n    | Workspace diagnostics |
| `<leader>xX` | n    | Buffer diagnostics    |
| `<leader>xs` | n    | Symbols               |
| `<leader>xl` | n    | LSP definitions       |
| `<leader>xq` | n    | Quickfix list         |
| `<leader>xL` | n    | Location list         |

### Aerial (Symbol Outline)

| Key          | Mode | Action                |
| ------------ | ---- | --------------------- |
| `<leader>cs` | n    | Toggle symbol outline |

---

## Git

### Telescope Git

| Key          | Mode | Action       |
| ------------ | ---- | ------------ |
| `<leader>gc` | n    | Git commits  |
| `<leader>gs` | n    | Git status   |
| `<leader>gb` | n    | Git branches |

### Gitsigns (Hunks)

| Key           | Mode | Action              |
| ------------- | ---- | ------------------- |
| `]h`          | n    | Next hunk           |
| `[h`          | n    | Previous hunk       |
| `<leader>ghs` | n, v | Stage hunk          |
| `<leader>ghr` | n, v | Reset hunk          |
| `<leader>ghS` | n    | Stage entire buffer |
| `<leader>ghR` | n    | Reset entire buffer |
| `<leader>ghu` | n    | Undo stage hunk     |
| `<leader>ghp` | n    | Preview hunk        |
| `<leader>ghb` | n    | Blame line (full)   |
| `<leader>ghB` | n    | Blame buffer        |
| `<leader>ghd` | n    | Diff this           |
| `<leader>ghD` | n    | Diff this ~         |

### Diffview

| Key           | Mode | Action                                     |
| ------------- | ---- | ------------------------------------------ |
| `<leader>gd`  | n    | Open diff view                             |
| `<leader>gD`  | n    | Close diff view                            |
| `<leader>gfh` | n, v | File history (current file / visual range) |
| `<leader>gfH` | n    | Full repo history                          |

Inside Diffview: press `q` to close.

---

## Debugging (DAP)

### Session Control

| Key          | Mode | Action                     |
| ------------ | ---- | -------------------------- |
| `<F5>`       | n    | Continue / start debugging |
| `<F10>`      | n    | Step over                  |
| `<F11>`      | n    | Step into                  |
| `<F12>`      | n    | Step out                   |
| `<leader>dx` | n    | Terminate session          |
| `<leader>dL` | n    | Run last debug config      |

### Breakpoints

| Key          | Mode | Action                            |
| ------------ | ---- | --------------------------------- |
| `<leader>db` | n    | Toggle breakpoint                 |
| `<leader>dB` | n    | Conditional breakpoint            |
| `<leader>dl` | n    | Log point (message only, no stop) |

### Inspection

| Key          | Mode | Action                   |
| ------------ | ---- | ------------------------ |
| `<leader>dh` | n, v | Hover value under cursor |
| `<leader>dp` | n, v | Preview value            |
| `<leader>df` | n    | Stack frames             |
| `<leader>ds` | n    | Scopes                   |
| `<leader>dr` | n    | Open REPL                |
| `<leader>du` | n    | Toggle DAP UI panels     |

---

## AI (Copilot Chat)

| Key          | Mode | Action                |
| ------------ | ---- | --------------------- |
| `<leader>aa` | n    | Toggle Copilot Chat   |
| `<leader>aa` | v    | Chat on selection     |
| `<leader>ae` | n    | Explain code (buffer) |
| `<leader>ae` | v    | Explain selection     |
| `<leader>ar` | n    | Review code           |
| `<leader>af` | n    | Fix code              |
| `<leader>at` | n    | Generate tests        |
| `<leader>ao` | n    | Optimize code         |

Inside Copilot Chat:

| Key                      | Action             |
| ------------------------ | ------------------ |
| `<CR>` (n) / `<C-s>` (i) | Submit prompt      |
| `q` / `<C-c>`            | Close chat         |
| `<C-l>`                  | Reset conversation |
| `<C-y>`                  | Accept diff        |
| `gd`                     | Show diff          |
| `gj`                     | Jump to diff       |
| `gq`                     | Quickfix diffs     |
| `gy`                     | Yank diff          |
| `gr`                     | Toggle sticky      |
| `gi`                     | Show info          |
| `gc`                     | Show context       |
| `gh`                     | Show help          |

---

## Windows, Buffers & Tabs

### Window Management

| Key                             | Mode | Action                              |
| ------------------------------- | ---- | ----------------------------------- |
| `<leader>-`                     | n    | Horizontal split                    |
| `<leader>\|`                    | n    | Vertical split                      |
| `<leader>wd`                    | n    | Close window                        |
| `<C-h>` `<C-j>` `<C-k>` `<C-l>` | n    | Navigate between windows/tmux panes |
| `<C-Up>`                        | n    | Increase window height              |
| `<C-Down>`                      | n    | Decrease window height              |
| `<C-Left>`                      | n    | Decrease window width               |
| `<C-Right>`                     | n    | Increase window width               |

### Buffers

| Key          | Mode | Action                                  |
| ------------ | ---- | --------------------------------------- |
| `<S-h>`      | n    | Previous buffer                         |
| `<S-l>`      | n    | Next buffer                             |
| `<leader>bd` | n    | Delete buffer (smart, preserves layout) |
| `<leader>bD` | n    | Force delete buffer                     |

### Quickfix & Location List

| Key         | Mode | Action                        |
| ----------- | ---- | ----------------------------- |
| `]q` / `[q` | n    | Next / previous quickfix      |
| `]Q` / `[Q` | n    | Last / first quickfix         |
| `]l` / `[l` | n    | Next / previous location list |

### Terminal

| Key                             | Mode | Action                           |
| ------------------------------- | ---- | -------------------------------- |
| `<Esc><Esc>`                    | t    | Exit terminal mode               |
| `<C-h>` `<C-j>` `<C-k>` `<C-l>` | t    | Navigate from terminal to window |

---

## Misc & UI

### Save & Quit

| Key         | Mode | Action         |
| ----------- | ---- | -------------- |
| `<leader>w` | n    | Save file      |
| `<leader>W` | n    | Save all files |
| `<leader>q` | n    | Quit           |
| `<leader>Q` | n    | Force quit all |

### UI Toggles

| Key          | Mode | Action                  |
| ------------ | ---- | ----------------------- |
| `<leader>uw` | n    | Toggle word wrap        |
| `<leader>us` | n    | Toggle spell check      |
| `<leader>un` | n    | Toggle line numbers     |
| `<leader>ur` | n    | Toggle relative numbers |

### Search & Browse

| Key          | Mode | Action                       |
| ------------ | ---- | ---------------------------- |
| `<leader>sa` | n    | Select all                   |
| `<leader>st` | n    | Search TODOs (Telescope)     |
| `<leader>sT` | n    | TODOs (Trouble panel)        |
| `<leader>sy` | n    | Yank history                 |
| `]t` / `[t`  | n    | Next / previous TODO comment |

### Noice (Notifications & Command Line)

| Key          | Mode | Action                           |
| ------------ | ---- | -------------------------------- |
| `<leader>nl` | n    | Last notification                |
| `<leader>nh` | n    | Notification history             |
| `<leader>nd` | n    | Dismiss all notifications        |
| `<leader>nt` | n    | Browse notifications (Telescope) |

### Command Line

| Key     | Mode | Action        |
| ------- | ---- | ------------- |
| `<C-a>` | c    | Start of line |
| `<C-e>` | c    | End of line   |

---

## Patterns

### The Operator + Motion Formula

Every editing command in Vim follows: **`{operator}{count}{motion/textobject}`**

| Operator    | What it does                  |
| ----------- | ----------------------------- |
| `d`         | Delete                        |
| `c`         | Change (delete + insert mode) |
| `y`         | Yank (copy)                   |
| `v`         | Visually select               |
| `gu` / `gU` | Lowercase / uppercase         |
| `=`         | Auto-indent                   |
| `>` / `<`   | Indent right / left           |
| `gq`        | Format/wrap text              |

### Essential Combos

**Editing speed:**

```
ciw         Change inner word (delete word, start typing)
ci"         Change inside quotes
ci(         Change inside parentheses
ca{         Change around braces (including the braces)
cit         Change inside HTML tag
ct;         Change up to (not including) semicolon
cf)         Change through (including) closing paren

diw         Delete inner word
dap         Delete around paragraph
di]         Delete inside brackets
dt.         Delete to next period
d/foo<CR>   Delete to next "foo"
dG          Delete from here to end of file

yiw         Yank inner word
yi"         Yank inside quotes
yap         Yank around paragraph
y3j         Yank current + 3 lines down
```

**Surgical precision with Flash:**

```
s{2chars}   Jump anywhere visible — type 2 chars, pick label
S           Select a treesitter node by label
vS          Visually select a treesitter node

Using Flash as a motion with operators:
ds{char}{label}  Delete from cursor to flash target
cs{char}{label}  Change from cursor to flash target
ys{char}{label}  Yank from cursor to flash target
              (s triggers Flash in operator-pending mode)
```

**Treesitter text objects (structure-aware):**

```
daf         Delete entire function (including signature)
dif         Delete function body only
yaf         Yank entire function
cif         Rewrite function body
vaf         Select entire function
dac         Delete entire class
via         Select parameter/argument
daa         Delete parameter including comma
```

**Surround combos:**

```
gsaiw"      Surround word with double quotes
gsaiW)      Surround WORD with parentheses
gsa2aw"     Surround 2 words with quotes
gsaaf"      Surround around-function with quotes
gsd"        Delete surrounding double quotes
gsr"'       Replace double quotes with single quotes
gsr({       Replace parens with braces
```

### Power Patterns

**Repeat last change with `.`:**

```
ciw<new word><Esc>   Change a word, then press . on other words
                     to repeat the same replacement
daw                  Delete a word, then . to keep deleting words
gsaiw"               Surround a word, then w. w. w. to surround more
```

**Macros (record + replay):**

```
qa          Start recording macro into register 'a'
<commands>  Do your edits
q           Stop recording
@a          Replay macro 'a'
@@          Replay last macro
10@a        Replay macro 'a' ten times
```

**Registers (named clipboards):**

```
"ayy        Yank line into register 'a'
"ap         Paste from register 'a'
"Ayy        APPEND yank to register 'a' (capital = append)
"+y         Yank to system clipboard
"+p         Paste from system clipboard
"0p         Paste last yank (not delete)
```

**Visual block mode (multi-cursor alternative):**

```
<C-v>       Enter visual block mode
jjj         Select column across lines
I           Insert at start of each selected line
A           Append at end of each selected line
c           Change all selected text
d           Delete column
r{char}     Replace all selected chars
```

**Marks for bookmarking positions:**

```
ma          Set mark 'a' at cursor
`a          Jump back to exact position of mark 'a'
d`a         Delete from cursor to mark 'a'
y`a         Yank from cursor to mark 'a'
```

### Workflows

**Refactoring a variable name:**

```
*           Highlight all occurrences of word under cursor
cgn         Change next occurrence
.           Repeat on next occurrence (skip with n)
```

**Multi-file search & replace:**

```
<leader>fg  Live grep for the pattern
<C-q>       Send results to quickfix list
:cdo s/old/new/g | update
            Replace in all quickfix files
```

**Working with function arguments:**

```
daa         Delete an argument (including comma)
cia         Change an argument
yia         Yank just the argument value
via         Select an argument
```

**Fast file workflow with Harpoon:**

```
<leader>ha  Mark important files (do this for your 3-5 main files)
<leader>h1  Instantly teleport to file 1
<leader>h2  Instantly teleport to file 2
            Zero thought, zero searching — just muscle memory
```

**Debug workflow:**

```
<leader>db  Set breakpoint
<F5>        Start debugger
<F10>       Step over
<leader>dh  Hover to inspect variable
<leader>ds  View all scopes
<leader>dx  Done — terminate
```

### Speed Tips

2. **Never hold `j`/`k`.** Use `{count}j`, `<C-d>`, `{`, `}`, or Flash `s`.
3. **Think in text objects.** Don't think "go to quote, delete, go to other quote, delete." Think `di"`.
4. **Use `.` religiously.** Make one precise edit, then repeat it everywhere.
5. **Use `<C-space>` for treesitter selection.** Start small, expand. Faster than visual mode.
6. **Format on save is on.** Stop manually formatting.
7. **Use `<leader>ff` not `:e`.** Fuzzy finding is always faster.
8. **Harpoon your hot files.** If you visit a file more than twice, harpoon it.
9. **Master `ci` and `di`.** `ciw`, `ci"`, `ci(`, `cit` — these are your bread and butter.
10. **Let LSP do the work.** `gd` to jump in, `<C-o>` to jump back. `K` to read docs inline.
