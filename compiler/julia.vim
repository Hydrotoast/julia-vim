" Vim compiler file
" Language:   Julia
" Function:   Syntax check and/or error reporting
" Maintainer: Gio Borje <gccielo@gmail.com>

if exists("current_compiler")
    finish
endif
let current_compiler = "julia"

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo-=C

CompilerSet makeprg=julia\ %

" Detects errors that occur when running the underlying Julia file using the
" julia binary.
"
" Example:
"
" ERROR: LoadError: UndefVarError: h not defined
" Stacktrace:
"  [1] g at /tmp/g.jl:3 [inlined]
"  [2] f(::Int64) at /tmp/f.jl:13
" while loading /tmp/f.jl, in expression starting on line 17

CompilerSet errorformat=
  \%EERROR:\ LoadError:\ %m,
  \%CStacktrace:,
  \%+Zwhile\ loading%.%#,
  \%C\ \[1]\ %*[^\ ]\ at\ %f:%l%.%#,
  \%C\ \[%*\\d\]%.%#

let &cpo = s:cpo_save
unlet s:cpo_save
