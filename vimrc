let mapleader=","
nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>
"let maplocalleader =" "
set foldmethod=indent
set foldlevel=1
set foldnestmax=2
set nofoldenable
" `za` toggles `zc` closes `zo` opens `zR` open all `zM` close all
autocmd BufWinLeave *.py,*.sh,*.cpp  mkview
autocmd BufWinEnter *.py,*.sh,*.cpp  silent loadview
" To save folds automatically when you close a file
set clipboard=unnamedplus
"use vimx if vim doesn't support clipboard	
set nocompatible
set number
set nobackup
set noswapfile						"no backup files
set autoread						"Auto reload file after external command
set autowrite
"set mouse=n
set path+=**
set laststatus=2
set statusline+=%#LineNr#				"Color same as number
set statusline+=\ %f					"Filename
set statusline+=\ %y					"Filetype
set statusline+=\[%{&fileformat}\]			"File Format
set statusline+=\ %p%%					"Percentage through file
set statusline+=\ %l:%c					"Line number : column number
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}	"File encoding
set history=100
set scrolloff=5
set smartcase						" if /step search for combination, if /Step search for exact case match
set cursorline
"set title
set binary						"support binary
set smarttab
autocmd Filetype go :let mapleader=","
"set incsearch
map / <Plug>(incsearch-forward)				
map ? <Plug>(incsearch-backward)		
syntax on
set wildmenu
set pastetoggle=<F3>  					"To toggle paste mode (to turnoff autoindent when you paste code)
set paste
set backspace=2
noremap <silent> <F2> :vertical resize +5 <CR>
noremap <silent> <F1> :vertical resize -5 <CR>
set t_Co=256
set t_BE=						" disable bracketed paste (on by default in vim8)
"colorscheme gruvbox 					"Monokai CandyPaper Revolution alduin railscasts gruvbox (with bg=dark)

