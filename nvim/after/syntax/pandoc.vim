" Use `:scriptnames` to debug this.

" This disables spellcheck on words in normal text & list items which starts
" with a capital letter.
"syn match sxttCapitalisedWord /\<[A-Z]\w*\>/ contains=@NoSpell containedin=pandocListItem,pandocUListItem
" This is commented out because it doesn't work with italics, and it like
" `hunspell` is a better option.

" Without this the pandoc plugin does not allow headers with nonempty lines
" above them.
syn match sxttHeader +^#\{1,6} .*$+ contains=@NoSpell
hi def link sxttHeader Title
hi link pandocAutomaticLink @markup.link.url
hi link pandocStrikeout @markup.strikethrough
