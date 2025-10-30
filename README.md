# Whirlpool - Debian 13 Live Build

Minimal Debian 13 (Trixie) live image with GNOME desktop and dracut.

## Project Description
This repo serves the purpose of building a debian live image with some changes. As any live image, it has two modes: the live mode and the final installation. The goal with the live mode is to be as compatible as possible, avoiding any unecessary changes in order to not break the compatibility already present thanks to the efforts of the debian team. The final installation must fulfill the following requirements:
- Use Dracut instead of iniramfs-tools
- Have a reduced set of packages, the default gnome debian installation includes too many things, I want to omit things like games, office and support for south-east asian languages from this spin.
- Install refind at the end of the installation process with the refind-theme-regular, as defined by the git submodule.
- A compressão das padrão deve ser zstd e não glib
Project wide, I have the following goals:
- Project scripts and tasks must be handled by Make.
- Keep the documentation inside scripts minimal.
- Avoid custom scripts for anything that can be done declaratively with the debian live-build tool.

## Usage

```bash
git submodule update --init --recursive  # Initialize submodules
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
