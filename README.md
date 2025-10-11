# Whirlpool - Debian 13 Live Build

Minimal `live-build` configuration for creating a customized Debian 13 (Trixie) live image.

## Requirements

- Debian-based system
- `live-build` and `debootstrap` packages
- Root privileges

## Usage

```bash
make help          # Show available commands
sudo make build    # Build the ISO image
sudo make clean    # Clean build artifacts
sudo make rebuild  # Clean and rebuild
```

The ISO image will be generated in the project root directory as `debian-live-amd64.hybrid.iso`.

## Customization

- **Packages**: Edit `config/package-lists/*.list.chroot`
- **Files**: Add to `config/includes.chroot/`
- **Hooks**: Add scripts to `config/hooks/normal/`
- **Settings**: Modify `auto/config`

## Structure

```
auto/           # live-build configuration scripts
config/
├── package-lists/      # Package lists
├── includes.chroot/    # Files to copy to system
└── hooks/normal/       # Build hooks
```

## Testing

Write to USB:
```bash
sudo dd if=debian-live-amd64.hybrid.iso of=/dev/sdX bs=4M status=progress && sync
```
**Warning:** Replace `/dev/sdX` with the correct USB device!

## References

- [Live Build Manual](https://live-team.pages.debian.net/live-manual/html/live-manual/index.en.html)
- [Debian Live Project](https://www.debian.org/devel/debian-live/)
