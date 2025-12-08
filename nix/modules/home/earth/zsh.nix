_: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = ["colorize" "colored-man-pages" "ssh" "sudo"];
    };
  };
  programs.kitty.settings.shell = "zsh";
}
