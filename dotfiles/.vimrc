" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Dec 17
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set showcmd		" display incomplete commands

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif


" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

"----------------------------------------------------------------------------
" Staff, that we put here (or that I cut out from above and know, what it is doing)
" --------------------------------
"  calls pathogen, which manages plugins (works on my laptop, but here, I should install pathogen first, don't remember,
"  what it is doing though :( )
" call pathogen#infect()

"If you are indented and start a new line, this makes the new line indented, too:
set autoindent
  "This it makes some sort of autoindenting occur, like when you have an open { at the end of a line.  
set smartindent

"I don't want to have to find the ESCAPE key to switch to normal mode.  This makes two quick semi-colons mean 'ESCAPE'.  You could do ii instead or anything you want.  Just don't do letters you want to type in succession often or you'll be very annoyed!
inoremap ,. <esc>


set history=1000		" keep 1000 lines of command line history

set scrolloff=3                 " minimum lines to keep above and below cursor

set incsearch		" do incremental searching (jumps to result while searching)
set ignorecase  "case insensitive searching

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on    "syntax highlighting
  set hlsearch "Suchergebnisse farbig markieren (mit :nohls verschwinden die Hervorhebungen wieder)"
endif

"Zeilennummern"
set number
set showmatch
set ruler
"Latex"
"Rules werden so definiert g:Tex_CompileRule_<format>"
filetype plugin on
"graphische Schaltflaeche"
if has('gui_running')
           set grepprg=grep\ -nH\ $*
           filetype indent on
           let g:tex_flavor='latex'
           let g:Tex_Leader=',' "changes ,c into gamma e.g. 
 endif

"set line properties
:set wrap
:set linebreak

"Highlight the line that the cursor is on:
"set cursorline

" Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$

"get rid of all these ~ lying around
set backupdir=~/tmp

" tabstop
  set ts=4
" shiftwidth
  set shiftwidth=4
" expandtab converts tabs into spaces
  set et
" textwidth (like that matches my screenwidth
  set tw=120

"  set spell                       " spell checking on

" automatically change lamda into lambda
 iab lamda lambda

 " for paper writing: map \red into \textcolor{red}{
 iab RED \textcolor{red}{

" sets vim to always put a new item when pressing enter in itemize enviroment
  function CR()
    if searchpair('\\begin{itemize}', '', '\\end{itemize}', '')
        return "\r\\item "
    endif
    return "\r"
  endfunction
  inoremap <expr><buffer> <CR> CR()
