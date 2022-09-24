--[[
-- CoC
--]]

local o = vim.o
local g = vim.g

o.statusline = "%{coc#status()}%{get(b:,'coc_current_function','')}"
g.coc_snippet_next = '<c-j>'
g.coc_snippet_prev = '<c-k>'

g.coc_global_extensions = {
 'coc-snippets',
 'coc-pairs',
 'coc-tsserver',
 'coc-eslint',
 'coc-prettier',
 'coc-json',
 'coc-emmet'
}

vim.cmd([[
  function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
      call CocActionAsync('doHover')
    else
      call feedkeys('K', 'in')
    endif
  endfunction
]])

