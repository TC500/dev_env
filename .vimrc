"环境设置
"1. 将本文件放在~/.vimrc
"2. 安装cscope
"3. 安装clang-format
"4. 安装clang
"5. 安装gnu global
"6. 在工程目录下执行gtags生成tag文件
"7. 打开vim,首次启动等待插件自动安装
"8. 更改终端字体为Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete\ 12


"启用美化插件
let builty_vim = 1

"启用YCM
let enable_ycm = 1

"使用系统剪贴板
let system_clipboard = 1

"自动安装插件管理器
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC

    "自动安装字体
    if exists("builty_vim") && builty_vim == 1
        \ &&  empty(glob('/usr/share/fonts/custom/Droid Sans Mono for Powerline Nerd Font Complete.otf')) 
            silent !sudo curl -fLo "/usr/share/fonts/custom/Droid Sans Mono for Powerline Nerd Font Complete.otf" 
                \ --create-dirs
                \ "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid\%20Sans\%20Mono\%20Nerd\%20Font\%20Complete.otf"
    endif
endif

call plug#begin('~/.vim/bundle')
"注册自己，能够调用help vim-plug
Plug 'junegunn/vim-plug'

"可视化剪贴板
Plug 'vim-scripts/YankRing.vim'

"调用ClangFormat命令格式化c\c++代码
Plug 'rhysd/vim-clang-format'

"静态检查
Plug 'vim-syntastic/syntastic'

"Plug 'fatih/vim-go'

"撤销
Plug 'mbbill/undotree'

"文本替换性能增强
Plug 'tpope/vim-abolish'

"tpope/*插件编写的命令也能用.重复
Plug 'tpope/vim-repeat'


"快速输入更改包围一段文字的符号
Plug 'tpope/vim-surround'

"html快速编写
Plug 'mattn/emmet-vim'

"html高亮
Plug 'othree/html5.vim'
Plug 'Valloric/MatchTagAlways' "高亮当前tag

"javascript高亮
Plug 'pangloss/vim-javascript'

"目录树
Plug 'scrooloose/nerdtree'

Plug 'vim-scripts/cscope.vim'

"GNU global
Plug 'vim-scripts/gtags.vim'

"Plug 'undx/vim-gocode'

"在头文件和cpp文件之间快速切换，:A
Plug 'TC500/a.vim'

"配色方案
Plug 'vim-scripts/molokai'
Plug 'sickill/vim-monokai'
Plug 'altercation/vim-colors-solarized'

"画基本示意图
Plug 'vim-scripts/drawit'

"彩虹括号,便于区分不同的括号
Plug 'kien/rainbow_parentheses.vim'

"模糊搜索buf和file
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'Yggdroot/LeaderF-marks'
"Plug 'ctrlpvim/ctrlp.vim' "速度比leadf慢，完全被leaderf替代

"高亮当前所在的括号,性能捉急，卡
"Plug 'Yggdroot/hiPairs'

"多光标操作，替换Ctrl-v
Plug 'terryma/vim-multiple-cursors'

"按行显示文件的git标记,在修改行之间跳转,如果打开这个插件，需要打开对应的快捷键设置
Plug 'airblade/vim-gitgutter'

"vim内进行git操作
Plug 'tpope/vim-fugitive'

"vim内的tig
Plug 'gregsexton/gitv'

"按行显示文件的修改标记，包含git和svn，在修改行之间跳转，可以替代vim-gitgutter
"Plug 'mhinz/vim-signify'

"cpp文件语法高亮
Plug 'vim-scripts/vim-cpp-enhanced-highlight'

"区域选中，v vv vvv 逐渐扩大选中区域
Plug 'vim-scripts/vim-expand-region'

"目录树显示文件的git状态
Plug 'Xuyuanp/nerdtree-git-plugin'

"tagbar,使用ctags显示当前buf的符号
Plug 'majutsushi/tagbar'

"关闭初当前编辑buf以外的所有buf
Plug 'vim-scripts/BufOnly.vim'

