" Common
scriptencoding utf-8
set nocompatible
set encoding=utf-8

" Git Bash's MSYS2 Vim searches ~/.vim instead of Windows' ~/vimfiles.
if has('win32unix')
	let s:vimfiles = fnamemodify(resolve(expand('<sfile>:p')), ':h')
	execute 'set runtimepath^=' . fnameescape(s:vimfiles)
	execute 'set packpath^=' . fnameescape(s:vimfiles)
	unlet s:vimfiles
endif

set autoread
set ruler
set showcmd
set number
set backspace=indent,eol,start
set scrolloff=1
set sidescrolloff=5
set nrformats-=octal

" Disable visual bell
set noerrorbells visualbell t_vb=

" Disable backup and swap files
set nobackup
set nowritebackup
set noswapfile

" Wrapping
set linebreak
set showbreak=↪
set list
set listchars=tab:→\ ,trail:·

" Buffers
set hidden
set wildchar=<Tab> wildmenu wildmode=full

" Colors
syntax enable
set t_Co=256

" Undo
set history=1000
set undolevels=1000

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase

" Filetypes
filetype plugin indent on

" Completion
set omnifunc=syntaxcomplete#Complete
set completeopt=longest,menuone

" Status line
set laststatus=2

" -- clear
set statusline=
" -- buffer number
set statusline +=%2*\ [%n]%*
" -- full path
set statusline +=%4*\ %<%F%*
" -- modified flag
set statusline +=%3*%m%*
" -- encoding
set statusline +=%1*%=\ %{''.(&fenc!=''?&fenc:&enc).''}\ %*
" -- file format
set statusline +=%1*%=%{&ff}%*
" -- file type
set statusline +=%1*%=%y%*
" -- current line
set statusline +=%2*%=%6l%*
" -- total lines
set statusline +=%1*/%*%3*%L%*
" -- virtual column number
set statusline +=%2*%5v\ %*

hi default link User1 Normal
hi default link User2 Identifier
hi default link User3 Special
hi default link User4 Title

let g:lastbuf = 1
let g:lasttab = 1

augroup vimfiles_navigation
	autocmd!

	" Return to last edit position when opening files
	autocmd BufReadPost *
				\ if line("'\"") > 0 && line("'\"") <= line("$") && &filetype !=# "gitcommit" |
				\   execute "normal! g`\"" |
				\ endif

	" Remember the last active buffer and tab
	autocmd BufLeave * let g:lastbuf = bufnr('%')
	autocmd TabLeave * let g:lasttab = tabpagenr()
augroup END

" Leader bindings
set notimeout
let mapleader = " "
nnoremap <Leader><tab> :exe "b ".g:lastbuf<CR>
nnoremap <Leader>t :exe "tabn ".g:lasttab<CR>
nnoremap <Leader>n :nohl<CR>
nnoremap <Leader>w <c-w>

" Highlight trailing whitespace
highlight TrailingWhitespaces ctermbg=Red guibg=Red

augroup vimfiles_trailing_whitespace
	autocmd!
	autocmd BufEnter * match TrailingWhitespaces /\s\+$/
	autocmd BufWinEnter * match TrailingWhitespaces /\s\+$/
	autocmd WinEnter * match TrailingWhitespaces /\s\+$/
	autocmd InsertEnter * match TrailingWhitespaces /\s\+\%#\@<!$/
	autocmd InsertLeave * match TrailingWhitespaces /\s\+$/
	autocmd WinLeave * call clearmatches()
	autocmd BufWinLeave * call clearmatches()
	autocmd BufLeave * call clearmatches()
augroup END

" FZF configuration
if executable('fzf')
	nnoremap <Leader>e :Files<CR>
	nnoremap <Leader>g :GFiles<CR>
	nnoremap <Leader>G :GFiles?<CR>
	nnoremap <Leader>b :Buffers<CR>
	nnoremap <Leader>h :History<CR>
	if executable('rg')
		nnoremap <Leader>/ :Rg<CR>
	endif
endif
