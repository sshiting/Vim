"','''╭⌒╮⌒╮.',''',,',.'',,','',.   
"╱◥██◣''o┈SKY的GVIM配置┄o.'',,',.   
"｜田｜田田│ '',,',.o┈奋斗ing┄o   
"╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬ ╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬ 
" ╔════════════════════════════════════════════════════════════════════════╗
" ║ ★ 判断操作系统是 Windows 还是 Linux 和判断是终端还是 Gvim           ★║
" ╚════════════════════════════════════════════════════════════════════════╝
" --------------------------------------------------------------------------
"  < 判断操作系统是否是 Windows 还是 Linux >
" --------------------------------------------------------------------------
if(has("win32") || has("win64") )
    let g:iswindows = 1
else
    let g:iswindows = 0
endif
" --------------------------------------------------------------------------
"  < 判断是终端还是 Gvim >
" --------------------------------------------------------------------------
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif

" ╔════════════════════════════════════════════════════════════════════════╗
" ║ ★                             General                              ★ ║
" ╚════════════════════════════════════════════════════════════════════════╝
" --------------------------------------------------------------------------
"  < Gvim 默认配置 > 
" --------------------------------------------------------------------------
if g:isGUI
    set guioptions-=m " 隐藏菜单栏
    set guioptions-=T " 隐藏工具栏
    set guioptions-=L " 隐藏左侧滚动条
    set guioptions-=r " 隐藏右侧滚动条
    set guioptions-=b " 隐藏底部滚动条
    "set showtabline=0 " 隐藏Tab栏
endif
"set guifont=Courier\ New:h12	" 字体 && 字号
syntax on
set autoread
:cd D:\Vim\temp
autocmd BufEnter * cd %:p:h
"set tags=tags;
set autochdir
set noerrorbells                " 关闭错误提示音
set linespace=0                 " 字符间插入的像素行数目
set shortmess=atI               " 启动的时候不显示那个援助索马里儿童的提示
set novisualbell                " 不要闪烁 
"set cursorcolumn                " 显示光标所在列(竖线)
"au WinLeave * set nocursorline nocursorcolumn
"au WinEnter * set cursorline cursorcolumn
set scrolloff=3                 " 光标移动到buffer的顶部和底部时保持3行距离
set mouse=a                     " 可以在buffer的任何地方 ->
set selection=exclusive         " 使用鼠标（类似office中 ->
set selectmode=mouse,key        " 在工作区双击鼠标定位）
set cursorline                  " 突出显示当前行
set nu!                         " 显示行号
set whichwrap+=<,>,h,           " 允许backspace和光标键跨越行边界 
syntax on
set completeopt=longest,menu    "按Ctrl+N进行代码补全
set winaltkeys=no
let mapleader = ','

" -------------------------------------------------------------------------- 
"  < 查找、文本格式和排版 >  
" --------------------------------------------------------------------------
set hlsearch                 " 开启高亮显示结果 "关闭为:nohlsearch
set nowrapscan               " 搜索到文件两端时不重新搜索
set incsearch                " 开启实时搜索功能
"hi LineNr  guifg=LightBlue  "高亮行号
"set list                       " 显示Tab符，-> python等语言使用
set listchars=tab:\|\ ,         " 使用一高亮竖线代替
set tabstop=4                   " 制表符为4
"set autoindent                  " 自动对齐（继承前一行的缩进方式）
"set smartindent                 " 智能自动缩进（以c程序的方式）
set softtabstop=4 
set shiftwidth=4                " 换行时行间交错使用4个空格
set expandtab                   " 用空格代替制表符
"set noexpandtab                " 
set cindent                     " 使用C样式的缩进
"set smarttab                    " 在行和段开始处使用制表符
"set nowrap                      " 不要换行显示一行 
set laststatus=2 
set ignorecase                  "搜索时忽略大小写
set t_Co=256 
set nobackup                    "设置不备份文件
set noswapfile
":set fenc=gbk 
"--------启用代码折叠，用空格键来开关折叠 
set foldenable		     " 打开代码折叠
set foldmethod=syntax        " 选择代码折叠类型
set foldlevel=100            " 禁止自动折叠
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc':'zo')<CR> 

