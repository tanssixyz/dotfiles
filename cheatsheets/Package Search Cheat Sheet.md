# Package Search Cheat Sheet

# Search official repos
pacman -Ss keyword

# Search AUR + official
yay -Ss keyword

# Search installed packages only
pacman -Qs keyword

# ===== PACKAGE INFO =====

# Info about package (before installing)
pacman -Si package-name
yay -Si package-name

# Info about installed package
pacman -Qi package-name

# List files in package
pacman -Ql package-name

# Which package owns a file?
pacman -Qo /usr/bin/python

# ===== INSTALLING =====

# Install from official repos
sudo pacman -S package-name

# Install from AUR
yay -S package-name

# Install multiple packages
sudo pacman -S package1 package2 package3

# ===== REMOVING =====

# Remove package
sudo pacman -R package-name

# Remove package + unused dependencies
sudo pacman -Rs package-name

# Remove package + dependencies + config files
sudo pacman -Rns package-name

# ===== UPDATING =====

# Update official packages
sudo pacman -Syu

# Update official + AUR packages
yay -Syu

# ===== CLEANING =====

# Clean package cache
sudo pacman -Sc

# Remove orphaned packages
sudo pacman -Rns $(pacman -Qtdq)
```

---

## Online Package Search

**If unsure, search online first:**

1. **Official packages:** https://archlinux.org/packages/
2. **AUR packages:** https://aur.archlinux.org/
3. **Or just:** Google "arch linux package-name"

**Example for Python:**
- Go to archlinux.org/packages
- Search "python"
- You'll see: `extra/python` (official repo)
- Means: `sudo pacman -S python`

**Example for Kinto:**
- Go to aur.archlinux.org
- Search "kinto"
- You'll see: `kinto` (AUR)
- Means: `yay -S kinto`

---

## Decision Tree
```
Need to install something?
│
├─ Search official repos first
│  └─ pacman -Ss package-name
│     │
│     ├─ FOUND → sudo pacman -S package-name ✅
│     │
│     └─ NOT FOUND
│        └─ Search AUR
│           └─ yay -Ss package-name
│              │
│              ├─ FOUND → yay -S package-name ✅
│              │
│              └─ NOT FOUND → Package doesn't exist
│                 └─ Check spelling, try alternative names