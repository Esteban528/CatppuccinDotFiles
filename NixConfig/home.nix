{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [];
  home.username = "estebandev";
  home.homeDirectory = "/home/estebandev";
  home.packages = with pkgs; [
    neofetch
    brave
    vlc
    tree
    vesktop
    nautilus
    nitch
    playerctl
    btop
    htop
    wezterm
    dig
    spotube
    gimp
    inkscape
    mpc-cli
    obs-studio
    lazygit
    zapzap
    telegram-desktop
    joshuto
    evince
    filezilla
    # lutris-unwrapped
    #lutris
    image-roll
    kitty
    gedit
    ktorrent
    maven
    vscode
    # tableplus
    postman
    dbeaver-bin
    nautilus-open-any-terminal
    zed-editor

    # speedtest-cli

    # Desktop
    eww
    jq
    wofi
  ];

  stylix.enable = true;
  stylix.autoEnable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  stylix.image = ./result_33.png;
  stylix.cursor.package = pkgs.bibata-cursors;
  stylix.cursor.name = "Bibata-Modern-Ice";
  stylix.cursor.size = 20;
  stylix.polarity = "dark";
  stylix.targets.gtk.enable = true;
  # stylix.targets.kitty.enable = false;
  stylix.targets.hyprpaper.enable = true;

  stylix.targets.dunst.enable = true;
  # home.sessionVariables.EMPHASIS_COLOR = config.stylix.base16Scheme.base0E;
  programs.btop.enable = true;
  programs.htop.enable = true;

  programs.kitty = {
    enable = true;
    font.name = lib.mkForce "JetBrains Mono Nerd Font";
    settings = {
      confirm_os_window_close = 0;
      enable_audio_bell = true;
      cursor_shape = "beam";
      url_style = "curly";
      font_size = lib.mkForce 11;
      cursor_underline_thickness = 7;
      mouse_hide_wait = "3.0";
      window_padding_width = 6;
      background_opacity = lib.mkForce "0.9999";
    };

    extraConfig = ''
        detect_urls yes
        repaint_delay 10
        input_delay 3
        sync_to_monitor yes

        # Keys
        map ctrl+left neighboring_window left
        map ctrl+right neighboring_window right
        map ctrl+up neighboring_window up
        map ctrl+down neighboring_window down

        map ctrl+shift+z toggle_layout_stack

        map F1 copy_to_buffer a
        map F2 paste_from_buffer a

        map ctrl+shift+enter new_window_with_cwd
        map ctrl+shift+t new_tab_with_cwd

        shell fish

      background #111111
    '';
  };

  services.dunst = {
    enable = true;
    settings = {
      global = {
        timeout = 2;
        title = "Dunst";
        class = "Dunst";
        monitor = 0;
        follow = "mouse";
        width = 300;
        height = 400;
        origin = "top-right";
        offset = "20x20";
        indicate_hidden = true;
        shrink = true;

        transparency = 5;
        separator_height = 3;
        padding = 8;
        horizontal_padding = 11;
        frame_width = 2;

        line_height = 0;
        markup = "full";
        format = "<span size='x-large' weight='bold'>%s</span>\n%b";
        alignment = "center";

        idle_threshold = 120;
        show_age_threshold = 60;
        sort = "no";
        word_wrap = true;
        ignore_newline = false;
        stack_duplicates = false;
        hide_duplicate_count = true;
        show_indicators = false;
        sticky_history = false;
        history_length = 20;
        always_run_script = true;
        corner_radius = 8;
        icon_position = "left";
        max_icon_size = 80;

        mouse_left_click = "do_action";
        mouse_middle_click = "close_all";
        mouse_right_click = "close_current";
      };
    };
  };

  # wayland.windowManager.hyprland.enable = true;
  # wayland.windowManager.hyprland.settings.general."col.active_border" = lib.mkForce "rgb(${config.stylix.base16Scheme.base0E})";

  home.stateVersion = "23.11";
}