" --------------------------------------------------------------------------
"  < Windows Gvim 默认配置> 
" --------------------------------------------------------------------------
" 关闭vi兼容模式
set nocompatible
"设置不备份文件
set nobackup
set noswapfile
if (g:iswindows && g:isGUI)
    "source $VIMRUNTIME/vimrc_example.vim
    "兼容windows快捷键
    source $VIMRUNTIME/mswin.vim
    behave mswin
    set encoding=utf-8
    set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
    "cmd等外部窗口win下使用的是cp936(gbk)
    let g:stdoutencoding='cp936'	
    let g:stdinencoding='cp936'
    let g:stderrencoding='cp936'
    let &termencoding=&encoding
    " 解决菜单乱码
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
    " 解决consle输出乱码
    language messages zh_CN.utf-8
    " leader+e 打开配置文件
    set fileformats=unix,dos,mac
    nmap <leader>e :tabnew $HOME/.vimrc<cr>
endif


" ╔════════════════════════════════════════════════════════════════════════╗
" ║ ★                      自定义函数,功能强大                         ★ ║
" ╚════════════════════════════════════════════════════════════════════════╝
" --------------------------------------------------------------------------
"  < Gvim 全屏透明组件 > 
" --------------------------------------------------------------------------
" {{{ Win平台下窗口全屏组件 gvimfullscreen.dll
" Alt + Enter 全屏切换
" Shift + t 降低窗口透明度
" Shift + y 加大窗口透明度
" Shift + r 切换Vim是否总在最前面显示
" Vim启动的时候自动使用当前颜色的背景色以去除Vim的白色边框
if g:iswindows && g:isGUI && has('libcall')
    let g:MyVimLib = 'gvimfullscreen.dll'
    function! ToggleFullScreen()
        call libcall(g:MyVimLib, 'ToggleFullScreen', 1)
    endfunction

    let g:VimAlpha = 245
    function! SetAlpha(alpha)
        let g:VimAlpha = g:VimAlpha + a:alpha
        if g:VimAlpha < 180
            let g:VimAlpha = 180
        endif
        if g:VimAlpha > 255
            let g:VimAlpha = 255
        endif
        call libcall(g:MyVimLib, 'SetAlpha', g:VimAlpha)
    endfunction

    let g:VimTopMost = 0
    function! SwitchVimTopMostMode()
        if g:VimTopMost == 0
            let g:VimTopMost = 1
        else
            let g:VimTopMost = 0
        endif
        call libcall(g:MyVimLib, 'EnableTopMost', g:VimTopMost)
    endfunction
    "映射 Alt+Enter 切换全屏vim
    "map <a-enter> <esc>:call ToggleFullScreen()<cr>
    "切换Vim是否在最前面显示
    nmap <s-r> <esc>:call SwitchVimTopMostMode()<cr>
    "增加Vim窗体的不透明度
    nmap <s-t> <esc>:call SetAlpha(10)<cr>
    "增加Vim窗体的透明度
    nmap <s-y> <esc>:call SetAlpha(-10)<cr>
    " 默认设置透明
    autocmd GUIEnter * call libcallnr(g:MyVimLib, 'SetAlpha', g:VimAlpha)
endif
" }}}

"打开文件路径
function OpenFileLocation()
	if ( expand("%") != "" )
		execute "!start explorer /select, %" 
	else
		execute "!start explorer /select, %:p:h"
	endif
endfunction
map ge <ESC>:call OpenFileLocation()<CR>

"打开浏览器
function OpenBrowserBySst()
    if ( expand("%") != "" )
        silent execute "!start Browser file://%:p:h/%"
    endif
endfunction
map <m-b> <ESC>:call OpenBrowserBySst()<CR>
"Python 注释
function InsertPythonComment()
    exe 'normal'.1.'G'
    let line = getline('.')
    if line =~ '^#!.*$' || line =~ '^#.*coding:.*$'
        return
    endif
    normal O
    call setline('.', '#!/usr/bin/env python')
    normal o
    call setline('.', '# -*- coding:utf-8 -*-')
    normal o
    call setline('.', '#')
    normal o
    call setline('.', '#   Author  :   '.g:python_author)
    normal o
    call setline('.', '#   E-mail  :   '.g:python_email)
    normal o
    call setline('.', '#   Date    :   '.strftime("%y/%m/%d %H:%M:%S"))
    normal o
    call setline('.', '#   Desc    :   ')
    normal o
    call setline('.', '#')
    normal o
    call cursor(7, 17)
endfunction
function InsertCommentWhenOpen()
    if a:lastline == 1 && !getline('.')
        call InsertPythonComment()
    endif
endfunc
au FileType python :%call InsertCommentWhenOpen()
au FileType python map <F4> :call InsertPythonComment()<cr>
let g:python_author = 'sushiting'               
let g:python_email  = 'sushiting@163.com'   

