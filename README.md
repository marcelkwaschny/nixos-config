# NixOS Configuration

## Update the lock file
```
sudo nix flake update
```

## Apply for Work VM
```
sudo nixos-rebuild switch --flake .#work-vm
```

## Cleanup ([Docs](https://nix.dev/manual/nix/2.18/package-management/garbage-collection))
Delete all generations but the current one:
```
sudo nix-collect-garbage -d
```