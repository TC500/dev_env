" 安装向导
" 1. 将本文件放在~/.vimrc
" 2. 安装cmake gcc
" 3. 自定义需要的插件集合
"   c/cpp 需要安装cscope、clang-format
"   java/c/cpp 需要安装gnu global
"   java 需要安装JDK8
"   python需要安装flake8、pylint、yapf、autopep8 sudo -H pip install flake8 pylint yapf autopep8
if !exists('g:bundle_groups')
    " let g:bundle_groups=['base', 'python', 'c', 'cpp', 'golang', 'html', 'javascript', 'markdown', 'java', 'json', 'shell', 'protobuf', 'thrift']
    let g:bundle_groups=['base', 'python', 'c', 'cpp', 'markdown', 'json', 'shell', 'protobuf', 'thrift']
endif
" 4. 启用/禁用美化插件，启用后需要在首次vim自动安装插件后更改终端字体为DroidSansMono Nerd\ Font\ 11
let s:builty_vim = 1
" 5. 启用/禁用YCM,启用YCM需要安装libclang7或以上
let s:enable_ycm = 1
" 6. 设置vim配色方案, 修改colorscheme的设置
" 7. 打开vim，等待插件自动安装完成
" 8. 开始使用！

"自动检测系统剪贴板
if has('clipboard') && !empty($DISPLAY)
    let s:enable_system_clipboard = 1
else
    let s:enable_system_clipboard = 0
endif

"检测系统
if !exists("s:os")
    if has("win64") || has("win32") || has("win16")
        let s:os = "Windows"
    else
        let s:os = substitute(system('uname'), '\n', '', '')
    endif
endif

"安装美化字体
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

"自动安装插件管理器
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    call InstallAirLineFont()
endif

call plug#begin('~/.vim/bundle')
if count(g:bundle_groups, 'base')
    " 注册自己，能够调用help vim-plug
    Plug 'junegunn/vim-plug'
    " 类似Leadf，作为vimfiler的依赖被安装
    Plug 'Shougo/unite.vim'
    " 文件浏览器，:Ex命令调用
    Plug 'Shougo/vimfiler.vim'
    " 在quicklist中直接修改对应的行的内容
    Plug 'thinca/vim-qfreplace'
    " 添加文件说明头
    Plug 'alpertuna/vim-header'
    " sudo权限
    Plug 'vim-scripts/sudo.vim'
    " minimap,类似vscode和atom等
    Plug 'severin-lemaignan/vim-minimap'
    " 智能切换paste状态,支持大量文本的粘贴
    Plug 'roxma/vim-paste-easy'
    " 可以调整diff算法
    Plug 'chrisbra/vim-diff-enhanced'
    " 显示结尾的多余空格
    Plug 'bitc/vim-bad-whitespace'
    " 自动格式化
    Plug 'chiel92/vim-autoformat'
    " 保存文件时自动创建不存在的目录
    Plug 'pbrisbin/vim-mkdir'
    " 输入@和“或者在ctrl-R时显示剪贴板
    Plug 'junegunn/vim-peekaboo'
    " 可视化剪贴板
    Plug 'vim-scripts/YankRing.vim'
    " 静态检查
    Plug 'w0rp/ale'
    " 撤销
    Plug 'mbbill/undotree'
    " 文本替换性能增强
    Plug 'tpope/vim-abolish'
    " tpope/*插件编写的命令也能用.重复
    Plug 'tpope/vim-repeat'
    " 快速输入更改包围一段文字的符号
    Plug 'tpope/vim-surround'
    " 目录树
    Plug 'scrooloose/nerdtree'
    " colorscheme solarized8和codedark较好
    Plug 'vim-scripts/molokai'
    Plug 'sickill/vim-monokai'
    Plug 'altercation/vim-colors-solarized'
    Plug 'lifepillar/vim-solarized8'
    Plug 'junegunn/seoul256.vim'
    Plug 'tomasiser/vim-code-dark'
    Plug 'liuchengxu/space-vim-dark'
    " 画基本示意图
    Plug 'vim-scripts/drawit'
    " 彩虹括号,便于区分不同的括号
    Plug 'kien/rainbow_parentheses.vim'
    " 模糊搜索buf和file
    Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
    " 模糊搜索mark
    Plug 'Yggdroot/LeaderF-marks'
    " 高亮当前所在的括号,性能捉急，卡
    " Plug 'Yggdroot/hiPairs'
    " 按行显示文件的git标记,在修改行之间跳转
    Plug 'airblade/vim-gitgutter'
    " vim内进行git操作
    Plug 'tpope/vim-fugitive'
    " vim内的tig
    Plug 'gregsexton/gitv'
    " 目录树显示文件的git状态
    Plug 'Xuyuanp/nerdtree-git-plugin'
    " 区域选中，v vv vvv 逐渐扩大选中区域
    Plug 'vim-scripts/vim-expand-region'
    " 关闭初当前编辑buf以外的所有buf
    Plug 'vim-scripts/BufOnly.vim'
    " 注释
    Plug 'scrooloose/nerdcommenter'
    " 在输入搜索内容的过程中同时高亮所有的搜索命中项目
    Plug 'haya14busa/incsearch.vim'
    " 模糊搜索
    Plug 'haya14busa/incsearch-fuzzy.vim'
    " 快速在多个搜索命中结果中跳转
    " Plug 'haya14busa/incsearch-easymotion.vim'
    " 快速跳转
    Plug 'easymotion/vim-easymotion'
    " 行内跳转加强版
    Plug 'justinmk/vim-sneak'
    " 显示缩进的线条
    Plug 'Yggdroot/indentLine'
    " 替代vimgrep的搜索，:Ag
    Plug 'rking/ag.vim'
    " buf 浏览器
    Plug 'jlanzarotta/bufexplorer'
    " 自动补全括号
    Plug 'jiangmiao/auto-pairs'
    " 多光标操作，替换Ctrl-v
    Plug 'terryma/vim-multiple-cursors'
    " 处理git冲突
    Plug 'rhysd/conflict-marker.vim'
    " 生成函数和文档注释的插件
    Plug 'vim-scripts/DoxygenToolkit.vim'
    " 书签
    Plug 'kshenoy/vim-signature'
    " 底部状态栏和标签栏
    Plug 'vim-airline/vim-airline'
    " 状态栏主题
    Plug 'vim-airline/vim-airline-themes'
    " 显示当前buf的符号
    Plug 'majutsushi/tagbar'
    " 在底部显示函数签名
    Plug 'Shougo/echodoc.vim'
    " 代码片段
    Plug 'ervandew/supertab'
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    " 查看man手册
    Plug 'vim-utils/vim-man'
