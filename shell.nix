with import <nixpkgs> {};
let
  # define packages to install with special handling for OSX
  basePackages = [
    gnumake
    gcc
    elixir
    inotify-tools
  ];


  inputs = basePackages
    ++ lib.optional stdenv.isLinux inotify-tools
    ++ lib.optionals stdenv.isDarwin (with darwin.apple_sdk.frameworks; [
        CoreFoundation
        CoreServices
      ]);
			
  # define shell startup command
  hooks = ''
    unset SOURCE_DATE_EPOCH

    # this allows mix to work on the local directory
    mkdir -p .nix-mix
    mkdir -p .nix-hex
    export MIX_HOME=$PWD/.nix-mix
    export HEX_HOME=$PWD/.nix-hex
    export PATH=$MIX_HOME/bin:$PATH
    export PATH=$HEX_HOME/bin:$PATH
    export LANG=en_US.UTF-8
    export PATH=$PATH:$(pwd)/_build/pip_packages/bin
    export ERL_AFLAGS="-kernel shell_history enabled"
  '';

in mkShell {
  buildInputs = inputs;
  shellHook = hooks;
}
