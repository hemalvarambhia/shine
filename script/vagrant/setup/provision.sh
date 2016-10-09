set -e

# set locale to UTF-8 compatible.
locale-gen en_GB.utf8
update-locale LANG=en_GB.utf8 LC_ALL=en_GB.utf8
export LANG=en_GB.utf8
export LC_ALL=en_GB.utf8

apt-get update

# upgrade all packages
apt-get upgrade -y

apt-get install -y ruby2.0 libruby2.0 ruby2.0-dev \
                     libmagickwand-dev libxml2-dev libxslt1-dev nodejs \
                     apache2 apache2-threaded-dev build-essential git-core \
                     postgresql postgresql-contrib libpq-dev postgresql-server-dev-all \
                     libsasl2-dev imagemagick
gem2.0 install bundler

pushd /srv/shine
sudo -u vagrant -H bundle install

db_user_exists=`sudo -u postgres psql postgres -tAc "select 1 from pg_roles where rolname='vagrant'"`
if [ "$db_user_exists" != "1" ]; then
                sudo -u postgres createuser -s vagrant
		sudo -u postgres createuser --createdb --login shine
		sudo -u vagrant -H createdb -E UTF-8 -O shine shine_development
		sudo -u vagrant -H createdb -E UTF-8 -O shine shine_test
fi

# migrate the database to the latest version
sudo -u vagrant rake db:migrate
