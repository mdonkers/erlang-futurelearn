# README

Repo for tracking progress of Erlang MOOC

## Erlang Shell commands

Quit:         `q().`
Compile file: `c("dir/file").`

## Common Test commands

Run tests from command-line: `ct_run -suite Name_SUITE`
Run tests from Erlang shell: `ct:run_test([{suite, "dir/Name_SUITE"}]).`
Or run from a spec file:     `ct:run_test([{spec, "tests.spec"}]).`

## Vim Erlang plugin commands

Code completion (from edit mode): `Ctrl-X-Ctrl-O`
Navigate function declarations: `]]` or `[[` or `]m` or `[m`
Template new module: `:ErlApplication`
Template new test-suite: `:ErlCTSuite`
Build / compile file: `:make`
Ctrl-P clear caches (after new file created): `:CtrlPClearAllCaches`

