{ lib, pkgs, ... }:
let
  inherit (lib.nixvim) defaultNullOpts;
  inherit (lib) types;
in
lib.nixvim.neovim-plugin.mkNeovimPlugin {
  name = "quarto";
  package = "quarto-nvim";

  maintainers = [ lib.maintainers.BoneyPatel ];

  settingsOptions = {
    debug = defaultNullOpts.mkBool false ''
      Enables or disables debugging.
    '';

    closePreviewOnExit = defaultNullOpts.mkBool true ''
      Closes preview on exit.
    '';

    lspFeatures.enabled = defaultNullOpts.mkBool true ''
      Enables LSP features.
    '';

    lspFeatures.chunks = defaultNullOpts.mkStr "curly" ''
      Sets chunk delimiter style.
    '';

    lspFeatures.languages =
      defaultNullOpts.mkListOf types.str
        [
          "r"
          "python"
          "julia"
          "bash"
          "html"
        ]
        ''
          List of supported languages.
        '';

    lspFeatures.diagnostics.enabled = defaultNullOpts.mkBool true ''
      Enables diagnostics.
    '';

    lspFeatures.diagnostics.triggers = defaultNullOpts.mkListOf types.str [ "BufWritePost" ] ''
      Sets triggers for diagnostics.
    '';

    lspFeatures.completion.enabled = defaultNullOpts.mkBool true ''
      Enables completion.
    '';

    codeRunner.enabled = defaultNullOpts.mkBool false ''
      Enables or disables the code runner.
    '';

    codeRunner.default_method =
      defaultNullOpts.mkEnum
        [
          "molten"
          "slime"
        ]
        null
        ''
          Sets the default code runner method. Either "molten", "slime", or `null`.
        '';

    codeRunner.ft_runners = defaultNullOpts.mkAttrsOf types.str { } ''
      Specifies filetype to runner mappings.
    '';

    codeRunner.never_run = defaultNullOpts.mkListOf types.str [ "yaml" ] ''
      List of filetypes that are never sent to a code runner.
    '';
  };

  settingsExample = {
    debug = false;
    closePreviewOnExit = true;
    lspFeatures = {
      enabled = true;
      chunks = "curly";
      language = [
        "r"
        "python"
        "julia"
      ];
      diagnostics = {
        enabled = true;
        triggers = [ "BufWritePost" ];
      };
    };
    codeRunner = {
      enabled = false;
      default_method = "vim-slime";
      ft_runners = {
        python = "molten";
      };
      never_run = [ "yaml" ];
    };
  };
}
