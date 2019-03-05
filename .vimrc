" Readme. see https://tc500.github.io/ for more details
" 1. put this file in location ~/.vimrc
" 2. install cmake and gcc
" 3. custom plugin bundle groups
"   c/cpp require install cscope and clang-format
"   java/c/cpp require install 'gnu global'
"   java require install JDK8
"   python require install flake8, pylintl, yapfl and autopep8(sudo -H pip install flake8 pylint yapf autopep8)
if !exists('g:bundle_groups')
    " let g:bundle_groups=['base', 'python', 'c', 'cpp', 'golang', 'html', 'javascript', 'markdown', 'java', 'json', 'shell', 'protobuf', 'thrift']
    let g:bundle_groups=['base', 'python', 'c', 'cpp', 'markdown', 'json', 'shell', 'protobuf', 'thrift']
endif
" 4. is enable builty plugin, this require set terminal font to DroidSansMono Nerd\ Font\ 11
" the font will auto install when vim first running
let s:builty_vim = 1
" 5. is enable YouCompleteMe, this need libclang7 above or GLIBC_2.17 above
let s:enable_ycm = 1
" 6. run vim, wait for plugins auto install
" 7. well done!

" check is enable system clipboard
if has('clipboard') && !empty($DISPLAY)
    let s:enable_system_clipboard = 1
else
    let s:enable_system_clipboard = 0
endif

" check os
if !exists("s:os")
    if has("win64") || has("win32") || has("win16")
        let s:os = "Windows"
    else
        let s:os = substitute(system('uname'), '\n', '', '')
    endif
endif

" install font for builty_vim
function! InstallAirLineFont()
    let s:usr_font_path = $HOME . '/.local/share/fonts/custom/Droid Sans Mono for Powerline Nerd Font Complete.otf'
    if s:os == "Darwin" "mac
        let s:system_font_path = '/Library/Fonts/Droid Sans Mono for Powerline Nerd Font Complete.otf'
    elseif s:os == "Linux"
        let s:system_font_path = '/usr/share/fonts/custom/Droid Sans Mono for Powerline Nerd Font Complete.otf'
        "elseif s:os == "Windows"
    endif

    if exists("s:builty_vim") && s:builty_vim == 1
                \ && !filereadable(s:usr_font_path)
        execute '!curl -fLo ' . shellescape(s:usr_font_path) . ' --create-dirs ' . 'https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid\%20Sans\%20Mono\%20Nerd\%20Font\%20Complete.otf'
        if !filereadable(s:system_font_path) && filereadable(s:usr_font_path)
            execute '!sudo mkdir `dirname ' . shellescape(s:system_font_path) . '` && sudo cp ' . shellescape(s:usr_font_path) . ' ' . shellescape(s:system_font_path)
        endif
    endif
endfunction
if !exists(":InstallAirLineFont")
    command -nargs=0 InstallAirLineFont :call InstallAirLineFont()
endif

" auto install plugin manager
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    call InstallAirLineFont()
endif

