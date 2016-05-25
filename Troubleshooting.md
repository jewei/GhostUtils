# Troubleshooting

## Error: Cannot find module '/var/www/ghost/node_modules/sqlite3/lib/binding/node-v46-linux-x64/node_sqlite3.node'

    apt-get install build-essential make
    service ghost stop
    rm -rf node_modules/
    npm cache clean
    npm install --unsafe-perm --production
    npm install sqlite3 --build-from-source
    service ghost start
