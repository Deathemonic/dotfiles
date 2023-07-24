{ outputs, inputs, ... }: let

  additions = final: _: import ../pkgs { pkgs = final; };

  modifications = final: prev: {
    ncmpcpp = prev.ncmpcpp.overrideAttrs ( old: 
      rec {
        src = prev.fetchFromGitHub {
          owner = "ncmpcpp";
          repo = "ncmpcpp";
          rev = "417d7172e5587f4302f92ea6377268dca7f726ad";
          sha256 = "LRf/iWxRO9zX+MZxIQbscslicaWzN7kokzJLUVg7T38=";
        };
      
        nativeBuildInputs = old.nativeBuildInputs ++ [
          prev.autoconf
          prev.automake
          prev.libtool
        ];

        preConfigure = "./autogen.sh";
      }
    );

    pypy3 = prev.pypy3.overrideAttrs ( old: 
      rec {
      	version = "7.3.12";
        src = prev.fetchurl {
          url = "https://downloads.python.org/pypy/pypy3.10-v7.3.12-linux64.tar.bz2";
	  sha256 = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
        };
      }
    );
  };

in {
  default = final: prev: ( additions final prev ) // ( modifications final prev );
}
