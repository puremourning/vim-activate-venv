" Copyright 2020 Ben Jackson (puremourning@gmail.com)
"
" Licensed under the Apache License, Version 2.0 (the "License");
" you may not use this file except in compliance with the License.
" You may obtain a copy of the License at
"
"   http://www.apache.org/licenses/LICENSE-2.0
"
" Unless required by applicable law or agreed to in writing, software
" distributed under the License is distributed on an "AS IS" BASIS,
" WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
" See the License for the specific language governing permissions and
" limitations under the License.

if exists( 'g:loaded_activate_venv' )
  finish
endif

let s:cpo = &cpo
set cpo&vim

let g:loaded_activate_venv = 1

command! -nargs=1 -complete=dir ActivateVirtualEnv
      \ call activate_venv#ActivateVirtualEnv( <q-args> )

let &cpo = s:cpo