set bg=dark
"colorscheme $VIM_COLOR_SCHEME
let python_highlight_all=1
filetype plugin on
hi Search ctermbg=Gray
"highlight Comment ctermfg=green
augroup MyFile
"	au! BufRead,BufNewFile,BufEnter *,*.*  match Comment /\import|Order\|awk\|[0-9]/
augroup END
noremap <TAB> 	<C-W>w			
"switch window using <tab> instead of Ctrl-W w
nnoremap <F5> :buffers<CR>:buffer<Space> 
"When F5 is pressed,a numbered list of file names is printed, type a number and press Enter 
"buffer! 2 --> would hide prev buffer (keeping its changes) and display 2 buffer used while changing file
set hidden 						" To avoid above usage
"hi Directory cterm=bold ctermfg=Grey
highlight MatchParen ctermfg=yellow ctermbg=Darkred cterm=NONE
set dictionary-=/usr/share/dict/dict_final dictionary+=/usr/share/dict/dict_final
set complete+=k
autocmd BufRead *.py  set smartindent
autocmd BufWritePre *.py normal m`:%s/\s\+&//e ``
"remove trailing whitespaces  while writing to file from buffer
autocmd Filetype c,cpp setlocal cindent foldmethod=syntax
autocmd Filetype c,cpp setlocal comments^=:///
filetype plugin indent on
autocmd Filetype vim set keywordprg=":help"
autocmd BufWinEnter *.txt match Directory /"[^"]\+"/
autocmd Filetype python nnoremap <buffer> K :<C-u>execute "!pydoc3 " . expand("<cword>") <CR>	
"help page for word under cursor "K"
autocmd Filetype * nnoremap <buffer> Q :<C-u>execute "!grep -E --color '^\".*' ".$HOME."/.vimrc; read; " <CR>	
"To display shortcut while editing "Q"	
autocmd BufWinEnter *.py nnoremap <F9> :w<CR>: !python %:p<CR>	
"Execute open python script
autocmd BufWinEnter *.sh nnoremap <F8> :w<CR>: !bash %:p<CR>
"Execute open bash script
let s:undoDir = $HOME."/.vim/_undodir_" . $USER
if !isdirectory(s:undoDir)
	call mkdir(s:undoDir,'p')
endif
let &undodir=s:undoDir					"Location to store undo history
set undofile						"Maintain undo history
"Persistent undo,even after closing file
set undolevels=1000					"Nax number of changes
set undoreload=10000					"Max lines to save for undo on a buffer reload

autocmd BufReadPost *
\ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
\ endif

if empty(glob('~/.vim/autoload/plug.vim'))
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim 
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

nnoremap <F6> :GundoToggle<CR>
let g:gundo_width=30
let g:gundo_preview_height=10
let g:gundo_preview_bottom=1
let g:gundo_right=1
if has('python3')
	let g:gundo_prefer_python3=1
endif
 
call plug#begin('~/.vim/plugged')
Plug 'sjl/gundo.vim'
Plug 'scrooloose/nerdtree'
Plug 'haya14busa/incsearch.vim'
Plug 'fatih/vim-go', { 'do':':GoUpdateBinaries' }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'sjl/badwolf'
"Plug 'AndrewRadev/splitjoin.vim'
"Plug 'davidhalter/jedi-vim'
call plug#end()

colorscheme badwolf
let g:badwolf_darkgutter=1
let g:badwolf_tabline=2
let g:badwolf_vss_props_highlight=1
"autocmd vimenter * NERDTree			"Open NerdTree default when vim start
autocmd vimenter * wincmd p
autocmd BufWinEnter * :silent NERDTreeMirror 
let g:NERDTreeWinSize=25
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeShowBookmarks=1
augroup nerdtreehidetirslashes
	autocmd!
	autocmd Filetype nerdtree setlocal conceallevel=3 | syntax match NERDTreeDirSlash #/$# containedin=NERDTreeDir conceal contained
augroup end
nmap <F4> :NERDTreeToggle<CR>

"vim-go setting & highlights
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
let g:go_fmt_command="goimports"
let g:go_disable_autoinstall=0
let g:go_highlight_functions=1
let g:go_highlight_types=1
let g:go_highlight_extra_types=1
let g:go_highlight_methods=1
let g:go_highlight_structs=1
let g:go_highlight_fields=1
let g:go_highlight_operators=1
let g:go_highlight_function_calls=1
let g:go_highlight_build_constraints=1
let g:go_auto_type_info=1 	" auto :GoInfo whenever there's a valid indentifier under the cursor
"let g:go_auto_sameids=1 	" auto :GoSameIds highlight matching identifiers
set updatetime=50
"let g:go_list_type="locationlist/quickfix"
"let g:go_test_timeout='10s' default
"let g:go_fmt_fail_silently=1 not to show errors during parsing the file
"<C-x><C-o> call code-completion
"autocmd Filetype go nmap <leader>t <Plug>(go-test)
autocmd Filetype go nmap <leader>t :GoTest %<CR>
"autocmd Filetype go nmap <leader>r <Plug>(go-run)
autocmd Filetype go nmap <leader>r :GoRun %<CR>
autocmd Filetype go nmap <leader>ar :GoRun % 
autocmd Filetype go nmap <leader>d :GoDef<CR>
autocmd Filetype go nmap <leader>pd :GoDefPop<CR>
autocmd Filetype go nmap <leader>i <Plug>(go-info)
" Go to Function/Structure definition
"script which requires argument
"autocmd Filetype go nmap <leader>b <Plug>(go-build)
" GoTestFunc : to test function under cursor
" :GoMetaLinter  suggestions 
" :GoDef  Go to definition
" :GoDefStack show all your location invoked via :GoDef
" :GoDecls show all types and function declarations
" :GoInfo  show type information about identifiers under the cursor
" dif : to delete inner function body
" vif - yif : to select / yank inner function body
"vaf - yaf : to select / yank function declaration + body

"let g:pymode_python='python'
"For molokai theme
"let g:rehash256=1
"let g:molokai_original=1
"colorscheme molokai

"------------
" SHORTCUT :
"------------
"set formatoptions-=or  stop vim continuing the comment automatically
" new tab ":tabnew"
" list matches "[I" (include-search)
"tab switch "gt"
"to repeat search previous pattern search "//"
"open filepath "gf"
"open filepath in new tab "C^w gf"
"move cursor a word w|W
"move cursor a word backward B|b
"move cursor to end of word E|e
"move cursor to beginning of line 0
"move cursor to end of line $
"Redo C^ r
"Move cursor to first occurance of letter "x" after cursor "fx"
"Backward for same "Fx"
"split open a file "vsplit filename" (vertical)
"split window "C^ ws" (horizontal)
"split window "C^ wv" (vertical)
"switch window "C^ ww"
"Comment or add char to selected lines :
"	 1) "C^ V" select lines in visual mode
"	 2) "I" write character
"	 3) "ESC"
"yank a word "yiw"
"replace a word with yanked one "viwp"
"delete word under the cursor and enter insert mode "ciw"
"Path Autocompletion "C^x" + "C^f"
"Previous buffer ":bp"
"switch buffered file "1  C^ ^ "
"Edit remote file  ":tabe scp://USER@IP//home/user/filename"
"To open man page of word under cursor "K"
"To open vim help page of word under cursor "set keywordprg+=":help"
"delete between paranthesis "di("
"toggle case "~"
"unident "<" indent ">"
"repeat cmd "."
"Jump to previous cursor location "C-o"
"Mark a postion "ma" jump to marked postion "'a"
"set spell check "setlocal spell spelllang=en_us"
"undo to 10min ago  ":earlier 10m"
"to redo forward 50seconds  ":later 50s"
"to increment / decrement number under cursor "C-a C-x"
"to move cursor to top / center / bottom "zt zz zb"
"move to top / bottom / center "H L M"
"scroll file up / down one line at a time "C-e C-y"
"to reload vimrc while editing ":so %"
" Jump to previous cursor location <C-o>
":vertical terminal

"NERDTree keybinds
"t: open selected file in a new tab
"i: open selected file in a horizontal split window
"s: open selected file in a vertical split window
"I: toggle hidden files
"m: Show NERD tree menu
"R: Refresh the tree


"default highlight pattern defined
"let g:netrw_banner=0 					" hide netrw top message
"let g:netrw_liststyle=3
"let g:netrw_browse_split=4
"let g:netrw_altv=1
"let g:netrw_winsize=11
"let g:netrw_chgwin=1					" open files in left window by default
"augroup Drawer
"   autocmd!
"   autocmd vimEnter * :Vexplore | wincmd p
"augroup END
"augroup nerdtreehidetirslashes
"	autocmd!
"	autocmd Filetype nerdtree syntax match NERDTreeDirSlash #/$# containedin=NERDTreeDir conceal contained
"augroup end
"aug netrw_close
"   au!
"   au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw"|q|endif
"aug END
