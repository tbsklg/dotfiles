{ stdenv, zig_0_17, host }:
stdenv.mkDerivation {
  pname = "dot";
  version = "0.1.0";
  src = ./.;
  nativeBuildInputs = [ zig_0_17.hook ];
  preBuild = ''
    echo 'pub const host = "${host}";' > src/config.zig
  '';
  meta.mainProgram = "dot";
}
