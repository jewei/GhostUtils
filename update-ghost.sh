#!/bin/bash
# Written by Jewei Mak <jewei.mak@gmail.com> for Digital Ocean Ghost (one-click-install) to the latest version.

# Stop Ghost.
service ghost stop

# Goto working dir.
cd /var/www/ghost

# Backup database.
for file in /var/www/ghost/content/data/*.db;
  do cp "$file" "${file}-backup-`date +%Y%m%d`";
done

# Clear dir and file.
rm -rf /var/www/ghost/ghost-temp /var/www/ghost/ghost-latest.zip /var/www/ghost/latest.zip

# Get lastest package.
curl -o /var/www/ghost/latest.zip -Lk https://ghost.org/zip/ghost-latest.zip
unzip /var/www/ghost/latest.zip -d /var/www/ghost/ghost-temp

# Remove the core directory completely.
rm -rf /var/www/ghost/core

# Copy the new files over.
yes | cp -R /var/www/ghost/ghost-temp/core /var/www/ghost
yes | cp /var/www/ghost/ghost-temp/*.js /var/www/ghost
yes | cp /var/www/ghost/ghost-temp/*.json /var/www/ghost
yes | cp /var/www/ghost/ghost-temp/*.md /var/www/ghost
yes | cp -R /var/www/ghost/content/themes/casper /var/www/ghost/content/themes

# Delete temp folder.
rm -rf /var/www/ghost/ghost-temp /var/www/ghost/latest.zip

# Upgrade dependencies:
npm install --production

# Set permissions.
chown -R ghost:ghost /var/www/ghost

# Start Ghost.
service ghost start

# Print friendly message :)
echo "Ghost updated."