endif

if count(g:bundle_groups, 'java')
    " java import管理，javadoc
    Plug 'TC500/JavaImp.vim'
endif

if count(g:bundle_groups, 'shell')
    " shell语法高亮
    Plug 'Shougo/vimshell.vim'
endif

if count(g:bundle_groups, 'protobuf')
    " protobuf高亮
    Plug 'uarun/vim-protobuf'
endif

if count(g:bundle_groups, 'thrift')
    " thrift高亮
    Plug 'solarnz/thrift.vim'
endif

if count(g:bundle_groups, 'golang')
    Plug 'fatih/vim-go'
    Plug 'undx/vim-gocode'
endif

if count(g:bundle_groups, 'html')
    " html快速编写
    Plug 'mattn/emmet-vim'
    " html语法高亮
    Plug 'othree/html5.vim'
    " 高亮当前html tag
    Plug 'Valloric/MatchTagAlways'
endif

if count(g:bundle_groups, 'javascript')
    " javascript高亮
    Plug 'pangloss/vim-javascript'
endif

if count(g:bundle_groups, 'cpp')
    " cpp文件语法高亮
    Plug 'octol/vim-cpp-enhanced-highlight'
endif

if count(g:bundle_groups, 'c') || count(g:bundle_groups, 'cpp') || count(g:bundle_groups, 'java')
    " 提供 ctags/gtags 后台数据库自动更新功能
    Plug 'ludovicchabant/vim-gutentags'
    Plug 'skywind3000/gutentags_plus'
endif

if count(g:bundle_groups, 'c') || count(g:bundle_groups, 'cpp')
    " 在头文件和cpp文件之间快速切换，:A
    Plug 'derekwyatt/vim-fswitch'
endif

if count(g:bundle_groups, 'python')
    " python集成插件,包括高亮、格式化
    Plug 'python-mode/python-mode'
endif

" 自动补全集大成者
if exists("s:enable_ycm")  && s:enable_ycm == 1
    Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --system-libclang --java-completer' }
endif

if count(g:bundle_groups, 'markdown')
    " markdown高亮等
    Plug 'godlygeek/tabular'
    Plug 'plasticboy/vim-markdown'
    " markdown预览
    Plug 'iamcco/markdown-preview.vim'
    " 支持数学公式预览
    Plug 'iamcco/mathjax-support-for-mkdp'
