{ stdenv, fetchFromGitHub, readline }:

stdenv.mkDerivation rec {

  pname   = "lsd";
  name    = "${pname}-${version}";
  version = "0.1";

  src = ./.;

  buildInputs = [ readline ];

  meta = with stdenv.lib; {
    description = "Ultra-lightweight embedded scripting language.";
    homepage = https://github.com/Skiars/berry.git;
    license = licenses.mit;
    platforms = platforms.linux;
  };

}
