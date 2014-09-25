# django-test.vim

This is a lightweight djang test runner for Vim and MacVim.  The
code has been ported over from
[thoughtbot/vim-rspec](http://github.com/thoughtbot/vim-rspec) so it can work with django.

## Installation

Recommended installation with [vundle](https://github.com/gmarik/vundle):

```vim
Bundle 'chongkim/vim-django-test'
```

If using zsh on OS X it may be necessary to move `/etc/zshenv` to `/etc/zshrc`.

## Configuration

### Key mappings

Add your preferred key mappings to your `.vimrc` file.

```vim
" django-test.vim mappings
map <Leader>rt :call DjangoTestRunCurrentTestFile()<CR>
map <Leader>rs :call DjangoTestRunNearestTest()<CR>
map <Leader>rl :call DjangoTestRunLastTest()<CR>
map <Leader>ra :call DjangoTestRunAllTests()<CR>
```

### Custom command

Overwrite the `g:django_test` variable to run a custom command.

Example:

```vim
let g:django_test_command = "./manage.py test -v 2 {test}"
```

#### iTerm instead of Terminal

If you use iTerm, you can set `g:django_test_runner` to use the included iterm
launching script. This will run the tests in the last session of the current
terminal.

```vim
let g:django_test_runner = "os_x_iterm"
```

Credits
-------

djang-test.vim is maintained by Chong Kim.

Thanks to thoughtbot for vim-rspec.

## License

djang-test.vim is copyright © 2014 Chong Kim. It is free software, and may be
redistributed under the terms specified in the `LICENSE` file.
