{ pkgs, ... }: with pkgs; [
  ( python311.withPackages (
    p: 
      with p; [
        pygobject3
      ]
    )
  )
  ( pypy3.withPackages (
    py: 
      with py; [
        pygobject3
	requests
      ]
    )
  )
] ++ [
  gobject-introspection
  pipenv
]
