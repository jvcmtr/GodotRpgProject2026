Starting fresh in 2026
How to setup:
- dotnet (we might need)
- godot

---

# Linux
Distro: **Linux Mint 22.3*** `[ubuntu debian]` `[x86_64]`
😥 Godot 4.0 no longer uses mono.

## 1. Install dotnet-sdk
**Version :** `8.0`
``` bash
sudo apt install dotnet-sdk-8.0
```

```bash
dotnet --version
```


## 2. Instal Godot
**Version :** `4.6.1`
**Build :** `Godot_v4.6.1` `stable_mono_linux` `x86_64`
###### Download:
from godot website 
###### Extract :
``` bash
unzip Godot_v4.6.1-stable_mono_linux-x86_64.zip
```
###### Allow Execution :
Enter the extracted directory and run
```bash
chmod +x Godot_v4.6.1-stable_mono_linux.x86_64
```
###### Add to PATH:
``` bash
sudo ln -s /home/USERNAME/path_to_godot /usr/local/bin/godot
```
###### Register App
In linuxmint:
```bash
cd ~/.local/share/applications/
{
echo "[Desktop Entry]"
echo "Name=Godot"
echo "Exec=godot"
echo "Categories=Development"
echo "Terminal=false"
echo "Type=Application"
} > godot.desktop
chmod +x godot.desktop
update-desktop-database ~/.local/share/applications/
```
