
" __     __  ___   __  __ 
" \ \   / / |_ _| |  \/  |
"  \ \ / /   | |  | |\/| |
"   \ V /    | |  | |  | |
"    \_/    |___| |_|  |_|
                       

let g:mapleader="\<space>"
let g:maplocalleader="," 

noremap <leader>w :w<cr>
noremap <leader>q :q<cr>


" hi NonText cterm=NONE ctermfg=NONE
set history=1000
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4 
set autochdir
set wildmenu
set tabstop=4
set shiftwidth=4
set nu
set rnu
set ignorecase
set noswapfile
set incsearch
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" new line indent automatically
set autoindent

" using system clipboard
if has('nvim')
	set clipboard+=unnamedplus
endif

" window split
noremap <c-h> <c-w>h 
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-l> <c-w>l
noremap <localleader>mv :e $MYVIMRC<CR>


" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
" docs
Plug 'yianwillis/vimcdoc'

" On-demand lazy load
Plug 'junegunn/fzf.vim'
Plug 'glepnir/dashboard-nvim'

"statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"colorscheme
Plug 'arcticicestudio/nord-vim'
Plug 'joshdick/onedark.vim'
Plug 'sirver/ultisnips'
Plug 'dracula/vim'
Plug 'morhetz/gruvbox'
Plug 'NLKNguyen/papercolor-theme'

"edit
Plug 'AndrewRadev/inline_edit.vim'
Plug 'easymotion/vim-easymotion'
Plug 'jiangmiao/auto-pairs'
Plug 'gcmt/wildfire.vim' "choose text object
Plug 'junegunn/vim-easy-align'

"language support
Plug 'leafOfTree/vim-vue-plugin'
Plug 'othree/xml.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'
Plug 'lervag/vimtex'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'mattn/emmet-vim'
Plug 'turbio/bracey.vim', {'do': 'npm install --prefix server'}

"commentary
Plug 'tpope/vim-surround'
Plug 'tomtom/tcomment_vim'

"translate
Plug 'voldikss/vim-translator'
call plug#end()

"------------------ coc.nvim ------------------

let g:coc_global_extensions=[ 'coc-vetur', 'coc-vimlsp', 'coc-markdownlint', 'coc-css', 'coc-eslint', 'coc-docthis' , 'coc-marketplace', 'coc-tsserver',  'coc-word', 'coc-ultisnips', 'coc-pyright', 'coc-yank' , 'coc-json', 'coc-git']

" TextEdit might fail if hidden is not set.
set hidden

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
	" Recently vim can merge signcolumn and number column into one
	set signcolumn=number
else
	set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-o> to trigger completion.
if has('nvim')
	inoremap <silent><expr> <c-o> coc#refresh()
else
	inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	elseif (coc#rpc#ready())
		call CocActionAsync('doHover')
	else
		execute '!' . &keywordprg . " " . expand('<cword>')
	endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)


" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Manage extensions.
nnoremap <silent><nowait> ,e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> ,c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> ,o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> ,s  :<C-u>CocList -I symbols<cr>
" " Show all diagnostics.
" nnoremap <silent><nowait> ,a  :<C-u>CocList diagnostics<cr>
" " Do default action for next item.
" nnoremap <silent><nowait> ,j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent><nowait> ,k  :<C-u>CocPrev<CR>
" " Resume latest coc list.
" nnoremap <silent><nowait> ,p  :<C-u>CocListResume<CR>


"------------------ color scheme ------------------
let g:gruvbox_contrast_light='soft'
" let g:airline_theme='papercolor'

"------------------ vim tex ------------------
let g:tex_flavor="tex"
let g:vimtex_view_method="zathura"
" autocmd Filetype tex set conceallevel=1
set conceallevel=1 
let g:tex_conceal='abdmg'
let g:vimtex_quickfix_mode=0