"注释
Plug 'scrooloose/nerdcommenter'

"在输入搜索内容的过程中同时高亮所有的搜索命中项目
Plug 'haya14busa/incsearch.vim'

"模糊搜索
Plug 'haya14busa/incsearch-fuzzy.vim'

"快速在多个搜索命中结果中跳转
"Plug 'haya14busa/incsearch-easymotion.vim'

"快速跳转
Plug 'easymotion/vim-easymotion'
Plug 'justinmk/vim-sneak'

"显示缩进的线条
Plug 'Yggdroot/indentLine'

"替代vimgrep的搜索，:Ag
Plug 'rking/ag.vim'

"python集成插件,包括高亮、格式化
Plug 'python-mode/python-mode'
"python符号高亮，完全可以被python-mode替换
"Plug 'hdima/python-syntax'

"python文件格式化
Plug 'tell-k/vim-autopep8'

"buf 浏览器
Plug 'jlanzarotta/bufexplorer'

"自动补全括号
Plug 'jiangmiao/auto-pairs'

"自动补全集大成者
if exists("enable_ycm")  && enable_ycm == 1
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }
endif  "enable_ycm

"目录树根据文件后缀名显示图标
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

"处理git冲突
Plug 'rhysd/conflict-marker.vim'

"

"生成函数和文档注释的插件，貌似目前不太需要
"Plug 'DoxygenToolkit.vim'

" 这个插件挺好的，但是总是自动的设置一个s标记，不知道是跟哪个冲突的,所以用vim-booksmark替换
"Plug 'kshenoy/vim-signature'

"书签
Plug 'MattesGroeger/vim-bookmarks'

"底部状态栏和标签栏
Plug 'vim-airline/vim-airline'
"状态栏主题
Plug 'vim-airline/vim-airline-themes'

"markdown预览
Plug 'iamcco/mathjax-support-for-mkdp' "支持数学公式
Plug 'iamcco/markdown-preview.vim' "markdown预览

"markdown高亮等
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

"json高亮
Plug 'elzr/vim-json'

""""""""""""""""""""""""""""""""""""""""""""""""
"下面的插件用于美化界面，需要改终端字体为Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete\ 12
if exists("builty_vim")  && builty_vim == 1
"字体
"Plug 'ryanoasis/nerd-fonts', {'do': 'sudo ./install.sh -S'}
"图标支持
Plug 'ryanoasis/vim-devicons'
endif  "builty_vim

call plug#end()

set nobackup "no swp file

"打开自动识别文件类型,使用文件类型plugin脚本,使用缩进定义文件
filetype plugin on      "打开文件类型插件

"session中不保存当前目录，这样使用Session.vim文件恢复时，Session.vim文件所在目录自动变成当前目录
set sessionoptions-=curdir
set sessionoptions+=sesdir

" C++ Source Code
set nocp incsearch
set cinoptions=:0,p0,t0
set cinwords=if,else,while,do,for,switch,case,try,catch
set formatoptions=tcqr
set foldmethod=indent "按照缩进折叠
"set foldmethod=syntax  "按照语法高亮进行折叠
set foldlevelstart=99 "打开文件时默认不折叠
" entering uppercase characters.
set smartcase
" using mouse
set mouse=a
" modify the large pasted text
"set paste

"-encode set begin-
"set fileencodings=utf-8,gb2312,gbk,gb18030
"set termencoding=utf-8
"set fileformats=unix
"set encoding=prc
"set encoding=cp936

