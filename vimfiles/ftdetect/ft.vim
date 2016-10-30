augroup set_syntax
  autocmd!
  " JSON
  autocmd BufRead,BufNewFile *.json setfiletype json
  " HTML5
  autocmd BufRead,BufNewFile *.html setfiletype html syntax html5
  " CSS3
  autocmd BufRead,BufNewFile *.css setfiletype css syntax css3
  autocmd BufRead,BufNewFile *.scss setfiletype scss.css
  autocmd FileType css setlocal iskeyword+=-
  autocmd FileType scss.css setlocal iskeyword+=-
  autocmd FileType scss setlocal iskeyword+=-
  " rb
  autocmd BufRead,BufNewFile Gemfile setfiletype ruby
  autocmd BufRead,BufNewFile Schemafile setfiletype ruby
  " haml
  autocmd FileType haml setlocal iskeyword+=-
  " markdown
  autocmd BufRead,BufNewFile *.md setfiletype markdown
  " rails
  autocmd BufRead,BufNewFile *.jbuilder setfiletype ruby

  autocmd FileType ruby setl iskeyword+=?
augroup END
