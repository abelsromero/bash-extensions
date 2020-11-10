symtax on
set number
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ [BUFFER=%n]\ %{strftime('%c')}

:autocmd InsertEnter * set cul
:autocmd InsertLeave * set nocul

nnoremap <S-k> :m .-2<CR>==
nnoremap <S-j> :m .+1<CR>==