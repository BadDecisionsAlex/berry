{ stdenv, fetchFromGitHub, readline }:

stdenv.mkDerivation rec {

  pname   = "lsd";
  name    = "${pname}-${version}";
  version = "0.1";

  src = ./.;

  buildInputs = [ readline ];

  installPhase = ''
    mkdir -p $out/bin
    cp ${pname} $out/bin/${pname}
  '';

  meta = with stdenv.lib; {
    description = "Ultra-lightweight embedded scripting language.";
    homepage = https://github.com/Skiars/berry.git;
    license = licenses.mit;
    platforms = platforms.linux;
  };

}
