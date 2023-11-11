if [ -f "$HOME/.profile" ]; then
  source "$HOME/.profile"
fi

if [[ $- == *i* ]] && [ -f "$HOME/.bashrc" ]; then
  source "$HOME/.bashrc"
fi