set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
"multi-encoding setting
if has("multi_byte")
"set bomb
set fileencodings=ucs-bom,utf-8,cp936,big5,euc-jp,euc-kr,latin1
"CJK environment detection and corresponding setting
if v:lang =~ "^zh_CN"
"Use cp936 to support GBK, euc-cn == gb2312
set encoding=cp936
set termencoding=cp936
set fileencoding=cp936
elseif v:lang =~ "^zh_TW"
"cp950, big5 or euc-tw
"Are they equal to each other?
set encoding=big5
set termencoding=big5
set fileencoding=big5
elseif v:lang =~ "^ko"
"Copied from someone's dotfile, untested
set encoding=euc-kr
set termencoding=euc-kr
set fileencoding=euc-kr
elseif v:lang =~ "^ja_JP"
"Copied from someone's dotfile, untested
set encoding=euc-jp
set termencoding=euc-jp
set fileencoding=euc-jp
endif
"Detect UTF-8 locale, and replace CJK setting if needed
if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
endif
else
echoerr "Sorry, this version of (g)vim was not compiled with multi_byte"
endif
"-encode set end --------------------------------

"-font set begin -
"set guifont=Courier_New:h14
"set guifontwide=STXihei:h14
"set guifont=Serif\ 11
"set guifontwide=Verdana:h11
"
"for vim-devicons
if exists("builty_vim")  && builty_vim == 1
    set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete\ 12
else
    set guifont=Bitstream\ Vera\ Sans\ Mono\ 10
endif  "builty_vim
"if not use vim-devicons, use this font
"-font set end----------------------------

"补全时显示所有候选项
set wildmode=list:longest

"禁止光标闪烁
"set gcr = a:block-blinkon0

"for tag files
set tags=tags;
"set autochdir

"---------------------------------------------------------
set noswapfile          "不生成swp文件
set nocompatible        "设置不兼容vi, 只使用增强模式
set backspace=indent,eol,start   "设置可以删除行首空格,断行, 进入Insert模式之前的位置
set autoindent          "新行使用设置自动缩进,使用上一行的缩进方式
set cindent             "设置c程序自动缩进
set smartindent         "设置智能缩进

set history=50          "设置命令历史列表的长度
set showcmd             "在右下角显示一个完整的命令已经完成的部分
set ruler               "总是在窗口的右下角显示行列信息
set nowrap              "不要自动折行
set whichwrap=b,s,<,>,[,] "设置光标能在行首和行尾之间自由移动

set tabstop=4           "设置TAB显示宽度
set shiftwidth=4        "设置缩进增量
set expandtab           "将TAB替换为空格
set number              "显示行号
set laststatus=2        "显示状态和命令行
set fileformats=unix,dos  "设置让VIM识别不同的换行符,mac
set showmatch           "设置在输入括号时显示配对的括号

set ignorecase          "设置TAG查找忽略大小写
set colorcolumn=80      "在80个字符处设置锚线
set cursorline          "高亮当前行

" 补全内容不以分割子窗口形式出现，只显示补全列表
set completeopt=longest,menu,preview

"要显示效好的配色,需要在X windows的控制台下, 并且设置set term=xterm-256color
set t_Co=256
"set term=xterm-256color

"设定配色方案,合适的有darkblue, elflord,evening,koehler,slate,desert,solarized,monokai
"如果设定为solarized模式，需要更改终端配色方案也为solarized
set background=dark
colorscheme solarized
"if( &t_Co > 1 )  "判断是否支持彩色显示
	syntax on                      "打开语法加亮
	set hlsearch                   "高亮最后一次搜索的文本
"endif

set path+=**          "使路径包含当前目录下的所有子目录


set guioptions-=m " Remove menubar
set guioptions-=T " Remove toolbar
set guioptions-=r " remove v_scroll bar

"set leader key
let mapleader = "\<Space>"

"以下为一些命令使用笔记
"--------------------------------------------
"set filetype=c       "设置当前的文件类型,不给=号可以看当前的文件类型
"set path+=apath    "设定vim自动打开头文件的搜索路径,
"find filename      "查找在path路径中一个文件,完全可以被CtrlP插件替代
"set fileformat=unix "转换当前文件为unix格式,还有dos,mac
"iabbrev <tag> <text> "设置长文本的缩写,只要输入tag在按空格就行了
"

"-------------------------------------------------------------------
"hiPairs
"let g:hiPairs_enable_matchParen = 0