endif

if count(g:bundle_groups, 'json')
    " json高亮
    Plug 'elzr/vim-json'
endif

" 美化界面，需要改终端字体为DroidSansMono Nerd\ Font\ 11
if exists("s:builty_vim")  && s:builty_vim == 1
    " 图标支持
    Plug 'ryanoasis/vim-devicons'
    " 目录树根据文件后缀名显示图标
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
endif  "s:builty_vim

call plug#end()

" 设置vim配色方案，可选darkblue,codedark,space-vim-dark,elflord,evening,koehler,slate,desert,solarized,monokai
"   如果设定为solarized模式，需要更改终端配色方案也为solarized
colorscheme solarized8
" 设置配色风格，dark/white
set background=dark

" no swp file
set nobackup
" 自动识别文件类型,使用文件类型plugin脚本,使用缩进定义文件
filetype plugin indent on
" session中不保存当前目录，这样使用Session.vim文件恢复时，Session.vim文件所在目录自动变成当前目录
set sessionoptions-=curdir
set sessionoptions+=sesdir
" 用啥鼠标
set mouse-=a
" 文件修改之后自动载入
set autoread
" 修改终端标题
set title
" for regular expressions turn magic on
set magic
" 显示当前vim模式
set showmode
" 在上下移动光标时，光标的上方或下方至少会保留显示的行数
set scrolloff=5
" 自动格式化选项
set formatoptions=tcqr
" 按照缩进折叠
set foldmethod=indent
" 按照语法高亮进行折叠
" set foldmethod=syntax
" 打开文件时默认不折叠
set foldlevelstart=99
" 不生成swp文件
set noswapfile
" 设置不兼容vi, 只使用增强模式
set nocompatible
" 设置可以删除行首空格,断行, 进入Insert模式之前的位置
set backspace=indent,eol,start
" 新行使用设置自动缩进,使用上一行的缩进方式
set autoindent
" 设置智能缩进
set smartindent
" 默认关闭可打印字符的显示
set nolist
" 可打印字符显示方式
set listchars=eol:$,tab:^I,space:.
" 高亮匹配字符
set incsearch
" 补全时显示所有候选项
set wildmode=list:longest
" 禁止光标闪烁
" set gcr = a:block-blinkon0
" 设置命令历史列表的长度
set history=50
" 在右下角显示一个完整的命令已经完成的部分
set showcmd
" 总是在窗口的右下角显示行列信息
set ruler
" 不要自动折行
set nowrap
" 设置光标能在行首和行尾之间自由移动
set whichwrap=b,s,<,>,[,]
" 将TAB替换为空格
set expandtab
" 设置TAB宽度
set tabstop=4
" 设置缩进增量
set shiftwidth=4
" 设置TAB显示宽度
set softtabstop=4
" insert tabs on the start of a line according to shiftwidth, not tabstop 按退格键时可以一次删掉 4 个空格
set smarttab
" 性能优化
set ttyfast
" 增强模式中的命令行自动完成操作
set wildmenu
" 显示行号
set number
" 状态栏同时显示了所在的行列，总的行列，所在的百分比等等
set laststatus=2
" 输入括号时显示配对的括号
set showmatch
" 和ignorecase配合实现智能大小写
set smartcase
set ignorecase
" 在80个字符处设置锚线
set colorcolumn=80
" 高亮当前行,在终端情况下有性能问题，禁用
" set cursorline
" 触发延时
set updatetime=1000
" 降低重绘制的频率
set lazyredraw
" 补全内容不以分割子窗口形式出现，只显示补全列表
set completeopt=longest,menu,preview
" 打开语法加亮
syntax on
" 高亮最后一次搜索的文本
set hlsearch
" 使路径包含当前目录下的所有子目录
set path+=**

" gvim专用设置 begin
" 行高
set linespace=-2
" 隐藏所有的菜单栏/滚动条
set guioptions-=m
set guioptions-=b
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
set guioptions-=t
set guioptions-=T
" gvim专用设置 end

if count(g:bundle_groups, 'c') || count(g:bundle_groups, 'cpp')
    " 设置c程序自动缩进
    set cindent
    " 自动缩进模式
    set cinoptions=:0,p0,t0
    " 缩进关键字
    set cinwords+=if,else,while,do,for,switch,case,try,catch
endif

" -encode set begin-
set encoding=utf-8
" 设置让VIM识别不同的换行符
set fileformats=unix,dos,mac
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
" -encode set end --------------------------------