let g:vimtex_compiler_latexrun_engines = {
			\ '_'                : 'xelatex',
			\ 'pdflatex'         : 'pdflatex',
			\ 'lualatex'         : 'lualatex',
			\ 'xelatex'          : 'xelatex',
			\}

let g:vimtex_compiler_latexmk_engines = {
			\ '_'                : '-xelatex',
			\ 'pdflatex'         : '-pdf',
			\ 'dvipdfex'         : '-pdfdvi',
			\ 'lualatex'         : '-lualatex',
			\ 'xelatex'          : '-xelatex',
			\ 'context (pdftex)' : '-pdf -pdflatex=texexec',
			\ 'context (luatex)' : '-pdf -pdflatex=context',
			\ 'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
			\}

"------------------ ultisnips ------------------
" note that if map <tab> will conflict with coc.nvim “
let g:UltiSnipsExpandTrigger = '<c-l>'
let g:UltiSnipsJumpForwardTrigger = '<c-j>'
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'

" texlab
let g:tex_flavor = "latex"

" vim easy align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"------------------ coc-yank ------------------
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>

"------------------ easy motion ------------------
nmap ss <Plug>(easymotion-overwin-f2)

"------------------ dashboard ------------------
let g:dashboard_default_executive ='fzf'
nmap <Leader>sl :<C-u>SessionLoad<CR>
nmap <Leader>cn :<C-u>DashboardNewFile<CR>

nnoremap <silent> <Leader>fh :History<CR>
nnoremap <silent> <Leader>ff :Files<CR>
nnoremap <silent> <Leader>fa :Rg<CR>
nnoremap <silent> <Leader>fb :Marks<CR>
nnoremap <silent> <leader>tl :CocList todolist<CR>
nnoremap <silent> <leader>tc :Colors<CR>
nnoremap <silent> <leader>bl :Buffers<CR>

let g:dashboard_custom_shortcut={
			\ 'last_session' : 'SPC s l',
			\ 'find_history' : 'SPC f h',
			\ 'find_file' : 'SPC f f',
			\ 'new_file' : 'SPC c n',
			\ 'change_colorscheme' : 'SPC t c',
			\ 'find_word' : 'SPC f a',
			\ 'book_marks' : 'SPC f b',
			\ }