"gitv
"let g:Gitv_DoNotMapCtrlKey = 1
map <leader>gv :Gitv<CR><CR>
nmap <leader>gr :Git<Space>

"yankring
nmap <leader>y :YRShow<CR>
let g:yankring_replace_n_pkey = '<Char-172>'

"LeaderF
let g:Lf_ShortcutF = '<C-p>'
let g:Lf_ShortcutB = '<leader>lb'
" let g:Lf_DefaultMode = 'FullPath'
nmap <leader>lt :LeaderfBufTag<CR>
nmap <leader>lf :LeaderfFunction<CR> 
nmap <leader>ll :LeaderfLine<CR> 
nmap <leader>lm :LeaderfMarks<CR> 

"Crtlp
"nmap <leader>bs :CtrlPBuffer<CR>
""不使用缓存
"let g:ctrlp_use_caching = 0
""不自动清除缓存
"let g:ctrlp_clear_cache_on_exit = 0
""显示隐藏文件
"let g:ctrlp_show_hidden = 1
""忽略的文件
"let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
""不限制最大的文件数量
"let g:ctrlp_max_files = 0

"undotree
if has("persistent_undo")
    set undodir=~/.undodir/
    set undofile
endif
nnoremap <F6> :UndotreeToggle<cr>

"sneak
let g:sneak#label = 1
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

"a.vim
let a_vim_no_default_key_mappings = 1

"markdown
let g:mkdp_path_to_chrome = "google-chrome-stable"
let g:vim_markdown_folding_disabled = 1 
let g:vim_markdown_math = 1
let g:vim_markdown_no_default_key_mappings = 1
let g:mkdp_auto_close = 0
let g:vim_markdown_fenced_languages = ['c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini', 'javescript=js']
let g:vim_markdown_conceal = 0
map gx <Plug>(Markdown_OpenUrlUnderCursor)
map ge <Plug>Markdown_EditUrlUnderCursor)

"incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
"模糊搜索快捷键
map z/ <Plug>(incsearch-fuzzy-/)
map z? <Plug>(incsearch-fuzzy-?)
map zg/ <Plug>(incsearch-fuzzy-stay)
"允许错误几个字母的模糊搜索
"map z/ <Plug>(incsearch-fuzzyspell-/)
"map z? <Plug>(incsearch-fuzzyspell-?)
"map zg/ <Plug>(incsearch-fuzzyspell-stay)

"emmet-vim
let g:user_emmet_mode='nv' "enable key map only normal and visual mode
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
"let g:user_emmet_leader_key='<C-Y>'

"easymotion/vim-easymotion
let g:EasyMotion_do_mapping = 1
"按回车自动跳到第一个匹配
let g:EasyMotion_enter_jump_first = 1
map <leader><leader> <Plug>(easymotion-prefix)

"rainbow_parentheses
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
    \ ['black',       'SeaGreen3'],
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
au Syntax * RainbowParenthesesLoadChevrons " <>

"identline
let g:indentLine_enabled = 1

"pymode
let g:pymode_folding = 0
let g:pymode_rope_completion_bind = '<C-Space>'

"保存当前buf
nmap <leader>w :update<CR>

"系统剪贴板的复制、粘贴
if exists("system_clipboard")  && system_clipboard == 1
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
endif  "system_clipboard

"更新gtag
nmap <leader>u :!global -u <CR><CR>


"删除所有除当前打开buf外的buf
nmap <leader>bd :BufOnly<CR>

"重新载入所有的buffer
nmap <leader>bf :bufdo e<CR>

"在当前buf所在目录新建文件
nmap <leader>bn :e %:p:h/

"bufexplorer
nnoremap <silent> <leader>be :ToggleBufExplorer<CR>
"禁用bufexplorer的默认快捷键,只需上面设置的一个ToggleBufExplorer就足够
let g:bufExplorerDisableDefaultKeyMapping=1 

"expand-region, v 选择下个单词/段落 c-v回退选择
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

