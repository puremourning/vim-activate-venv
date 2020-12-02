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

" Portions coopyright as below - The virtualenv developers, reproduced without
" modification.

let s:cpo = &cpo
set cpo&

let s:activate_this_source =<< trim EOF

    # Copyright (c) 2020-202x The virtualenv developers
    #
    # Permission is hereby granted, free of charge, to any person obtaining
    # a copy of this software and associated documentation files (the
    # "Software"), to deal in the Software without restriction, including
    # without limitation the rights to use, copy, modify, merge, publish,
    # distribute, sublicense, and/or sell copies of the Software, and to
    # permit persons to whom the Software is furnished to do so, subject to
    # the following conditions:
    #
    # The above copyright notice and this permission notice shall be
    # included in all copies or substantial portions of the Software.
    #
    # THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
    # EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    # MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
    # NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
    # LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
    # OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
    # WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

    """By using execfile(this_file, dict(__file__=this_file)) you will
    activate this virtualenv environment.

    This can be used when you must use an existing Python interpreter, not
    the virtualenv bin/python
    """

    try:
        __file__
    except NameError:
        raise AssertionError(
            "You must run this like execfile('path/to/activate_this.py', dict(__file__='path/to/activate_this.py'))")
    import sys
    import os

    old_os_path = os.environ.get('PATH', '')
    os.environ['PATH'] = os.path.dirname(os.path.abspath(__file__)) + os.pathsep + old_os_path
    base = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    if sys.platform == 'win32':
        site_packages = os.path.join(base, 'Lib', 'site-packages')
    else:
        site_packages = os.path.join(base, 'lib', 'python%s' % sys.version[:3], 'site-packages')
    prev_sys_path = list(sys.path)
    import site
    site.addsitedir(site_packages)
    sys.real_prefix = sys.prefix
    sys.prefix = base
    # Move the added items to the front of the path:
    new_sys_path = []
    for item in list(sys.path):
        if item not in prev_sys_path:
            new_sys_path.append(item)
            sys.path.remove(item)
    sys.path[:0] = new_sys_path
EOF

function! activate_venv#ActivateVirtualEnv( dir ) abort
    if !isdirectory( a:dir ) || !isdirectory( a:dir .. '/bin' )
        echom "No such directory (or no /bin within it)"
        return v:false
    endif

    let activate_this = a:dir .. '/bin/activate_this.py'

    if !filereadable( activate_this )
        echom "No activate_this.py at " .. activate_this .. ", installing..."
        call writefile( s:activate_this_source, activate_this )
    endif

    if !filereadable( activate_this )
        echom "Could not create or find" activate_this
        return v:false
    endif

    pythonx import vim
    pythonx with open( vim.eval( 'activate_this' ) ) as f:
                \ exec( f.read(), { '__file__': vim.eval( 'activate_this' ) } )

    redraw!
    echom "Activated" a:dir "virtual environment"
endfunction

let &cpo = s:cpo
