# LAZY LOAD ALIASES ---------------------------

lazy_node_aliases=('nvm' 'npm' 'node')
lazy_conda_aliases=('python' 'conda' 'py' 'python3')

# NODE ----------------------------------------

load_node() {
  for lazy_node_alias in $lazy_node_aliases
  do
    unalias $lazy_node_alias
  done

  # >>> initialize node >>>
  export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
  # <<< initialize node <<<

  unfunction load_node
}

for lazy_node_alias in $lazy_node_aliases
do
  alias $lazy_node_alias="load_node && $lazy_node_alias"
done

# CONDA ---------------------------------------

load_conda() {
  for lazy_conda_alias in $lazy_conda_aliases
  do
    unalias $lazy_conda_alias
  done

  __conda_prefix="/Users/jovyntan/opt/anaconda3" # conda location

  # >>> conda initialize >>>
  # !! Contents within this block were added by 'conda init' !!
  __conda_setup="$("$__conda_prefix/bin/conda" 'shell.bash' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
      if [ -f "$__conda_prefix/etc/profile.d/conda.sh" ]; then
          . "$__conda_prefix/etc/profile.d/conda.sh"
      else
          export PATH="$__conda_prefix/bin:$PATH"
      fi
  fi
  unset __conda_setup
  # <<< conda initialize <<<

  unset __conda_prefix
  unfunction load_conda
}

for lazy_conda_alias in $lazy_conda_aliases
do
  alias $lazy_conda_alias="load_conda && $lazy_conda_alias"
done