" for vim-devicons
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
" 禁止终端重新刷新背景，避免显示问题
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
let g:ale_linters = {'c': [], 'cpp': [], 'java': []}
autocmd FileType c,cpp,java  setl fdm=syntax | setl fen
" 对YouCompleteMe插件支持较好的语言不使用
let blacklist = ['c', 'cpp', 'java']
autocmd FileType * if index(blacklist, &ft) < 0 | nmap <silent> [l <Plug>(ale_previous_wrap)
autocmd FileType * if index(blacklist, &ft) < 0 | nmap <silent> ]l <Plug>(ale_next_wrap)

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

" yankring
" nmap <leader>y :YRShow<CR>
let g:yankring_replace_n_pkey = '<Char-172>'

" LeaderF
let g:Lf_ShortcutF = '<C-p>'
let g:Lf_ShortcutB = '<leader>lb'
" let g:Lf_DefaultMode = 'FullPath'
nmap <leader>lt :LeaderfBufTag<CR>
nmap <leader>lf :LeaderfFunction<CR>
nmap <leader>ll :LeaderfLine<CR>
nmap <leader>lm :LeaderfMarks<CR>
nmap <leader>lh :LeaderfHistoryCmd<CR>

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
map gx <Plug>(Markdown_OpenUrlUnderCursor)
map ge <Plug>Markdown_EditUrlUnderCursor)

" incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
"模糊搜索快捷键
map z/ <Plug>(incsearch-fuzzy-/)
map z? <Plug>(incsearch-fuzzy-?)
map zg/ <Plug>(incsearch-fuzzy-stay)
" 允许错误几个字母的模糊搜索
" map z/ <Plug>(incsearch-fuzzyspell-/)
" map z? <Plug>(incsearch-fuzzyspell-?)
" map zg/ <Plug>(incsearch-fuzzyspell-stay)

" emmet-vim
let g:user_emmet_mode='nv' "enable key map only normal and visual mode
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
" let g:user_emmet_leader_key='<C-Y>'

" easymotion/vim-easymotion
let g:EasyMotion_leader_key = '\'
let g:EasyMotion_do_mapping = 1
let g:EasyMotion_smartcase = 1
" 按回车自动跳到第一个匹配
let g:EasyMotion_enter_jump_first = 1
map <leader><leader> <Plug>(easymotion-prefix)
map s <leader><leader>f
map S <leader><leader>F

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

" indentline
let g:indentLine_enabled = 1

" pymode
let g:pymode_folding = 0
let g:pymode_rope_completion = 0
let g:pymode_lint_signs = 0
let g:pymode_lint = 0
let g:pymode_rope = 0

" 保存当前buf
nmap <leader>w :update<CR>

" 系统剪贴板的复制、粘贴
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

" 删除所有除当前打开buf外的buf
nmap <leader>bd :BufOnly<CR>

" 在当前buf所在目录新建文件
nmap <leader>bn :e %:p:h/

" bufexplorer
nnoremap <silent> <leader>be :ToggleBufExplorer<CR>
" 禁用bufexplorer的默认快捷键,只需上面设置的一个ToggleBufExplorer就足够
let g:bufExplorerDisableDefaultKeyMapping=1

" expand-region, v 选择下个单词/段落 c-v回退选择
vmap v <Plug>(expand_region_expand)
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
" 显示隐藏文件
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
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" open NERDTree automatically when vim starts up on opening a directory
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" for tagbar
nmap <F8> :TagbarToggle<CR>
" 设置tagbar的窗口宽度
let g:tagbar_width=30
" 打开文件自动 打开tagbar
autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx,*.py,*.java call tagbar#autoopen()

" autoformat
nmap <leader>i :Autoformat<CR>
vmap <leader>i :Autoformat<CR>
let g:formatters_python = ["yapf","autopep8"]

" clang for c++
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
let g:AutoPairsMultilineClose = 0