"gvim主题切换
function! ToggleBackground()
    if (w:solarized_style=="dark")
        let w:solarized_style="light"
        colorscheme solarized
    else
        let w:solarized_style="dark"
        colorscheme solarized
    endif
endfunction
command! Togbg call ToggleBackground()
nnoremap <F5> :call ToggleBackground()<CR>
inoremap <F5> <ESC>:call ToggleBackground()<CR>a
vnoremap <F5> <ESC>:call ToggleBackground()<CR>

function CheckPythonSyntax() 
    let mp = &makeprg 
    let ef = &errorformat 
    let exeFile = expand("%:t") 
    setlocal makeprg=python\ -u 
    set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m 
    silent make % 
    copen 
    let &makeprg     = mp 
    let &errorformat = ef 
endfunction
map <leader>rp :call CheckPythonSyntax()<cr>

"获取所有匹配块  先查后取
function! CopyMatches(reg)
  let hits = []
  %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/ge
  let reg = empty(a:reg) ? '+' : a:reg
  execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
command! -register CopyMatches call CopyMatches(<q-reg>)

" 解决quickfix输出乱码
"function QfMakeConv()
"   echo 'hhhh'
"   let qflist = getqflist()
"   for i in qflist
"      let i.text = iconv(i.text, "utf-8", "cp936")
"   endfor
"   call setqflist(qflist)
"endfunction
"au QuickfixCmdPost make call QfMakeConv()


"func! CompileCode()
"	exec "w"
"	if &filetype == "java"
"		exec "!javac -encoding utf-8 %"
"	elseif &filetype == "python"
"		exec "!python %"
"	endif
"endfunc
"func! RunCode()
"	if &filetype == "java"
"		exec "!java -classpath %:h; %:t:r"
"	endif
"endfunc
" F5 保存+编译
"map <F5> :call CompileCode()<CR>
"  F6 运行
"map <F6> :call RunCode()<CR>

""--------引号 && 括号自动匹配
":inoremap ( ()<ESC>i
":inoremap ) <c-r>=ClosePair(')')<CR>
":inoremap { {}<ESC>i
":inoremap } <c-r>=ClosePair('}')<CR>
":inoremap [ []<ESC>i
":inoremap ] <c-r>=ClosePair(']')<CR>
"":inoremap < <><ESC>i
"":inoremap > <c-r>=ClosePair('>')<CR>
":inoremap " ""<ESC>i
":inoremap ' ''<ESC>i
":inoremap ` ``<ESC>i
"function ClosePair(char)
"	if getline('.')[col('.') - 1] == a:char
"		return "\<Right>"
"	else
"		return a:char
"	endif
"endf

"function! UPDATE_TAGS()  
"let _f_ = expand("%:p")  
"let _cmd_ = '"ctags -a -f /dvr/tags --c++-kinds=+p --fields=+iaS --
"extra=+q " ' . '"' . _f_ . '"'  
"let _resp = system(_cmd_)  
"unlet _cmd_  
"unlet _f_  
"unlet _resp
"endfunction
"autocmd BufWrite *.java call UPDATE_TAGS()

"替换光标下的词
"fun! Replace()
"    let s:word = input("Replace " . expand('<cword>') . " with:")
"    if s:word != ''
"        exe '%s/\<' . expand('<cword>') . '\>/' . s:word . '/ge' . '| update'
"    endif
"    unlet! s:word
"endfunction


" ╔════════════════════════════════════════════════════════════════════════╗
" ║ ★                    neobundle管理插件                             ★ ║
" ╚════════════════════════════════════════════════════════════════════════╝
" --------------------------------------------------------------------------
"  < neobundle 基本配置 > 
" --------------------------------------------------------------------------
filetype off
if !g:iswindows
    set rtp+=~/.vim/bundle/neobundle.vim/
    call neobundle#rc(expand('~/.vim/bundle/'))
else
    set rtp+=$VIM/vimfiles/bundle/neobundle.vim/
    call neobundle#rc('$VIM/vimfiles/bundle/')
endif
" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'
" --------------------------------------------------------------------------
"  < neobundle 插件列表 > 
" --------------------------------------------------------------------------
NeoBundle 'vimproc.vim'
if g:isGUI
NeoBundle 'vim-airline'
endif
"NeoBundle 'gmarik/vundle'       
NeoBundleLazy 'ZenCoding.vim', {
            \   'autoload' : {
            \       'filetypes' : ['xhtml', 'xml','html'],
            \   },
            \ }
