{ stdenv, fetchFromGitHub, readline, ncurses, my-clibs }:

stdenv.mkDerivation rec {

  pname   = "lsd";
  name    = "${pname}-${version}";
  version = "0.1";

  src = ./.;

  buildInputs = [ readline ncurses my-clibs ];

  meta = with pkgs.lib; {
    description = "Ultra-lightweight embedded scripting language.";
    homepage = https://github.com/Skiars/berry.git;
    license = licenses.mit;
    platforms = platforms.linux;
  };

}