" YouCompleteMe 功能
if exists("s:enable_ycm")  && s:enable_ycm == 1
    if !empty(glob("~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py"))
        let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py"
    endif
    if !empty(glob("~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"))
        let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"
    endif
    if !empty(glob(".ycm_extra_conf.py"))
        let g:ycm_global_ycm_extra_conf = ".ycm_extra_conf.py"
    endif
    " 自动加载.ycm_extra_conf.py，不提示
    let g:ycm_confirm_extra_conf=0
    " 补全功能在注释中同样有效
    let g:ycm_complete_in_comments=1
    " 开启 YCM 基于标签引擎
    let g:ycm_collect_identifiers_from_tags_files=1
    " YCM 集成 OmniCppComplete 补全引擎，设置其快捷键
    " inoremap <leader>; <C-x><C-o>
    " 从第一个键入字符就开始罗列匹配项
    let g:ycm_min_num_of_chars_for_completion=1
    " 禁止缓存匹配项，每次都重新生成匹配项
    let g:ycm_cache_omnifunc=0
    " 语法关键字补全
    let g:ycm_seed_identifiers_with_syntax=1
    " 修改对C函数的补全快捷键，默认是CTRL + space，修改为CTRL+
    " let g:ycm_key_invoke_completion = '<leader>l'
    " 在字符串输入中也能补全
    let g:ycm_complete_in_strings = 1
    " 在注释中也开启补全
    let g:ycm_complete_in_comments = 1
    " 禁用eclim诊断，避免冲突
    let g:EclimFileTypeValidate = 0
    " 总是打开错误提示窗口
    let g:ycm_always_populate_location_list = 1
    " 跳到定义
    nmap <C-g> :YcmCompleter GoToDefinitionElseDeclaration <C-R>=expand("<cword>")<CR><CR>
    " 跳到下一个错误
    autocmd FileType c,cpp,java nmap [l :lnext<CR>
    autocmd FileType c,cpp,java nmap ]l :lprevious<CR>
    " make YCM compatible with UltiSnips (using supertab)
    let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
    let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
    let g:SuperTabDefaultCompletionType = '<C-n>'
endif  "s:enable_ycm

" gutentags_plus
" 禁用默认快捷键
let g:gutentags_plus_nomap = 1
" 自动切换到quickfix窗口
let g:gutentags_plus_switch = 1
" 查找符号
noremap <silent> <leader>gs :GscopeFind s <C-R><C-W><cr>
" 查找定义
noremap <silent> <leader>gg :GscopeFind g <C-R><C-W><cr>
" 查找调用者
noremap <silent> <leader>gc :GscopeFind c <C-R><C-W><cr>
" 查找字符串
noremap <silent> <leader>gt :GscopeFind t <C-R><C-W><cr>
" 按照egrep查找
noremap <silent> <leader>ge :GscopeFind e <C-R><C-W><cr>
" 查找文件
noremap <silent> <leader>gf :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>
" 查看include当前文件的文件
noremap <silent> <leader>gi :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>
" 查找当前函数调用的函数
noremap <silent> <leader>gd :GscopeFind d <C-R><C-W><cr>
" 查找当前符号赋值位置
noremap <silent> <leader>ga :GscopeFind a <C-R><C-W><cr>
" 设定项目目录额外标志：除了 .git/.svn 外，还有 .root 文件
let g:gutentags_project_root = ['.root']
" 默认生成的数据文件集中到 ~/.cache/tags 避免污染项目目录，好清理
let g:gutentags_cache_dir = expand('~/.cache/tags')
" 追踪链接
let g:gutentags_resolve_symlinks = 1
" 默认禁用自动生成
let g:gutentags_modules = []
" 如果有 gtags 可执行就允许动态生成 gtags 数据库
if executable('gtags') && executable('gtags-cscope')
    let g:gutentags_modules += ['gtags_cscope']
elseif executable('ctags')
    " 如果有 ctags 可执行就允许动态生成 ctags 文件
    let g:gutentags_modules += ['ctags']
endif
" 设置 ctags 的参数
let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_ctags_extra_args = []
let g:gutentags_ctags_extra_args = ['--fields=+niaztKS', '--extra=+qf']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
" 禁用 gutentags 自动加载 gtags 数据库的行为
" 避免多个项目数据库相互干扰,使用plus插件解决问
let g:gutentags_auto_add_gtags_cscope = 0
" 手动更新tag
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

" 自动添加和更新headline
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
autocmd BufWritePre,FileWritePre * call UpdateTitle()

" F2 行号开关，用于鼠标复制代码用
" 为方便复制，用<F2>开启/关闭行号显示:
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

" F3 显示可打印字符开关
nnoremap <F3> :set list! list?<CR>

" 打开自动定位到最后编辑的位置, 需要确认 .viminfo 当前用户可写
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" 命令行模式增强，ctrl-a到行首，-e到行尾
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" 加载项目相关的设置
if filereadable(".vim")
    source .vim
endif

:packadd termdebug
