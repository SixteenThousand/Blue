echo -e "\
[gitlab.com paulcarroty vscodium repo]
name=download.vscodium.com
baseurl=https://download.vscodium.com/rpms/
enabled=1
gpgcheck=1
repo gpgcheck=1
gpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
metadata expire=1h" \
    >> /etc/yum.repos.d/vscodium.repo
