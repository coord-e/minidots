if [ -d "$HOME/.cargo" ]; then
  source "$HOME/.cargo/env"
fi

if [ -d "$HOME/.ghcup" ]; then
  source "$HOME/.ghcup/env"
fi

if [ -d "$HOME/.opam" ]; then
  source "$HOME/.opam/opam-init/variables.sh"
fi

if [ -d "$HOME/.volta" ]; then
  export VOLTA_HOME=$HOME/.volta
  PATH=$VOLTA_HOME/bin:$PATH
fi

if [ -d "$HOME/.rbenv" ]; then
  PATH=$PATH:$HOME/.rbenv/bin
fi

if [ -d "$HOME/.local/share/fnm" ]; then
  PATH=$PATH:$HOME/.local/share/fnm
fi

if [ -d "$HOME/.local/bin" ]; then
  PATH=$PATH:$HOME/.local/bin
fi

for editor in nvim vim vim.tiny; do
  if type "$editor" >/dev/null 2>&1; then
    export VISUAL=$editor
    break
  fi
done

if type tmux >/dev/null 2>&1; then
  tmux start-server
fi

if [ -d "$HOME/.profile.d" ]; then
  for profile in "$HOME"/.profile.d/*.sh; do
    source "$profile"
  done
fi