call plug#begin('~/.vim/bundle')
if count(g:bundle_groups, 'base')
    " registe self, for cmd :help vim-plug
    Plug 'junegunn/vim-plug'
    " vimfiler require this
    Plug 'Shougo/unite.vim'
    " file explore, run by :Ex cmd
    Plug 'Shougo/vimfiler.vim'
    " edit content directly in quicklist
    Plug 'thinca/vim-qfreplace'
    " file header, like author license etc.
    Plug 'alpertuna/vim-header'
    " sudo permission
    Plug 'vim-scripts/SudoEdit.vim'
    " minimap
    Plug 'severin-lemaignan/vim-minimap'
    " auto disable format when paste
    Plug 'roxma/vim-paste-easy'
    " smart diff algorithm
    Plug 'chrisbra/vim-diff-enhanced'
    " show space at end of line
    Plug 'bitc/vim-bad-whitespace'
    " auto format code
    Plug 'chiel92/vim-autoformat'
    " auto mkdir when parent path empty
    Plug 'pbrisbin/vim-mkdir'
    " show clipboard content when type '@' '"' or ctrl-c
    Plug 'junegunn/vim-peekaboo'
    " enhanced clipboard
    Plug 'svermeulen/vim-yoink'
    " enhanced replace and paste in visual mode
    Plug 'svermeulen/vim-subversive'
    " asynchronous lint engine
    Plug 'w0rp/ale'
    " undo tree
    Plug 'mbbill/undotree'
    " enhanced replace
    Plug 'tpope/vim-abolish'
    " make '.' repeat cmd of tope/* plugin
    Plug 'tpope/vim-repeat'
    " provides mappings to easily delete, change and add surrounding in pairs
    Plug 'tpope/vim-surround'
    " toc tree
    Plug 'scrooloose/nerdtree'
    " colorscheme, solarized8 and codedark is better
    Plug 'vim-scripts/molokai'
    Plug 'sickill/vim-monokai'
    Plug 'altercation/vim-colors-solarized'
    Plug 'lifepillar/vim-solarized8'
    Plug 'junegunn/seoul256.vim'
    Plug 'tomasiser/vim-code-dark'
    Plug 'liuchengxu/space-vim-dark'
    " draw lines, ellipses, arrows, fills, and more
    Plug 'vim-scripts/drawit'
    " rainbow parenteses
    Plug 'kien/rainbow_parentheses.vim'
    " an asynchronous fuzzy finder which is used to quickly locate files,
    " buffers, mrus, tags, etc. in large project
    Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
    " fuzzy finder for mark
    Plug 'Yggdroot/LeaderF-marks'
    " highlight current pairs, have perfermance problem
    " Plug 'Yggdroot/hiPairs'
    " show a git diff in the gutter (sign column) and stages/undoes hunks
    Plug 'airblade/vim-gitgutter'
    " git cmd wrapper
    Plug 'tpope/vim-fugitive'
    " gitk in vim
    Plug 'gregsexton/gitv'
    " tig in vim
    Plug 'junegunn/gv.vim'
    " show git status in toc tree
    Plug 'Xuyuanp/nerdtree-git-plugin'
    " v expand visual region, ctrl-v shrink region
    Plug 'terryma/vim-expand-region'
    " close all buffer except current
    Plug 'vim-scripts/BufOnly.vim'
    " smart comment
    Plug 'scrooloose/nerdcommenter'
    " highlight match patten when regex search
    Plug 'haya14busa/incsearch.vim'
    " fuzzy search
    Plug 'haya14busa/incsearch-fuzzy.vim'
    " jump within fuzzy search results
    " Plug 'haya14busa/incsearch-easymotion.vim'
    " speed motions
    Plug 'easymotion/vim-easymotion'
    " speed motions
    Plug 'justinmk/vim-sneak'
    " show indent line
    Plug 'Yggdroot/indentLine'
    " replace vimgrep，:Ag
    Plug 'rking/ag.vim'
    " buffer explore
    Plug 'jlanzarotta/bufexplorer'
    " insert or delete brackets, parens, quotes in pair
    Plug 'jiangmiao/auto-pairs'
    " multiple selection
    Plug 'terryma/vim-multiple-cursors'
    " Weapon to fight against conflicts
    Plug 'rhysd/conflict-marker.vim'
    " Simplify Doxygen documentation in C, C++, Python
    Plug 'vim-scripts/DoxygenToolkit.vim'
    " Plugin to toggle, display and navigate marks
    Plug 'kshenoy/vim-signature'
    " draw a nice statusline at the bottom of each window
    Plug 'vim-airline/vim-airline'
    " themes of vim-airline
    Plug 'vim-airline/vim-airline-themes'
    " displays tags in a window, ordered by scope
    Plug 'majutsushi/tagbar'
    " displays function signatures from completions in the command line
    Plug 'Shougo/echodoc.vim'
    " snippets
    Plug 'ervandew/supertab'
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    " View and grep man pages
    Plug 'vim-utils/vim-man'
endif

if count(g:bundle_groups, 'java')
    " insert and sort Java import statements, view JavaDoc from class name, and more
    Plug 'TC500/JavaImp.vim'
endif

if count(g:bundle_groups, 'shell')
    " shell highlight
    Plug 'Shougo/vimshell.vim'
endif

if count(g:bundle_groups, 'protobuf')
    " protobuf highlight
    Plug 'uarun/vim-protobuf'
endif

if count(g:bundle_groups, 'thrift')
    " thrift highlight
    Plug 'solarnz/thrift.vim'
endif

if count(g:bundle_groups, 'golang')
    " go development plugin
    Plug 'fatih/vim-go'
    " an autocompletion daemon for the Go programming language
    Plug 'mdempsky/gocode'
endif

if count(g:bundle_groups, 'html')
    " emmet
    Plug 'mattn/emmet-vim'
    " html hilight
    Plug 'othree/html5.vim'
    " always highlights the enclosing html/xml tags
    Plug 'Valloric/MatchTagAlways'
endif

if count(g:bundle_groups, 'javascript')
    " javascript hilight
    Plug 'pangloss/vim-javascript'
endif

if count(g:bundle_groups, 'cpp')
    " cpp highlight
    Plug 'octol/vim-cpp-enhanced-highlight'
endif

if count(g:bundle_groups, 'c') || count(g:bundle_groups, 'cpp') || count(g:bundle_groups, 'java')
    " async generate and update ctags/gtags
    Plug 'ludovicchabant/vim-gutentags'
    Plug 'skywind3000/gutentags_plus'
endif

if count(g:bundle_groups, 'c') || count(g:bundle_groups, 'cpp')
    " switching between companion source files (e.g. ".h" and ".cpp")
    Plug 'derekwyatt/vim-fswitch'
