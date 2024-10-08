echo "Environment setup shell script for Computer Club's Debian Ver.1.1"
su -c "echo 'pc-club ALL=(ALL:ALL) ALL' | sudo EDITOR='tee -a' visudo"
sudo sed -i "/cdrom/d" /etc/apt/sources.list
sudo apt update
sudo apt upgrade -y
sudo apt install gpg -y
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg
sudo apt install apt-transport-https -y
sudo apt update
sudo apt install code -y
sudo apt install python3-pip -y
pip install pygame --break-system-packages
sudo crontab -l > tempfile
echo "@reboot $(which apt) update && $(which apt) upgrade -y"
sudo crontab tempfile
rm tempfile
echo "Installation complete!"
