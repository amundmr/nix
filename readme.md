Followed [this](https://tech.aufomm.com/my-nix-journey-use-nix-with-ubuntu/) guide.

# Cheatsheet

**Update nix after changing configuration**

```bash
home-manager switch --flake /home/amund/nix/#$USER
```

** Update packages in flake **

Run this command from inside ~/nix/

```bash
nix flake update
```

Remember to re-run the nix update command above to apply changes

** Cleaning **

```bash
nix store gc
```