endif

if count(g:bundle_groups, 'python')
    " PyLint, Rope, Pydoc, breakpoints from box
    Plug 'python-mode/python-mode'
endif

" powerful code-completion engine
if exists("s:enable_ycm")  && s:enable_ycm == 1
    let s:is_system_clang = 0
    if s:os == "Linux"
        let s:is_libclang7_install=str2nr(system('ldconfig -p | grep "libclang-[789].so" | wc -l'))
        let s:is_libclang7_install+=str2nr(system('strings `ldconfig -p | grep "libclang.so$" | awk -F" "' . "'" . '{print $NF}'. "'" . '` | grep "version [789].[0-9].[0-9]" | wc -l'))
        if s:is_libclang7_install > 0
            let s:is_system_clang = 1
        endif
    endif
    if s:is_system_clang
        Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --system-libclang --java-completer' }
    else
        Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --java-completer' }
    endif
endif

if count(g:bundle_groups, 'markdown')
    " markdown highlight
    Plug 'godlygeek/tabular'
    Plug 'plasticboy/vim-markdown'
    " markdown preview
    Plug 'iamcco/markdown-preview.vim'
    " markdown mathjax preview
    Plug 'iamcco/mathjax-support-for-mkdp'
endif

if count(g:bundle_groups, 'json')
    " json highlight
    Plug 'elzr/vim-json'
endif

" builty vim, require terminal font DroidSansMono Nerd\ Font\ 11
if exists("s:builty_vim")  && s:builty_vim == 1
    " Adds file type glyphs/icons to popular Vim plugins
    Plug 'ryanoasis/vim-devicons'
    " toc tree show file type icons
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
endif  "s:builty_vim

call plug#end()

" vim color scheme, available: darkblue,codedark,space-vim-dark,elflord,evening,koehler,slate,desert,solarized8,monokai
"   solarized8 require terminal color scheme solarized
colorscheme solarized8
" available: dark/white
set background=dark

" no swp file
set nobackup
" enable indent plugin by filetype
filetype plugin indent on
" save session without curdir, when reload session.vim, curdir will set to the dir where session.vim in
set sessionoptions-=curdir
set sessionoptions+=sesdir
" disable mouse
set mouse-=a
" auto load file if changed outside of vim
set autoread
" set terminal title
set title
" for regular expressions turn magic on
set magic
" show vim mode
set showmode
" ninimal number of screen lines to keep above and below the cursor
set scrolloff=5
" autoformat option, see more :help fo-tables
set formatoptions=tcqrm
" fold by indent
set foldmethod=indent
" fold by syntax
" set foldmethod=syntax
" not fold if level less than 99
set foldlevelstart=99
" no swp file
set noswapfile
" vim only ,not vi
set nocompatible
" allow backspacing over autoindent, line breaks and the start of insert
set backspace=indent,eol,start
" copy indent from current line when starting a new line
set autoindent
" do smart autoindenting when starting a new line
set smartindent
" disable listchars
set nolist
" show tabs as CTRL-I is displayed, display $ after end of line
set listchars=eol:$,tab:^I,space:.
" matched search string is highlighted
set incsearch
" When more than one match, list all matches and complete till longest common string
set wildmode=list:longest,full
" disalbe cursor blink
" set gcr = a:block-blinkon0
" how many entries may be stored in each of cmd and search patterns history
set history=50
" show (partial) command in the last line of the screen
set showcmd
" show the line and column number of the cursor position
set ruler
" lines longer than the width of the window not wrap and displaying continues on the next line
set nowrap
" allow specified keys that move the cursor left/right to move to the
" previous/next line when the cursor is on the first/last character in the line
set whichwrap=b,s,<,>,[,]
" In Insert mode: Use the appropriate number of spaces to insert a <Tab>
set expandtab
" number of spaces that a <Tab> in the file counts for
set tabstop=4
" number of spaces to use for each step of (auto)indent
set shiftwidth=4
" Adds file type glyphs/icons to popular Vim plugins
set softtabstop=4
" insert tabs on the start of a line according to shiftwidth, not tabstop
set smarttab
" indicates a fast terminal connection
set ttyfast
" command-line completion operates in an enhanced mode
set wildmenu
" print the line number in front of each line
set number
" the last window will always have a status line
set laststatus=2
" When a bracket is inserted, briefly jump to the matching one
set showmatch
" override the 'ignorecase' option if the search pattern contains upper case characters
set smartcase
set ignorecase
" a comma separated list of screen columns that are highlighted
set colorcolumn=80
" highlight cursor line, have perfermance problem
" set cursorline
" If this many milliseconds nothing is typed the swap file will be written to disk
set updatetime=1000
" screen will not be redrawn while executing macros, registers and other
" commands that have not been typed
set lazyredraw
" see :help completeopt
set completeopt=longest,menu,preview
" enable syntax hightlight
syntax on
" when there is a previous search pattern, highlight all its matches
set hlsearch
" all directories will be searched
set path+=**

