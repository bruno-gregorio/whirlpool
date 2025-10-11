# Whirlpool - Debian 13 Live Build

Minimal Debian 13 (Trixie) live image with GNOME desktop and dracut.

## Usage

```bash
sudo make build    # Build ISO
sudo make clean    # Clean
sudo make rebuild  # Clean and rebuild
```

## Configuration

- `config/package-lists/` - Package selection
- `auto/config` - Build settings (dracut, no recommends)
- `config/hooks/normal/` - Build hooks

## License

GPL-3.0 - See [LICENSE](LICENSE) file for details.
