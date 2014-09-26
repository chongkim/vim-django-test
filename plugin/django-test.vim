let s:plugin_path = expand("<sfile>:p:h:h")

if !exists("g:django_test_runner")
  let g:django_test_runner = "os_x_terminal"
endif

if !exists("g:django_test_vimcommand")
  if !exists("g:django_test_command")
    let g:django_test_command = "./manage.py test {test}"
  endif

  if has("gui_running") && has("gui_macvim")
    let g:django_test_vimcommand = "silent !" . s:plugin_path . "/bin/" . g:django_test_runner . " " . shellescape(g:django_test_command)
  else
    let g:django_test_vimcommand = "!clear && echo " . g:django_test_command . " && " . g:django_test_command
  endif
endif

function! GetModule()
  return substitute(expand('%:r'),"/",".","g")
endfunction

function! DjangoTestRunAllTests()
  let l:test = ""
  call DjangoTestSetLastTestCommand(l:test)
  call DjangoTestRunTests(l:test)
endfunction

function! DjangoTestRunCurrentTestFile()
  if DjangoTestInTestFile()
    let l:test = GetModule()
    call DjangoTestSetLastTestCommand(l:test)
    call DjangoTestRunTests(l:test)
  else
    call DjangoTestRunLastTest()
  endif
endfunction

function! DjangoTestRunNearestTest()
  let pos = getpos(".")
  normal $
  call search("\\s*def .", "be")
  let funcname = expand("<cword>")
  normal $
  call search("\\s*class .", "be")
  let classname = expand("<cword>")
  call setpos('.', pos)
  if DjangoTestInTestFile()
    let l:test = GetModule() . "." . classname . "." . funcname
    call DjangoTestSetLastTestCommand(l:test)
    call DjangoTestRunTests(l:test)
  else
    call DjangoTestRunLastTest()
  endif
endfunction

function! DjangoTestRunLastTest()
  if exists("s:last_test_command")
    call DjangoTestRunTests(s:last_test_command)
  endif
endfunction

function! DjangoTestInTestFile()
  return match(expand("%"), "test.*\\.py") != -1
endfunction

function! DjangoTestSetLastTestCommand(test)
  let s:last_test_command = a:test
endfunction

function! DjangoTestUnsetLastTestCommand()
  unlet! s:last_test_command
endfunction

function! DjangoTestRunTests(test)
  execute substitute(g:django_test_vimcommand, "{test}", a:test, "g")
endfunction