let g:dashboard_custom_shortcut['last_session'] = 'SPC s l'
let g:dashboard_custom_shortcut['find_history'] = 'SPC f h'
let g:dashboard_custom_shortcut['find_file'] = 'SPC f f'
let g:dashboard_custom_shortcut['change_colorscheme'] = 'SPC t c'
let g:dashboard_custom_shortcut['new_file'] = 'SPC c n'
let g:dashboard_custom_shortcut['find_word'] = 'SPC f a'
let g:dashboard_custom_shortcut['book_marks'] = 'SPC f b'
let g:dashboard_custom_header=[
			\' ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⣪⣭⣿⣷⣶⣄⠀⠀⠀⠀⠀⠀⠀⠀ ',
			\' ⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⠤⢤⢔⡾⣹⣿⣿⣿⣿⣿⣿⣷⡄⠀⠀⠀⠀⠀⠀ ',
			\' ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⢰⢳⣿⣿⣿⠋⣻⣿⣿⣿⣿⣿⣿⣾⣿⠟⠀⠀⠀ ',
			\' ⠀⠀⠀⠀⠀⢀⠔⠁⠀⠀⠀⢸⣼⣷⣻⣧⣴⣿⣏⣿⣿⣿⣿⣿⣿⣿⣶⣶⣦⠤ ',
			\' ⠀⠀⠀⠀⢠⠇⠀⠀⠀⠀⠀⠈⢿⣿⣷⣿⣏⡿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠛⠁⠀ ',
			\' ⠀⠀⠀⢀⠇⠀⠀⠀⠀⠀⠀⠀⠀⠹⢿⣿⣿⣿⣝⣿⣯⣾⠋⣇⠀⠀⠀⠀⠀⠀ ',
			\' ⠀⠀⢠⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡄⠀⠀⠙⣽⣝⠋⢡⣯⣀⠘⢦⡀⠀⠀⠀⠀ ',
			\' ⠀⠀⡷⡁⠀⡄⠀⢠⠻⠀⠀⠀⢸⠙⠀⠀⠀⠙⡇⢹⣧⠛⠂⠀⢤⣉⠢⡀⠀⠀ ',
			\' ⡠⢊⠚⢇⣰⢣⠀⡞⠒⠣⠀⠀⠘⡄⠘⠓⠲⢆⣳⠀⠀⣠⣄⣀⣀⠙⢯⣾⡄⠀ ',
			\' ⣇⣇⡌⠈⡜⡌⢳⣧⣤⣄⡑⠄⣀⣳⢀⣠⣤⣴⣾⡆⠀⣿⠖⣠⣮⠀⠀⣿⠇⠀ ',
			\' ⠈⠛⢇⠀⠿⠷⡘⣿⢙⠿⡏⠀⠈⠉⢻⣻⣿⡏⢹⡟⣢⣿⣟⡻⠋⢀⡴⠁⠀⠀ ',
			\' ⠀⠀⠈⠢⢤⣀⣋⡿⢮⡉⠁⠀⠀⠀⠈⢉⣙⠷⠛⠺⣿⣙⣛⠭⠝⠋⠀⠀⠀⠀ ',
			\' ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⡩⠒⠶⠲⠞⠓⢦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
			\' ⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣵⣕⣉⣫⣿⣦⠀⠱⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
			\' ⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⡾⡿⡟⣻⣿⡏⠱⣮⣿⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
			\' ⠀⠀⠀⠀⠀⠀⠀⣰⢿⡛⣿⣾⣜⣾⣿⣿⣿⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀ ',
			\' ⠀⠀⠀⠀⢀⣴⣿⣾⣿⣿⣿⣿⣿⣿⣾⡏⣿⣿⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀ ',
			\' ⠀⠀⠀⠀⢀⣵⣿⣿⣿⣿⣿⣿⣿⡿⣿⣿⣿⣿⣿⣯⣿⣿⠟⠃⠀⠀⠀⠀⠀⠀ ',
			\' ⠀⠀⠀⠀⠀⠀⠈⢻⣿⣿⣶⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⠟⠀⠀⠀⠀⠀⠀⠀⠀ ',
			\' ⠀⠀⠀⠀⠀⠀⠀⠈⠻⠿⠿⣿⣿⣿⣿⣿⣿⡿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
			\' ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣽⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
			\]

"------------------ vim-translator ------------------
" Display translation in a window
nmap <silent> <Leader>tw <Plug>TranslateW
vmap <silent> <Leader>tw <Plug>TranslateWV

"------------------ coc-todolist ------------------
"create todolist
nmap <leader>tn :CocCommand todolist.create<CR>
" list all todo items
nmap <leader>tl :CocList todolist<CR>
" JSdoc
nmap <leader>jd :CocCommand docthis.documentThis<CR>

"------------------ colorscheme ------------------
colorscheme onedark

"------------------ coc-git ------------------
" navigate chunks of current buffer
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)

" navigate conflicts of current buffer
nmap [c <Plug>(coc-git-prevconflict)
nmap ]c <Plug>(coc-git-nextconflict)

"------------------ vim-emmet ------------------
let g:user_emmet_install_global=0
autocmd FileType markdown,html,css,vue EmmetInstall
let g:user_emmet_leader_key='<c-y>'

"------------------ bracey ------------------
autocmd FileType html noremap <localleader>p :Bracey<CR>

"------------------ inline_edit ------------------
"original buffer will be saved as well.
let g:inline_edit_autowrite=1
noremap <localleader>i :InlineEdit<CR>
let g:inline_edit_new_buffer_command = "topleft vertical new"

"------------------ markdown preview  ------------------
"recognized filetypes
"these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']
nmap <C-p> <Plug>MarkdownPreviewToggle
