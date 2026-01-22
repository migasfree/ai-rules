# Packaging Specialist Skill

---

name: Packaging Specialist
description: Multi-distribution packaging expert for Debian, RPM, Arch, and Windows platforms
---

## 🎯 Role Overview

As a Packaging Specialist for migasfree-client, you create and maintain distribution packages for multiple platforms. The client must be installable on Debian/Ubuntu, Fedora/RHEL/openSUSE, Arch Linux, and Windows.

## 📦 Packaging Overview

### Supported Platforms

| Platform | Package Format | Tool |
|----------|---------------|------|
| Debian/Ubuntu | `.deb` | stdeb, dpkg-buildpackage |
| Fedora/RHEL | `.rpm` | rpmbuild, setuptools |
| openSUSE | `.rpm` | rpmbuild, obs |
| Arch Linux | `.pkg.tar.zst` | PKGBUILD |
| Windows | `.msi`, `.exe` | PyInstaller, cx_Freeze |

### Project Package Files

```
migasfree-client/
├── pyproject.toml      # Main project config
├── setup.py            # Legacy setup (still used)
├── setup.cfg.d/        # Per-distro setup configs
│   ├── debian.cfg
│   ├── fedora.cfg
│   └── ...
├── stdeb.cfg           # Debian packaging config
├── stdeb.cfg.d/        # Per-distro stdeb configs
│   ├── bullseye.cfg
│   └── jammy.cfg
└── MANIFEST.in         # Source inclusion rules
```

## 🐧 Debian/Ubuntu Packaging

### Using stdeb

```bash
# Install stdeb
pip install stdeb

# Create Debian source package
python setup.py --command-packages=stdeb.command sdist_dsc

# Build .deb package
cd deb_dist/migasfree-client-*/
dpkg-buildpackage -rfakeroot -uc -us

# Result: ../migasfree-client_X.X.X-1_all.deb
```

### stdeb.cfg Configuration

```ini
[DEFAULT]
# System package dependencies (Depends: in control file)
Depends3: python3-netifaces, python3-requests, python3-cryptography, python3-rich

# Build-time dependencies
Build-Depends: debhelper (>= 9), dh-python, python3-all, python3-setuptools

# Conflicts with older package names
Conflicts: migasfree-client-python2

# Scripts to run post-installation
postinst-file: debian/postinst
```

### Distribution-Specific Configs

For different Ubuntu/Debian versions, use `stdeb.cfg.d/`:

```ini
# stdeb.cfg.d/jammy.cfg (Ubuntu 22.04)
[DEFAULT]
Depends3: python3-netifaces (>= 0.11), python3-requests (>= 2.27)
```

### Control File Fields

| Field | Purpose |
|-------|---------|
| `Package` | Package name |
| `Version` | Package version |
| `Architecture` | `all` for pure Python |
| `Depends` | Runtime dependencies |
| `Suggests` | Optional dependencies |
| `Conflicts` | Incompatible packages |
| `Description` | Package description |

## 🎩 RPM Packaging

### Using setuptools

```bash
# Build RPM directly
python setup.py bdist_rpm

# Result: dist/migasfree_client-X.X.X-1.noarch.rpm
```

### Manual spec file

```spec
Name:           migasfree-client
Version:        5.0
Release:        1%{?dist}
Summary:        Synchronizes a computer from a migasfree server

License:        GPL-3.0-or-later
URL:            https://github.com/migasfree/migasfree-client
Source0:        %{name}-%{version}.tar.gz

BuildArch:      noarch
BuildRequires:  python3-devel
BuildRequires:  python3-setuptools

Requires:       python3-netifaces >= 0.8
Requires:       python3-requests >= 2.4.3
Requires:       python3-cryptography >= 2.5
Requires:       python3-rich >= 9.5

%description
migasfree-client synchronizes computers with a migasfree server
for centralized systems management.

%prep
%autosetup

%build
%py3_build

%install
%py3_install

%files
%license LICENSE
%doc README.md
%{python3_sitelib}/migasfree_client/
%{python3_sitelib}/migasfree_client-*.egg-info/
%{_bindir}/migasfree
```

## 🏗️ Arch Linux Packaging

### PKGBUILD

```bash
# Maintainer: Your Name <email@example.com>
pkgname=migasfree-client
pkgver=5.0
pkgrel=1
pkgdesc="Synchronizes a computer from a migasfree server"
arch=('any')
url="https://github.com/migasfree/migasfree-client"
license=('GPL3')
depends=('python' 'python-netifaces' 'python-requests' 'python-cryptography' 'python-rich')
makedepends=('python-build' 'python-installer' 'python-wheel')
source=("${pkgname}-${pkgver}.tar.gz::https://github.com/migasfree/migasfree-client/archive/v${pkgver}.tar.gz")
sha256sums=('SKIP')

build() {
    cd "${pkgname}-${pkgver}"
    python -m build --wheel --no-isolation
}

package() {
    cd "${pkgname}-${pkgver}"
    python -m installer --destdir="$pkgdir" dist/*.whl
    install -Dm644 LICENSE "$pkgdir/usr/share/licenses/$pkgname/LICENSE"
}
```

## 🪟 Windows Packaging

### PyInstaller

```bash
# Install PyInstaller
pip install pyinstaller

# Create single executable
pyinstaller --onefile \
    --name migasfree \
    --icon icons/migasfree.ico \
    migasfree_client/__main__.py
```

### cx_Freeze for MSI

```python
# setup_cx.py
from cx_Freeze import setup, Executable

setup(
    name='migasfree-client',
    version='5.0',
    executables=[
        Executable('migasfree_client/__main__.py', target_name='migasfree.exe')
    ],
    options={
        'build_exe': {
            'packages': ['migasfree_client'],
            'include_files': ['conf/', 'icons/']
        },
        'bdist_msi': {
            'upgrade_code': '{GUID-HERE}'
        }
    }
)
```

## 🔍 Testing Packages

### Debian/Ubuntu

```bash
# Install test (on clean system or container)
sudo dpkg -i migasfree-client_*.deb
sudo apt-get install -f  # Fix dependencies

# Verify installation
migasfree version
dpkg -L migasfree-client

# Linting
lintian migasfree-client_*.deb
```

### RPM

```bash
# Install test
sudo rpm -i migasfree-client-*.rpm

# Or with dependencies
sudo dnf install ./migasfree-client-*.rpm

# Verify
migasfree version
rpm -ql migasfree-client

# Linting
rpmlint migasfree-client-*.rpm
```

## 🛡️ Security and Privacy

### Package Signing

- **Debian**: Sign with GPG key for repository
- **RPM**: Use GPG signing for packages
- **Windows**: Code signing certificate for executables

### Dependency Verification

- Pin dependency versions for reproducibility
- Verify package checksums in build process
- Audit dependencies for security issues

## 📂 Resources

See the `resources/` directory for:

- `debian_control_template` - Template for Debian control file
- `rpm_spec_template.spec` - Template for RPM spec file