" gvim line hight
set linespace=-2
" disable all menu and scrollbar
set guioptions-=m
set guioptions-=b
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
set guioptions-=t
set guioptions-=T

if count(g:bundle_groups, 'c') || count(g:bundle_groups, 'cpp')
    " enables automatic C program indenting
    set cindent
    " see :help cinoptions-values
    set cinoptions=:0,p0,t0
    " These keywords start an extra indent in the next line when 'smartindent' or 'cindent' is set
    set cinwords+=if,else,while,do,for,switch,case,try,catch
endif

" end-of-line (<EOL>) formats that will be tried
set fileformats=unix,dos,mac

" -encode set begin-
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
"multi-encoding setting
if has("multi_byte")
    " set bomb
    set fileencodings=ucs-bom,utf-8,cp936,big5,euc-jp,euc-kr,latin1
    " CJK environment detection and corresponding setting
    if v:lang =~ "^zh_CN"
        " Use cp936 to support GBK, euc-cn == gb2312
        set encoding=cp936
        set termencoding=cp936
        set fileencoding=cp936
    elseif v:lang =~ "^zh_TW"
        " cp950, big5 or euc-tw
        " Are they equal to each other?
        set encoding=big5
        set termencoding=big5
        set fileencoding=big5
    elseif v:lang =~ "^ko"
        " Copied from someone's dotfile, untested
        set encoding=euc-kr
        set termencoding=euc-kr
        set fileencoding=euc-kr
    elseif v:lang =~ "^ja_JP"
        " Copied from someone's dotfile, untested
        set encoding=euc-jp
        set termencoding=euc-jp
        set fileencoding=euc-jp
    endif
    " Detect UTF-8 locale, and replace CJK setting if needed
    if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
        set encoding=utf-8
        set termencoding=utf-8
        set fileencoding=utf-8
    endif
else
    echoerr "Sorry, this version of (g)vim was not compiled with multi_byte"
endif
" -encode set end -

if exists("s:builty_vim") && s:builty_vim == 1
    set guifont=DroidSansMono\ Nerd\ Font\ 11
else
    set guifont=Bitstream\ Vera\ Sans\ Mono\ 11
endif  "s:builty_vim

" Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
" If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
" (see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
let s:colors_type=""
if (empty($TMUX))
    " For Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
    " Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
    " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
    if (has("termguicolors")) && stridx($TERM, '256color') > 0
        let s:colors_type="termguicolors"
    else
        let s:colors_type="256"
    endif
else
    let s:tmux_version=system('tmux -V|sed "s/tmux 2.//"|sed "s/tmux 1.//"|tr -d "\n"')
    if s:tmux_version > 1 && stridx($TERM, '256color') > 0 && has("termguicolors")
        let s:colors_type="termguicolors"
    else
        let s:colors_type="256"
    endif
endif
if s:colors_type == "termguicolors"
    set termguicolors
elseif s:colors_type == "256"
    set t_Co=256
    let g:solarized_termcolors=256
endif
" disable vim refresh terminal backgroud color
set t_ut=

" set leader key
let mapleader = "\<Space>"

" JavaImp
let g:JavaImpPathSep = ';'
let g:JavaImpPaths =
            \ "/usr/lib/jvm/default-java/src/;" .
            \ $HOME . "/project/src/java;"
let g:JavaImpDocPaths = "/usr/lib/jvm/default-java/docs/api;" .
            \ "/project/docs/api"
let g:JavaImpDocViewer = "google-chrome"
let g:JavaImpSortPkgSep = 1

" vimfiler
let g:vimfiler_as_default_explorer = 1

" nerdcomment
let NERDSpaceDelims=1

" ale
let g:airline#extensions#ale#enabled = 1
let g:ale_open_list = 1
let ale_blacklist = []
if exists("s:enable_ycm")  && s:enable_ycm == 1
    " disable ale if YouCompleteMe is better
    let g:ale_linters = {'c': [], 'cpp': [], 'java': []}
    autocmd FileType c,cpp,java  setl fdm=syntax | setl fen
    let ale_blacklist = ['c', 'cpp', 'java']
endif
autocmd FileType * if index(ale_blacklist, &ft) < 0 | nmap <silent> [l <Plug>(ale_previous_wrap)
autocmd FileType * if index(ale_blacklist, &ft) < 0 | nmap <silent> ]l <Plug>(ale_next_wrap)

" vim-header
let g:header_field_author = 'Ma Xiaowei'
let g:header_field_author_email = 'maxiaowei_main@qq.com'
let g:header_auto_add_header = 0
let g:header_auto_update_header = 1
let g:header_field_filename = 0
let g:header_field_timestamp_format = '%Y-%m-%d %H:%M:%S'
let g:header_field_copyright = 'Copyright (c) %Y Meituan Inc. All rights reserved.'
let g:header_alignment = 1
let g:header_max_size = 20

