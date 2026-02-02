# fish-toolbox

A small, focused set of Fish shell utilities for workspace management, command prefix toggling, and keybindings.

---

## Features

- **pnpm workspace helpers** (`pnf`, `pnx`, `pnc`) with `fzf` selection
- **Command-line prefix toggling** with keybindings (`with_prefix`, `with_prefix_bind`)
- **Ready-made proxychains keybind preset**

---

## Requirements

- **Fish shell** (interactive)
- **fzf**: interactive selection for `pnf` and `pnx`
- **jq**: extract package names in `_pnpm_get_projects`
- **pnpm**: workspace discovery and execution
- **find**: used by `pnc` for recursive cleanup
- **Nerd Font (optional)**: improves icons (``, `◆`, `★`) in `pnf`

---

## Installation

### Fisher (recommended)

```fish
fisher install pourdaavar/fish-toolbox
```

### Oh My Fish

```fish
omf install https://github.com/pourdaavar/fish-toolbox
```

### Manual

- Copy `functions/*` → `~/.config/fish/functions/`
- Copy `conf.d/*` → `~/.config/fish/conf.d/`
- Copy `completions/*` → `~/.config/fish/completions/`
- Restart Fish

---

## Included Files & Features

### 1. pnpm Workspace Helpers

- **`_pnpm_get_projects.fish`**: Lists workspace package names; marks the current one with `★`
- **`pnf.fish`**: Interactive `pnpm filter` runner (multi-select)
- **`pnx.fish`**: Execute arbitrary commands in selected workspaces
- **`pnc.fish`**: Recursive destructive cleanup (`node_modules` removal)
- **`conf.d/pnpm_workspace.fish`**: Interactive-only abbreviations for common workflows

#### Commands

| Command       | Description                                                       |
| ------------- | ----------------------------------------------------------------- |
| `pnf <args…>` | Pick one or more workspace packages and run `pnpm -F ... <args…>` |
| `pnx <cmd…>`  | Pick workspaces and run `pnpm -F <pkg> exec -- <cmd…>`            |
| `pnc`         | Remove all `node_modules` under the current directory             |

#### Interactive Abbreviations

- `pni` → `pnpm install`
- `pna` → `pnf add`
- `pnu` → `pnf remove`
- `pnd` → `pnf run dev`
- `pnb` → `pnf run build`
- `pnt` → `pnf test`

---

### 2. Command Prefix Toggling + Keybindings

- **`with_prefix.fish`**: Toggles a prefix on the current command line (adds/removes)
- **`with_prefix_bind.fish`**: Binds a key sequence to `with_prefix <prefix>`
- **`completions/with_prefix_bind.fish`**: Adds Fish completions for better usability

#### Usage

Toggle a prefix manually:

```fish
with_prefix "proxychains -q"
```

Bind a key sequence (use `fish_key_reader` to find keys):

```fish
with_prefix_bind \c\eP "proxychains -q"  # Ctrl+Alt+P example
```

---

### 3. Proxychains Preset

- **`conf.d/proxychains_prefix.fish`**: Ready-made keybind that toggles `proxychains -q`.
- Edit the first argument if you want a different key sequence.

---

## Notes / Safety

- **`pnc` is destructive**: it runs `rm -rf` on every `node_modules` directory under the current directory.
- Always verify the key sequences using `fish_key_reader`.
- `with_prefix_bind` and `with_prefix` are fully general and can be used for any command, prefix, or environment variable toggling.
- Avoid Ctrl+Shift combos; use symbolic keys (`\cs`, `\c\e`, etc.) for portability.

---

## Examples of Custom Use

```fish
# Toggle sudo
with_prefix_bind \cs "sudo"

# Toggle proxychains
with_prefix_bind \c\eE "proxychains -q"

# Toggle a Python virtual environment
with_prefix_bind \c\eV "source ~/.venvs/myenv/bin/activate &&"

# Toggle an environment variable
with_prefix_bind \c\eH "env HTTP_PROXY=127.0.0.1:7890"
```