"gitgutter
"disable all,for solve conflict with vim-signature
let g:gitgutter_map_keys = 0
nmap [c <Plug>GitGutterPrevHunk
nmap ]c <Plug>GitGutterNextHunk
"let g:gitgutter_realtime = 0
"let g:gitgutter_eager = 0
let g:gitgutter_max_signs = 500

"signify
"    ]c   Jump to next hunk.
"    [c   Jump to previous hunk.
"    ]C   Jump to last hunk.
"    [C   Jump to first hunk.


"vim-signature
let g:SignatureMarkTextHLDynamic=1
let g:SignatureMarkerTextHLDynamic=1

"vim-bookmarks
let g:bookmark_no_default_key_mappings = 1
"匿名标签
nmap mm <Plug>BookmarkToggle
"命名标签
nmap mi <Plug>BookmarkAnnotate
nmap m/ <Plug>BookmarkShowAll
nmap ]' <Plug>BookmarkNext
nmap [' <Plug>BookmarkPrev
"clear cur buf only
nmap mc <Plug>BookmarkClear
" clear all
nmap m<Space> <Plug>BookmarkClearAll

"airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
if exists("builty_vim") && builty_vim == 1
    let g:airline_powerline_fonts = 1
endif
let g:airline_theme='solarized'

"for NERDTree plugin
nmap <F4> :NERDTreeToggle<CR>
nmap <F5> :NERDTreeFind<CR>
"显示隐藏文件
let g:NERDTreeShowHidden = 1
let g:NERDTreeWinSize=25
let g:NERDTreeWinPos = "left"
let g:NERDTreeGlyphReadOnly = "RO"
"nerdtree highlight
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name
"autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
"open a NERDTree automatically when vim starts up if no files were specified
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"open NERDTree automatically when vim starts up on opening a directory
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
"close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"for tagbar
nmap <F8> :TagbarToggle<CR>
"设置tagbar的窗口宽度
let g:tagbar_width=30
"打开文件自动 打开tagbar
autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx,*.py call tagbar#autoopen()

"clang Format
autocmd FileType c,cpp nmap <buffer> <leader>i :ClangFormat<CR>
autocmd FileType c,cpp vmap <buffer> <leader>i :ClangFormat<CR>

"clang for c++
let g:clang_auto_select=1
let g:clang_complete_auto=0
let g:clang_complete_copen=1
let g:clang_hl_errors=1
let g:clang_periodic_quickfix=0
let g:clang_snippets=1
let g:clang_snippets_engine="clang_complete"
let g:clang_conceal_snippets=1
let g:clang_exec="clang"
let g:clang_user_options=""
let g:clang_auto_user_options="path, .clang_complete"
let g:clang_use_library=1
let g:clang_library_path="/usr/lib/"
let g:clang_sort_algo="priority"
let g:clang_complete_macros=1
let g:clang_complete_patterns=0

"-----------------------------------------------------------------
"vim for python
"python-syntax
let python_highlight_all = 1

"vim-autopep8
let g:autopep8_disable_show_diff=1
autocmd FileType python nmap <buffer> <leader>i :call Autopep8()<CR>
autocmd FileType python vmap <buffer> <leader>i :call Autopep8()<CR>

let g:DoxygenToolkit_briefTag_pre="@Synopsis  "
let g:DoxygenToolkit_paramTag_pre="@Param "
let g:DoxygenToolkit_returnTag="@Returns   "
let g:DoxygenToolkit_blockHeader="--------------------------------------------------------------------------"
let g:DoxygenToolkit_blockFooter="----------------------------------------------------------------------------"
let g:DoxygenToolkit_authorName="maxiaowei_main@qq.com"
let g:DoxygenToolkit_licenseTag="maxiaowei_main@qq.com"

"------------------------------------------------------------------
"vim for go
"set rtp+=$GOROOT/misc/vim

"go tagbar list function and variable in gofiles
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

"-------------------------

"c, cpp, java文件开启折叠功能
"autocmd FileType c,cpp,java  setl fdm=syntax | setl fen

"状态栏同时显示了所在的行列，总的行列，所在的百分比等等
set laststatus=2 " always show the status line
"set statusline=(%02n)%t%m%r%h%w\[%{&ff}:%{&enc}:%Y]\[line=%04l/%04L\ col=%03c/%03{col(\"$\")-1}][%p%%]

let g:EasyMotion_leader_key = '\'

"let g:Powerline_symbols = 'fancy' "may be Garbled in macvim

"cscope
set cscopetag                  " 使用 cscope 作为 tags 命令
set cscopeprg='gtags-cscope'   " 使用 gtags-cscope 代替 cscope
set cscopequickfix=s-,c-,d-,i-,t-,e-,g- "使用quickfix窗口
"map key for cscope
"查找符号
nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <leader>gs :cs find s <C-R>=expand("<cword>")<CR><CR>
"查找定义
nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <leader>gg :cs find g <C-R>=expand("<cword>")<CR><CR>
"查找调用者
nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <leader>gc :cs find c <C-R>=expand("<cword>")<CR><CR>
"查找字符串
nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <leader>gt :cs find t <C-R>=expand("<cword>")<CR><CR>
"按照egrep查找
nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
"查找文件
nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <leader>gf :cs find f <C-R>=expand("<cfile>")<CR><CR>
"查看include当前文件的文件
nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <leader>gi :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
"查找当前函数调用的函数
nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>
"load the cscope.out database,使用gtags替换cscope，所以cscope的数据库无需读取
"if filereadable("cscope.out")
"    cs add cscope.out
"endif
"load the GTAGS database
if filereadable("GTAGS")
    cs add GTAGS
endif

" gtags
let GtagsCscope_Auto_Load = 1
let CtagsCscope_Auto_Map = 1
let GtagsCscope_Quiet = 1

" YouCompleteMe 功能
if exists("enable_ycm")  && enable_ycm == 1
" 补全功能在注释中同样有效
let g:ycm_complete_in_comments=1
" 允许 vim 加载 .ycm_extra_conf.py 文件，不再提示
let g:ycm_confirm_extra_conf=0
" 开启 YCM 基于标签引擎
let g:ycm_collect_identifiers_from_tags_files=1
" 引入 C++ 标准库tags，这个没有也没关系，只要<span style="font-family: Arial, Helvetica, sans-serif;">.ycm_extra_conf.py文件中指定了正确的标准库路径</span>
set tags+=/data/misc/software/misc./vim/stdcpp.tags
" YCM 集成 OmniCppComplete 补全引擎，设置其快捷键
"inoremap <leader>; <C-x><C-o>
" 从第一个键入字符就开始罗列匹配项
let g:ycm_min_num_of_chars_for_completion=1
" 禁止缓存匹配项，每次都重新生成匹配项
let g:ycm_cache_omnifunc=0
" 语法关键字补全
let g:ycm_seed_identifiers_with_syntax=1
" 修改对C函数的补全快捷键，默认是CTRL + space，修改为CTRL+
"let g:ycm_key_invoke_completion = '<leader>l'
" 在字符串输入中也能补全
let g:ycm_complete_in_strings = 1
"跳到定义
nmap <C-g> :YcmCompleter GoToDefinitionElseDeclaration <C-R>=expand("<cword>")<CR><CR>
nmap <leader>gd :YcmCompleter GoToDeclaration <C-R>=expand("<cword>")<CR><CR>
endif  "builty_vim

"format defined variable,这个自定义格式化函数被clang-format的功能替换
"vmap f <ESC>: call FormatDefine()<CR>        
function! FormatDefine()
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)

  if (1 == col2)
    let lnum2 -= 1
  endif

  let array = []
  let max_len_part1 = 0
  let max_len_part2 = 0

  let long_space = "                                                                                     "
  let a_line = getline(lnum1)
  let prefix_space = 0
  while (' ' == a_line[prefix_space])
    let prefix_space += 1
  endwhile
  let prefix = long_space[1:prefix_space]

  for i in range(lnum1, lnum2)
    let a_line = getline(i)
    let a_line_array = []
    let pos_equal_sign = stridx(a_line, '=')
    let len = strlen(a_line)

    if (-1 == pos_equal_sign)
      let tail = len - 1
      let part3 = ""
    else
      let tail = pos_equal_sign - 1
      let part3 = a_line[pos_equal_sign : (len-1)]
    endif

    while (' ' == a_line[tail] && tail > 0)
      let tail -= 1
    endwhile

    let pos_space = strridx(a_line, ' ', tail)
    let pos_right_brack = strridx(a_line, '>', tail)
    let pos_point = strridx(a_line, '*', tail)

    let start = (pos_space > pos_right_brack) ? pos_space : pos_right_brack
    let start = (start > pos_point) ? start : pos_point

    if (-1 == start)
      let part2 = a_line[0 : tail]
      let part1 = ""
    else
      let part2 = a_line[start+1 : tail]

      while (' ' == a_line[start] && start > 0)
        let start -= 1
      endwhile

      if (0 == start)
        let part1 = ""
      else
        let begin = 0
        while (' ' == a_line[begin])
          let begin += 1
        endwhile
        let part1 = a_line[begin : start]
      endif

    endif

	if (0 == strlen(part1))
	  let part1 = part2
	  let part2 = ""
	endif

	if ( ' ' != part3[1])
	  let part3 = part3[0:0] . " " . part3[1:-1]
	endif

    call add(a_line_array, part1)
    call add(a_line_array, part2)
    call add(a_line_array, part3)

	let len_tmp = strlen(part1)
	if (max_len_part1 < len_tmp)
	  let max_len_part1 = len_tmp
	endif
	let len_tmp = strlen(part2)
	if (max_len_part2 < len_tmp)
	  let max_len_part2 = len_tmp
	endif

    call add(array, a_line_array)
  endfor

  let max_len_part1 = (max_len_part1 + 4)/4 * 4
  let max_len_part2 = (max_len_part2 + 4)/4 * 4

  for i in range(0, lnum2 - lnum1)
    let part1 = array[i][0]
	let len1 = strlen(part1)
	let part2 = array[i][1]
	let len2 = strlen(part2)
	let part3 = array[i][2]
	call setline(lnum1+i, prefix . part1 . long_space[1:(max_len_part1-len1)] .
	                             \ part2 . long_space[1:(max_len_part2-len2)] .
								 \ part3)
  endfor
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"自动添加和更新headline
function! AddTitle()
  call append(0, "\/*")
  call append(1, " * Copyright (c) 2018 maxiaowei_main@qq.com Inc. All rights reserved.")
  call append(2, " * @Author: maxiaowei_main@qq.com")
  call append(3, " * @Date: ".strftime("%Y-%m-%d %H:%M:%S".""))
  call append(4, " * @Last Modified by: maxiaowei_main@qq.com")
  call append(5, " * @Last Modified time: ".strftime("%Y-%m-%d %H:%M:%S".""))
  call append(6, "*\/")
  "echohl WarningMsg | echo "Successful in adding file title." | echohl None
endfunction
if !exists(":AddTitle")
    command -nargs=0 AddTitle :call AddTitle()
endi

function! s:DoUpdateTitle()
    let s:save_cursor = getpos(".")
    execute '/ *@Last Modified time:/s@:.*$@\=strftime(": %Y-%m-%d %H:%M:%S").""@'
    execute '/ *@Last Modified by:/s@:.*$@\=": ".expand("maxiaowei05\@meituan.com")@'
    execute "noh"
    call setpos('.', s:save_cursor)
    "echohl WarningMsg | echo "Successful in updating file title." | echohl None
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

autocmd BufWritePre,FileWritePre * call UpdateTitle()
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"加载项目相关的设置
if filereadable(".vim")
    source .vim
endif