NeoBundle 'Visual-Mark'        
NeoBundle 'maksimr/vim-jsbeautify'
"NeoBundleLazy 'maksimr/vim-jsbeautify', {
"            \   'autoload' : {
"            \       'filetypes' : ['javascript'],
"            \   },
"            \ }
"NeoBundle 'einars/js-beautify'
NeoBundle 'git://github.com/vim-scripts/taglist.vim.git' 
"Bundle 'git://github.com/vim-scripts/winmanager.git' 
NeoBundle 'Solarized'
NeoBundleLazy 'JavaRun', {
            \   'autoload' : {
            \       'filetypes' : ['python','java','html'],
            \   },
            \ }
"NeoBundle 'git@github.com:SirVer/ultisnips.git'
"NeoBundleLazy 'Pydiction', {
"            \   'autoload' : {
"            \       'filetypes' : ['python'],
"            \   },
"            \ }
"let g:pydiction_location = '$VIM/vimfiles/bundle/Pydiction/complete-dict'
NeoBundle 'neocomplete.vim'
NeoBundleLazy 'grep.vim',{
            \     'autoload' : {
            \       'commands' : [
            \           'Grep', 
            \           'Rgrep'
            \       ],
            \       'mappings' : [ '<Plug>(Grep)' ]
            \     }
            \ }
NeoBundle 'nerdtree'
NeoBundle 'vim-visual-star-search'
"NeoBundle 'open-browser.vim'
NeoBundleLazy 'calendar-vim',{
            \     'autoload' : {
            \       'commands' : [
            \           'Calendar', 
            \       ],
            \       'mappings' : [ '<Plug>(Calendar)' ]
            \     }
            \ }
"NeoBundle 'unite.vim'
NeoBundle 'ctrlp.vim'
"NeoBundleLazy 'ctrlp.vim',{
"            \     'autoload' : {
"            \       'commands' : [
"            \           'CtrlP', 
"            \       ],
"            \       'mappings' : [ '<c-p>' ]
"            \     }
"            \ }
"NeoBundleLazy 'javacomplete', {
"            \   'autoload' : {
"            \       'filetypes' : ['java'],
"            \   },
"            \ }
NeoBundle 'vimshell.vim'
NeoBundle 'vim-fugitive'
NeoBundle 'vim-surround'
"NeoBundle 'colorizer'
NeoBundle 'vim-easymotion'
NeoBundle 'tagbar'
"NeoBundle 'vim-smartinput'
NeoBundle 'delimitMate'
NeoBundle 'JavaScript-Indent'
"NeoBundle 'simple-javascript-indenter'
"NeoBundle 'syntastic'
filetype plugin indent on     " required!
" Installation check.
" NeoBundleCheck

" -----------------------------------------------------------------------------
"  < airline 插件配置 >
" -----------------------------------------------------------------------------
"set noshowmode
if g:isGUI
    set guifont=Consolas\ for\ Powerline:h12
    set background=light
    let g:solarized_italic=0
    colorscheme solarized           " solarized主题
    let g:airline_symbols = {}
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    let g:airline_symbols.branch = ''
    let g:airline_symbols.readonly = ''
    let g:airline_symbols.linenr = ''
    let g:airline_theme='light'
    let g:airline#extensions#bufferline#overwrite_variables = 1
    "let g:airline#extensions#tabline#enabled = 1
    "let g:airline#extensions#tabline#fnamemod = ':p:.'
    "let g:airline#extensions#tabline#excludes = []
    "let g:airline_section_b = '⭠ %{getcwd()}'
    "let g:airline_section_b = '⭠' '
else
    " unicode symbols
    let g:airline_left_sep = '>>'
    let g:airline_right_sep = <<'
    let g:airline_linecolumn_prefix = '| '
    let g:airline_paste_symbol = 'y'
endif

" -----------------------------------------------------------------------------
"  < neocomplete 自动补全插件配置 >
" -----------------------------------------------------------------------------
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 1
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"
" add by sst neocomplete neocomplete#start_manual_complete
inoremap <expr><m-/> pumvisible() ? "\<C-N>" : neocomplete#start_manual_complete()
" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" -----------------------------------------------------------------------------
"  < zencoding HTML,CSS自动补全插件配置 >   键：alt+q
" -----------------------------------------------------------------------------
let g:user_zen_expandabbr_key = '<m-q>'
let g:use_zen_complete_tag = 1

