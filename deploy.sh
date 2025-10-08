#!/usr/bin/env bash

echo ">> Hapus .env.docker..."
rm .env.docker

echo ">> Salin storage terakhir..."
mkdir -p backend.tmp/storage
cp -r ./backend.prod/storage/app ./backend.tmp/storage/

echo ">> Hapus backend.prod lama..."
rm -rf backend.prod

echo ">> Salin backend sebagai backend.prod..."
#cp -r backend backend.prod
mkdir backend.prod
rsync -av --exclude 'node_modules' --exclude 'vendor' --exclude ".git" ./backend/ ./backend.prod

echo ">> composer install ..."
cd backend.prod && composer install
cd ../

echo ">> Ubah [backend] .env.production ke .env..."
rm ./backend.prod/.env
mv ./backend.prod/.env.production ./backend.prod/.env

echo ">> Timpa storage terakhir ke yang baru..."
rm -rf ./backend.prod/storage/app
cp -r ./backend.tmp/storage/app ./backend.prod/storage/
rm -rf backend.tmp

# -------------------

echo ">> Hapus frontend.prod lama..."
rm -rf frontend.prod

echo ">> Salin frontend sebagai frontend.prod..."
#cp -r frontend frontend.prod
mkdir frontend.prod
rsync -av --exclude 'node_modules' --exclude ".next"  --exclude ".git" ./frontend/ ./frontend.prod

echo ">> Ubah [frontend] .env.production ke .env..."
cp ./frontend.prod/.env.production ./frontend.prod/.env

# -------------------

echo ">> Composing backend sebagai kontainer..."
docker rm -f $(docker ps -a | grep aaindonesia | awk '{print $1}')
docker rmi -f $(docker images -a | grep aaindonesia | awk '{print $3}')
sed -i -e '$a\' ./backend.prod/.env
sed -i -e '$a\' ./frontend.prod/.env
cat ./backend.prod/.env ./frontend.prod/.env > ./.env.docker
#docker compose --env-file ./.env.docker up -d
docker compose --env-file ./.env.docker up redis -d
docker compose --env-file ./.env.docker up backend -d
docker compose --env-file ./.env.docker up nginx -d

php ./backend.prod/artisan route:clear
php ./backend.prod/artisan view:clear
php ./backend.prod/artisan config:clear
php ./backend.prod/artisan route:cache
php ./backend.prod/artisan storage:link

#exit
# -------------------

echo ">> pnpm install & pnpm run build ..."
cd frontend.prod && NODE_ENV=production pnpm install && NODE_ENV=production pnpm run build
cd ../

echo ">> Composing frontend sebagai kontainer..."

docker compose --env-file ./.env.docker up frontend -d

echo ">> Bersih-bersih..."
rm .env.docker
