Vim compiler plugin support for Julia for a quickfix-list-based workflow. 
Populates the [quickfix list][quickfix-list] by running the active Julia
script with `:make`.

### Workflow

We assume that Vim users use the following workflow for developing Julia 
scripts.

1. Edit the script.
2. Run the script on the command line.
3. Fix errors from the output.
4. Repeat.

We call this the _command-line workflow_. Steps (2) and (3) are tedious because 
it usually involves running the script externally from Vim and reading error 
messages to determine which lines to fix. In contrast, we may use the 
quickfix-list in Vim to run the script within Vim, parse the error messages, and
navigate through errors. This plugin enables compiler plugin support for Julia
in order to leverage the _quickfix-list workflow_.

#### Example

Suppose that we have a script `test.jl` that has errors.

```julia
f(x) = g(x)
f(0)
```

We compare the two workflows for fixing the errors in script.

__Command-line workflow.__ Running `julia test.jl` from the command line produces
the following output.

```
ERROR: LoadError: UndefVarError: g not defined
Stacktrace:
 [1] f(::Int64) at /tmp/test.jl:1
while loading /tmp/test.jl, in expression starting on line 2
```

This error occurs because `g` is undefined. To fix this error, we should jump
to line 2 of `/tmp/test.jl` and fix the error as appropriate.

__Quickfix list workflow.__ While editing this file in vim, we can set
the compiler to `julia` and run the `:make` command to run the script using 
`julia`, parse the errors, and populatethe quickfix list. We start by selecting
the `julia` compiler provided by this plugin.

```
:compiler julia
```

Then we populate the quickfix list with errors by running the Julia script using
`:make`.

Once the quickfix list is populated, we can jump to the line in the file at the
top of the stacktrace using `:cnext`. Furthermore, we may list all of the parsed
errors using `:clist`.

### Selecting the compiler

By default, the Julia compiler is not used by `:make`. We can select the Julia
compiler _automtically_ or _manually_. We recommend automatically.

__Select compiler automatically__.  To enable the compiler for every buffer of
a Julia file, add the following configuration to your `.vimrc`. This requires
that the [julia-vim][julia-vim] plugin is installed.

```vim
filetype plugin on
autocmd FileType julia compile julia
```

__Select compiler manually.__ To manually enable the Julia compiler for the
active vim buffer,, set the compiler through the following command.

```
:compiler julia
```

[julia-vim]: https://github.com/JuliaEditorSupport/julia-vim
[quickfix-list]: http://vimcasts.org/episodes/search-multiple-files-with-vimgrep/
