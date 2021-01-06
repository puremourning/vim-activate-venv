# Activate a virtualenv

This plugin exists to activate a virtual environment in the python embedded
within Vim.

It's main use it to work with
[jupyter-vim](https://github.com/jupyter-vim/jupyter-vim) along with a couple of
commands to start jupyter in a terminal in vim.

There's just one command:

* `ActivateVirtualEnv <path>` - activate the virtual env rooted at `<path>` in
  vim's embedded python
  
# Compatibility

Vim 8.2

# Working with virtualenv Jupyter

Change `$HOME/venvs/jupyter` to something you prefer.

* `python3 -m venv $HOME/venvs/jupyter`
* `source $HOME/venvs/jupyter/bin/activate`
* `pip install jupyterlab jupyter-console qtconsole`
* `deactivate`

Create `$HOME/.vim/ftplugin/python.vim` and add this to it:

```viml

" TODO: change this path!!
let g:jupyter_venv=expand( "$HOME/venvs/jupyter" )

command! -buffer -nargs=* JupyterStartConsole
      \ execute 'ActivateVirtualEnv' g:jupyter_venv
      \ | execute 'botright vertical terminal
      \         ++cols=80
      \         ++close
      \         ++norestore
      \         ++kill=term
      \         jupyter-console
      \         <args>'
      \ | wincmd p
      \ | echo "Giving it a chance..."
      \ | sleep 1000m
      \ | redraw
      \ | JupyterConnect

command! -buffer -nargs=* JupyterStartQtConsole
      \ execute 'ActivateVirtualEnv' g:jupyter_venv
      \ | execute 'terminal
      \         ++close
      \         ++hidden
      \         ++norestore
      \         ++kill=term
      \         jupyter-qtconsole
      \         <args>'
      \ | wincmd p
      \ | echo "Giving it a chance..."
      \ | sleep 1000m
      \ | redraw
      \ | JupyterConnect
```

Then you can open a `test.py` file and:

* `:JupyterStartConsole` - Open jupyter console a vim terminal in a vertical
  split and connect to it
* `:JupyterStartQtConsole` - Open jupyter qtconsole in anotehr window and
  connect to it.

# Caveats

Was hacked together in 10 minutes. I have used it a few times and it basically
works-for-me(TM). YMMV :)