" -----------------------------------------------------------------------------
"  < calendar 日历插件配置 >   键：alt+c
" -----------------------------------------------------------------------------
let g:calendar_diary='D:/Vim/calendar'
map <m-c> :Calendar<cr>

" -----------------------------------------------------------------------------
"  < tagbar 插件配置 >   键：无
" -----------------------------------------------------------------------------
let g:tagbar_iconchars = ['▸', '▾']

" ╔════════════════════════════════════════════════════════════════════════╗
" ║ ★                             Mappings                             ★ ║
" ╚════════════════════════════════════════════════════════════════════════╝
" --------------------------------------------------------------------------
"   
" --------------------------------------------------------------------------

let Tlist_Show_One_File=1 
let Tlist_Exit_OnlyWindow=1
" ctrl+f 格式化JS   插件为vim-jsbeautify
"autocmd Filetype javascript map <c-f> :call JsBeautify()<cr>
nmap <silent> <leader>js :call JsBeautify()<cr>
"map <c-f> :call JsBeautify()<cr>

"" alt+/ 自动补全For java 插件javacomplete
"setlocal omnifunc=javacomplete#Complete
"autocmd FileType java set omnifunc=javacomplete#Complete
"autocmd FileType java set completefunc=javacomplete#CompleteParamsInf
""autocmd FileType java inoremap <expr><CR> pumvisible()?"\<C-Y>":"<CR>" 
"inoremap <buffer> <C-X><C-U> <C-X><C-U><C-P> 
"inoremap <buffer> <C-S-Space> <C-X><C-U><C-P>
"autocmd Filetype java,python,javascript,jsp inoremap <buffer>  <M-/>  <C-X><C-O><C-P>

imap <m-r> <ESC>:Run<CR>
map <m-r> :Run<CR>
map <m-v> :VimProcBang
nmap <leader>rs <ESC>:%s
map <leader>rsg <ESC>:%s/\%(get\%(\w\+\)*\)\@<=_\(\a\+\)/\u\1/g<CR>
map <leader>rss <ESC>:%s/\%(set\%(\w\+\)*\)\@<=_\(\a\+\)/\u\1/g<CR>
map <c-h> <ESC>:%s/
imap <c-h> <ESC>:%s/
map <m-f> <ESC>:vimgrep 
imap <m-f> <ESC>:vimgrep 
"imap <m-/> <C-N>
nnoremap <silent> <F3> :Grep<CR>
" 设置窗口ctrl+hjkl快速切换 {{{2
noremap <c-k> <c-w>k
noremap <c-j> <c-w>j
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l
noremap <leader>+ :resize+5<CR>
noremap <leader>_ :resize-5<CR>
noremap <leader>> :vertical resize+5<CR>
noremap <leader>< :vertical resize-5<CR>
:vnoremap <silent> ,/ y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
:vnoremap <silent> ,? y?<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>

" <F9>打开文件浏览窗口   插件为WinManager
"let g:winManagerWindowLayout='FileExplorer|TagList'
"nmap <F9> :WMToggle<CR>
nmap <F9> :NERDTree<CR>
map <m-t> :TlistToggle<CR>

nmap <LEADER>16r :%!xxd -r <CR>
nmap <LEADER>16 :%!xxd<CR>
noremap! <m-h> <Left>
noremap! <m-j> <Down>
noremap! <m-k> <Up>
noremap! <m-l> <Right>
"Toggle Menu and Toolbar
set guioptions-=m
set guioptions-=T
map <silent> <m-e> :if &guioptions =~# 'T' <Bar>
\set guioptions-=T <Bar>
\set guioptions-=m <bar>
\else <Bar>
\set guioptions+=T <Bar>
\set guioptions+=m <Bar>
\endif<CR>


"set tags=D:\Git\newland\webframework\BaseFrame\tags
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
function SetTagsDir()
	execute 'set tags=tags;'
endfunction

map <F4> <ESC>:!%<CR>
"set makeprg=gcc\ -Wall\ -o\ %<\ %
"map <F7> :make<CR>
""easy motion ""
let g:EasyMotion_leader_key = '<Leader>'
noremap y "+y

" Alt-W切换自动换行
noremap <leader>w :exe &wrap==1 ? 'set nowrap' : 'set wrap'<cr>
" 打开配置
nmap <LEADER>ev :tabnew<CR>:e $VIM/_vimrc<CR>

map cls <ESC>:let @/ = ''<CR>
