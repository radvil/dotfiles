augroup MyJavascriptCommands
  au!
  autocmd BufWritePost *.js :silent! Prettier
augroup END