" hiPairs
" let g:hiPairs_enable_matchParen = 0

" vim-fswitch
nmap <silent> <Leader>a :FSHere<cr>
augroup fswitch_cpp
    " support *.cc
    au!
    au BufEnter *.cc let b:fswitchdst  = 'h'
    au BufEnter *.cc let b:fswitchlocs = 'reg:/src/include/,reg:|src|include/**|,../include'
    au BufEnter *.h let b:fswitchdst  = 'cpp,cc,C'
    au BufEnter *.h let b:fswitchlocs = 'reg:/include/src/,reg:/include.*/src/'
augroup END

" vim-cpp-enhanced-highlight
let g:cpp_class_scope_highlight = 1
" let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
" let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1

" minimap
let g:minimap_show='<Char-172>'
let g:minimap_update='<Char-172>'
let g:minimap_close='<Char-172>'
let g:minimap_toggle='<F12>'

" gitv
" let g:Gitv_DoNotMapCtrlKey = 1
map <leader>gv :Gitv<CR><CR>
nmap <leader>gr :Git<Space>
let g:Gitv_WrapLines = 1
let g:Gitv_TruncateCommitSubjects = 1
let g:Gitv_OpenPreviewOnLaunch = 1
let g:Gitv_OpenHorizontal = 1

" vim-yoink
" the cursor will always be placed at the end of the paste
let g:yoinkMoveCursorToEndOfPaste = 1
" every time the yank history changes the numbered registers 1 - 9 will be updated to sync with the first 9 entries in the yank history
let g:yoinkSyncNumberedRegisters = 1
nmap <leader>j <plug>(YoinkPostPasteSwapBack)
nmap <leader>k <plug>(YoinkPostPasteSwapForward)
nmap [y <plug>(YoinkRotateBack)
nmap ]y <plug>(YoinkRotateForward)
nmap y <plug>(YoinkYankPreserveCursorPosition)
xmap y <plug>(YoinkYankPreserveCursorPosition)
nmap p <plug>(YoinkPaste_p)
nmap P <plug>(Yoinkpaste_P)

" vim-subversive
xmap <leader>rs <plug>(SubversiveSubstituteRange)
xmap <leader>rS <plug>(SubversiveSubstituteRangeConfirm)
" ignore case
xmap <leader>ri <plug>(SubversiveSubvertRange)
xmap <leader>rI <plug>(SubversiveSubvertRangeConfirm)
xmap p <plug>(SubversiveSubstitute)
xmap P <plug>(SubversiveSubstitute)

" LeaderF
let g:Lf_ShortcutF = '<C-p>'
let g:Lf_ShortcutB = '<leader>lb'
" let g:Lf_DefaultMode = 'FullPath'
nmap <leader>lt :LeaderfBufTag<CR>
nmap <leader>lf :LeaderfFunction<CR>
nmap <leader>ll :LeaderfLine<CR>
nmap <leader>lm :LeaderfMarks<CR>
nmap <leader>lc :LeaderfHistoryCmd<CR>
nmap <leader>ls :LeaderfHistorySearch<CR>

" undotree
if has("persistent_undo")
    " directory where the undo files will be stored
    set undodir=$HOME/.vim/undo
    " turn on the feature
    set undofile
    set undolevels=100
    set undoreload=10000
endif
nnoremap <F6> :UndotreeToggle<cr>

" sneak
let g:sneak#label = 1
let g:sneak#target_labels = ";sftunq/SFGHLTUNRMQZ?0123456789"
nnoremap <silent> f :<C-U>call sneak#wrap('',           1, 0, 1, 1)<CR>
nnoremap <silent> F :<C-U>call sneak#wrap('',           1, 1, 1, 1)<CR>
xnoremap <silent> f :<C-U>call sneak#wrap(visualmode(), 1, 0, 1, 1)<CR>
xnoremap <silent> F :<C-U>call sneak#wrap(visualmode(), 1, 1, 1, 1)<CR>
onoremap <silent> f :<C-U>call sneak#wrap(v:operator,   1, 0, 1, 1)<CR>
onoremap <silent> F :<C-U>call sneak#wrap(v:operator,   1, 1, 1, 1)<CR>
" map f <Plug>Sneak_f
" map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

" markdown
let g:mkdp_path_to_chrome = "google-chrome-stable"
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_math = 1
let g:vim_markdown_no_default_key_mappings = 1
let g:mkdp_auto_close = 0
let g:vim_markdown_fenced_languages = ['c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini', 'javescript=js']
let g:vim_markdown_conceal = 0
let g:tex_conceal = ""
let g:vim_markdown_frontmatter = 1
if count(g:bundle_groups, 'json')
    let g:vim_markdown_json_frontmatter = 1
