augroup set_syntax
  autocmd!
  " JSON
  autocmd BufRead,BufNewFile *.json setfiletype json
  " HTML5
  autocmd BufRead,BufNewFile *.html setfiletype html syntax html5
  " CSS3
  autocmd BufRead,BufNewFile *.css setfiletype css syntax css3
  autocmd BufRead,BufNewFile *.scss setfiletype scss.css
  " rb
  autocmd BufRead,BufNewFile Gemfile setfiletype ruby
  " markdown
  autocmd BufRead,BufNewFile *.md setfiletype markdown
  " rails
  autocmd BufRead,BufNewFile *.jbuilder setfiletype ruby
augroup END
