Followed [this](https://tech.aufomm.com/my-nix-journey-use-nix-with-ubuntu/) guide.

Install nix from here https://github.com/DeterminateSystems/nix-installer

# Cheatsheet

**Update nix after changing configuration**

```bash
home-manager switch --flake .
```

Home-manager will automatically call the `.nix` file that matches your username according to `flake.nix`

**Update packages in flake**

Run this command from inside `~/nix/`

```bash
nix flake update
```

Remember to re-run the nix update command above to apply changes

**Cleaning**

```bash
nix store gc
```