endif
if count(g:bundle_groups, 'markdown')
    map gx <Plug>(Markdown_OpenUrlUnderCursor)
    map ge <Plug>Markdown_EditUrlUnderCursor)
endif

" indentline
let g:indentLine_enabled = 1
let g:vim_json_syntax_conceal = 0
let g:indentLine_fileTypeExclude = ['json', 'markdown']
autocmd BufEnter *.md setlocal conceallevel=0
autocmd BufEnter *.markdown setlocal conceallevel=0

" incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
" incsearch-fuzzy
map z/ <Plug>(incsearch-fuzzy-/)
map z? <Plug>(incsearch-fuzzy-?)
map zg/ <Plug>(incsearch-fuzzy-stay)
" incsearch-fuzzyspell
" map z/ <Plug>(incsearch-fuzzyspell-/)
" map z? <Plug>(incsearch-fuzzyspell-?)
" map zg/ <Plug>(incsearch-fuzzyspell-stay)

" emmet-vim
let g:user_emmet_mode='nv' "enable key map only normal and visual mode
let g:user_emmet_install_global = 0
" let g:user_emmet_leader_key='<C-Y>'
if count(g:bundle_groups, 'html')
    autocmd FileType html,css EmmetInstall
endif

" easymotion/vim-easymotion
let g:EasyMotion_leader_key = '\'
let g:EasyMotion_do_mapping = 1
let g:EasyMotion_smartcase = 1
" Type Enter or Space key and jump to first match
let g:EasyMotion_enter_jump_first = 1
map <leader><leader> <Plug>(easymotion-prefix)
map s <leader><leader>f
map <leader>s <leader><leader>F

" rainbow_parentheses
let g:rbpt_loadcmd_toggle = 1
let g:rbpt_colorpairs = [
            \ ['brown',       'RoyalBlue3'],
            \ ['Darkblue',    'SeaGreen3'],
            \ ['darkgreen',   'firebrick3'],
            \ ['darkcyan',    'RoyalBlue3'],
            \ ['darkred',     'SeaGreen3'],
            \ ['darkmagenta', 'DarkOrchid3'],
            \ ['brown',       'firebrick3'],
            \ ['gray',        'RoyalBlue3'],
            \ ['darkmagenta', 'DarkOrchid3'],
            \ ['Darkblue',    'firebrick3'],
            \ ['darkgreen',   'RoyalBlue3'],
            \ ['darkcyan',    'SeaGreen3'],
            \ ['darkred',     'DarkOrchid3'],
            \ ['red',         'firebrick3'],
            \ ]
let g:rbpt_max = 15
au VimEnter * RainbowParenthesesToggle " Toggle it on/off
au Syntax * RainbowParenthesesLoadRound " ()
au Syntax * RainbowParenthesesLoadSquare " []
au Syntax * RainbowParenthesesLoadBraces "{}
" au Syntax * RainbowParenthesesLoadChevrons " <>

" pymode
let g:pymode_folding = 0
let g:pymode_rope_completion = 0
let g:pymode_lint_signs = 0
let g:pymode_lint = 0
let g:pymode_rope = 0

" update current buffer
nmap <leader>w :update<CR>

" system clipboard
if exists("s:enable_system_clipboard")  && s:enable_system_clipboard == 1
    vmap <leader>y "+y
    vmap <leader>d "+d
    nmap <leader>p "+p
    nmap <leader>P "+P
    vmap <leader>p "+p
    vmap <leader>P "+P
else
    vmap <leader>y "py
    vmap <leader>d "pd
    nmap <leader>p "pp
    nmap <leader>P "pP
    vmap <leader>p "pp
    vmap <leader>P "pP
endif  "s:enable_system_clipboard

" close all buffer except current
nmap <leader>bd :BufOnly<CR>

" bufexplorer
nnoremap <silent> <leader>be :ToggleBufExplorer<CR>
let g:bufExplorerDisableDefaultKeyMapping=1

" expand-region, v expand visual region, ctrl-v shrink region
vmap vv <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" gitgutter
let g:gitgutter_map_keys = 0
nmap [c <Plug>GitGutterPrevHunk
nmap ]c <Plug>GitGutterNextHunk
" let g:gitgutter_eager = 0
let g:gitgutter_async = 1
let g:gitgutter_max_signs = 50
let g:gitgutter_signs = 1
let g:gitgutter_grep = 'grep --color=never'

" vim-signature
let g:SignatureMarkTextHLDynamic=1
let g:SignatureMarkerTextHLDynamic=1
let g:SignaturePurgeConfirmation=1

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
if exists("s:builty_vim") && s:builty_vim == 1
    let g:airline_powerline_fonts = 1
endif
let g:airline_theme='solarized'
" let g:airline_theme='codedark'
" let g:airline_theme='violet' "match space-vim-dark

