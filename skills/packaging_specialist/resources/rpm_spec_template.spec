# RPM Spec File Template for migasfree-client
#
# This template shows the format for building RPM packages.
# Customize based on the target distribution (Fedora, RHEL, openSUSE).

Name:           migasfree-client
Version:        5.0
Release:        1%{?dist}
Summary:        Systems management client for migasfree

License:        GPL-3.0-or-later
URL:            https://github.com/migasfree/migasfree-client
Source0:        %{name}-%{version}.tar.gz

BuildArch:      noarch

# Build requirements
BuildRequires:  python3-devel
BuildRequires:  python3-setuptools

# Runtime requirements
Requires:       python3
Requires:       python3-netifaces >= 0.8
Requires:       python3-requests >= 2.4.3
Requires:       python3-requests-toolbelt >= 0.5.0
Requires:       python3-cryptography >= 2.5
Requires:       python3-rich >= 9.5
Requires:       python3-jwcrypto >= 0.5.0
Requires:       python3-magic
Requires:       lshw >= B.02.15
Requires:       dmidecode

# Recommended packages
Recommends:     cups

# Conflicts with old package name
Conflicts:      migasfree-client-python2
Obsoletes:      migasfree-client-python2 < %{version}

%description
migasfree-client synchronizes computers with a migasfree server
to provide centralized systems management including:
 * Software deployment and package management
 * Hardware and software inventory collection
 * Device (printer) configuration
 * Centralized error and fault reporting
 * Attribute-based policy management

This package provides the command-line client for managed computers.

%prep
%autosetup -n %{name}-%{version}

%build
%py3_build

%install
%py3_install

# Install configuration file
install -D -m 644 conf/migasfree.conf %{buildroot}%{_sysconfdir}/migasfree.conf

# Install icons
install -D -m 644 icons/scalable/migasfree.svg %{buildroot}%{_datadir}/icons/hicolor/scalable/apps/migasfree.svg
install -D -m 644 icons/scalable/migasfree-server-network.svg %{buildroot}%{_datadir}/icons/hicolor/scalable/apps/migasfree-server-network.svg

# Create var directory for client data
install -d -m 755 %{buildroot}%{_localstatedir}/migasfree-client

%files
%license LICENSE
%doc README.md AUTHORS INSTALL
%config(noreplace) %{_sysconfdir}/migasfree.conf
%{python3_sitelib}/migasfree_client/
%{python3_sitelib}/migasfree_client-%{version}*.egg-info/
%{_bindir}/migasfree
%{_datadir}/icons/hicolor/scalable/apps/migasfree*.svg
%dir %{_localstatedir}/migasfree-client

%post
# Post-installation script
# Update icon cache
touch --no-create %{_datadir}/icons/hicolor &>/dev/null || :

%postun
# Post-uninstallation script
if [ $1 -eq 0 ] ; then
    touch --no-create %{_datadir}/icons/hicolor &>/dev/null
    gtk-update-icon-cache %{_datadir}/icons/hicolor &>/dev/null || :
fi

%changelog
* Mon Jan 01 2025 Jose Antonio Chavarría <jachavar@gmail.com> - 5.0-1
- Initial RPM package
- Full mTLS support
- Multi-platform package management
