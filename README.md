clone into ~/.config/

It will expect a few tools to already be on your system depending on what you use. For example Clangd, clang-format, ripgrep.

If you're using C you might want to configure all the tools to your liking, like a simple compile_flags.txt in your root directory for basic clang-analyzer analysis without an explicit compile_commands.json for the project etc, and much of the .config/ files for various tools like clangd.

For example my ~/.config/clangd/config.yaml currently:
```yaml
Diagnostics:
  ClangTidy:
    Add:
      - clang-analyzer-*
      - cert-*
      - bugprone-*
      - performance-*
    Remove:
      - cert-dcl37-c
      - cert-dcl51-cpp
      - bugprone-easily-swappable-parameters
    FastCheckFilter: None
```

You will also need to call :TSInstall <language> for each language you want highlighting and LSP for.
  I configured lua to auto install since the configs are lua.

Pretty much the only difference for this WSL branch and the main one is the clip board. Other changes are not WSL specific,
  and should be added to the main branch aswell
  
I really need to make a list of the key bindings since they are spread throughout the configs.