" for NERDTree plugin
nmap <F4> :NERDTreeToggle<CR>
nmap <F5> :NERDTreeFind<CR>
let g:NERDTreeShowHidden = 1
let g:NERDTreeWinSize=35
let g:NERDTreeWinPos = "left"
let g:NERDTreeGlyphReadOnly = "RO"
" nerdtree highlight
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name
let g:NERDTreeHighlightCursorline = 0
" autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
" open a NERDTree automatically when vim starts up if no files were specified
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") && winnr('$') < 2 | NERDTree | endif
" open NERDTree automatically when vim starts up on opening a directory
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" for tagbar
nmap <F8> :TagbarToggle<CR>
let g:tagbar_width=30
" open tagbar if ext match
autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx,*.py,*.java call tagbar#autoopen()

" autoformat
nmap <leader>i :Autoformat<CR>
vmap <leader>i :Autoformat<CR>
let g:formatters_python = ["yapf","autopep8"]

" vim for python
" python-syntax
let python_highlight_all = 1

" let g:DoxygenToolkit_briefTag_pre="@Synopsis  "
" let g:DoxygenToolkit_paramTag_pre="@Param "
" let g:DoxygenToolkit_returnTag="@Returns   "
let g:DoxygenToolkit_blockHeader="--------------------------------------------------------------------------"
let g:DoxygenToolkit_blockFooter="----------------------------------------------------------------------------"
let g:DoxygenToolkit_authorName="maxiaowei_main@qq.com"
let g:DoxygenToolkit_licenseTag="maxiaowei_main@qq.com"

" vim for go
" set rtp+=$GOROOT/misc/vim

" go tagbar list function and variable in gofiles
let g:tagbar_type_go = {
            \ 'ctagstype' : 'go',
            \ 'kinds'     : [
            \ 'p:package',
            \ 'i:imports:1',
            \ 'c:constants',
            \ 'v:variables',
            \ 't:types',
            \ 'n:interfaces',
            \ 'w:fields',
            \ 'e:embedded',
            \ 'm:methods',
            \ 'r:constructor',
            \ 'f:functions'
            \ ],
            \ 'sro' : '.',
            \ 'kind2scope' : {
            \ 't' : 'ctype',
            \ 'n' : 'ntype'
            \ },
            \ 'scope2kind' : {
            \ 'ctype' : 't',
            \ 'ntype' : 'n'
            \ },
            \ 'ctagsbin'  : 'gotags',
            \ 'ctagsargs' : '-sort -silent'
            \ }

"let g:Powerline_symbols = 'fancy' "may be Garbled in macvim

" auto-pairs
let g:AutoPairsMultilineClose = 1

" YouCompleteMe
if exists("s:enable_ycm")  && s:enable_ycm == 1
    if !empty(glob("~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py"))
        let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py"
    endif
    if !empty(glob("~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"))
        let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"
    endif
    if !empty(glob("~/.vim/bundle/YouCompleteMe/third_party/ycmd/examples/.ycm_extra_conf.py"))
        let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/third_party/ycmd/examples/.ycm_extra_conf.py"
    endif
    if !empty(glob("~/.vim/.ycm_extra_conf.py"))
        let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
    endif
    if !empty(glob(".ycm_extra_conf.py"))
        let g:ycm_global_ycm_extra_conf = ".ycm_extra_conf.py"
    endif
    " autoload .ycm_extra_conf.py, no need confirm
    let g:ycm_confirm_extra_conf=0
    let g:ycm_complete_in_comments=1
    let g:ycm_collect_identifiers_from_tags_files=1
    let g:ycm_min_num_of_chars_for_completion=1
    let g:ycm_cache_omnifunc=0
    " YCM's identifier completer will seed its identifier database with the keywords of the programming language
    let g:ycm_seed_identifiers_with_syntax=1
    " show the completion menu even when typing inside strings
    let g:ycm_complete_in_strings = 1
    " show the completion menu even when typing inside comments
    let g:ycm_complete_in_comments = 1
    " eclim file type validate conflict with YouCompleteMe
    let g:EclimFileTypeValidate = 0
    " YCM will populate the location list automatically every time it gets new diagnostic data
    let g:ycm_always_populate_location_list = 1
    nmap <C-g> :YcmCompleter GoToDefinitionElseDeclaration <C-R>=expand("<cword>")<CR><CR>
    " goto next location list
    autocmd FileType c,cpp,java nmap [l :lnext<CR>
    " goto previous location list
    autocmd FileType c,cpp,java nmap ]l :lprevious<CR>
    " make YCM compatible with UltiSnips (using supertab)
    let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
    let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
    let g:SuperTabDefaultCompletionType = '<C-n>'
endif  "s:enable_ycm

