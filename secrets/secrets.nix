# https://github.com/ryantm/agenix
let
  mikan = builtins.readFile ../keys/id-rsa.kiyomi.pub;

  koma = builtins.readFile ../keys/id-ed25519.koma.pub;
in {
  "wired.host.key.age".publicKeys = [ koma mikan ];
  "wired.host.crt.age".publicKeys = [ koma mikan ];
}