" gutentags_plus
" disable default keymap
let g:gutentags_plus_nomap = 1
" auto switch to quickfix window
let g:gutentags_plus_switch = 1
" find this symbol
noremap <silent> <leader>gs :GscopeFind s <C-R><C-W><cr>
" find this definition
noremap <silent> <leader>gg :GscopeFind g <C-R><C-W><cr>
" find functions calling this function
noremap <silent> <leader>gc :GscopeFind c <C-R><C-W><cr>
" find this text string
noremap <silent> <leader>gt :GscopeFind t <C-R><C-W><cr>
" find this egrep pattern
noremap <silent> <leader>ge :GscopeFind e <C-R><C-W><cr>
" find this file
noremap <silent> <leader>gf :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>
" find files #including this file
noremap <silent> <leader>gi :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>
" find functions called by this function
noremap <silent> <leader>gd :GscopeFind d <C-R><C-W><cr>
" find places where this symbol is assigned a value
noremap <silent> <leader>ga :GscopeFind a <C-R><C-W><cr>
" project root dir flag contant .root and .git
let g:gutentags_project_root = ['.root']
" Specifies a directory in which to create all the tags files, instead of writing them at the root of each project
let g:gutentags_cache_dir = expand('~/.cache/tags')
let g:gutentags_resolve_symlinks = 1
let g:gutentags_modules = []
if executable('gtags') && executable('gtags-cscope')
    " gtags first
    let g:gutentags_modules += ['gtags_cscope']
elseif executable('ctags')
    " then ctags
    let g:gutentags_modules += ['ctags']
endif
let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_ctags_extra_args = []
let g:gutentags_ctags_extra_args += ['--fields=+niaztKS', '--extra=+qf']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
" disable gutentags auto load, gutentags_plus plugin handles switching databases automatically before performing a query
let g:gutentags_auto_add_gtags_cscope = 0
" force update tags file
let g:gutentags_define_advanced_commands = 1
nmap <leader>u :GutentagsUpdate! <CR><CR>

" echodoc.vim
set cmdheight=2
" set noshowmode
let g:echodoc#enable_at_startup = 1
let g:echodoc#enable_force_overwrite = 1

" vim-paste-easy
let g:paste_easy_message = 0

" ultisnips
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" vim-multiple-cursors
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<C-a>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<C-a>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'
function! Multiple_cursors_before()
    let s:old_ycm_whitelist = g:ycm_filetype_whitelist
    let g:ycm_filetype_whitelist = {}
    set foldmethod=manual
endfunction
function! Multiple_cursors_after()
    let g:ycm_filetype_whitelist = s:old_ycm_whitelist
    set foldmethod=indent
endfunction

function! AddTitle()
    call append(0, "\/*")
    call append(1, " * Copyright (c) 2019 Meituan Inc. All rights reserved.")
    call append(2, " * @Author: maxiaowei_main@qq.com")
    call append(3, " * @Date: ".strftime("%Y-%m-%d %H:%M:%S".""))
    call append(4, " * @Last Modified by: maxiaowei_main@qq.com")
    call append(5, " * @Last Modified time: ".strftime("%Y-%m-%d %H:%M:%S".""))
    call append(6, "*\/")
    " echohl WarningMsg | echo "Successful in adding file title." | echohl None
endfunction
if !exists(":AddTitle")
    command -nargs=0 AddTitle :call AddTitle()
endi

function! s:DoUpdateTitle()
    let s:save_cursor = getpos(".")
    execute '/ *@Last Modified time:/s@:.*$@\=strftime(": %Y-%m-%d %H:%M:%S").""@'
    execute '/ *@Last Modified by:/s@:.*$@\=": ".expand("maxiaowei_main\@qq.com")@'
    execute "noh"
    " echohl WarningMsg | echo "Successful in updating file title." | echohl None
    call setpos('.', s:save_cursor)
endfunction

function! UpdateTitle()
    if &modified
        let n = 0
        while n < 7
            let line = getline(n)
            if line =~'\s\*\_s@Last\_sModified\_sby:'
                call s:DoUpdateTitle()
                return
            endif
            let n = n + 1
        endwhile
    endif
endfunction
if !exists(":UpdateTitle")
    command -nargs=0 UpdateTitle :call UpdateTitle()
endif
" auto update title
autocmd BufWritePre,FileWritePre * call UpdateTitle()

" F2 toggle line number
" for mouse select and copy from terminal
let s:rnu = &relativenumber
let s:nu = &number
function! ToggleNumber()
    if(&relativenumber || &number)
        let s:rnu = &relativenumber
        let s:nu = &number
        set norelativenumber
        set nonumber
    else
        if(s:rnu)
            set relativenumber
        endif
        if(s:nu)
            set number
        endif
    endif
    set number?
endfunc
nnoremap <F2> :call ToggleNumber()<CR>

" F3 toggle printable char visibility
nnoremap <F3> :set list! list?<CR>

" goto last edit position when open file
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" in command line mode,ctrl-a goto line head，ctrl-e goto line tail
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" load extra vim script
if filereadable(".vim")
    source .vim
endif

" enable termdebug
:packadd termdebug
