#! /bin/bash -x

# Codespaces and this file Largely stolen from https://github.com/helen/wcus-2021/blob/trunk/.devcontainer/setup.sh
# Thanks Helen and Thanks GPL! 

SLUG=post-format-block
PROJECT_TYPE=plugin

if [[ ! -z "$CODESPACE_NAME" ]]
then
	SITE_HOST="https://${CODESPACE_NAME}-8080.githubpreview.dev"
else
	SITE_HOST="http://localhost:8080"
fi

echo $SITE_HOST

exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>setup.log 2>&1

# Prepare a nice name from project name for the site title.
function getTitleFromSlug()
{
    local _slug=${SLUG//-/ }
    local __slug=${_slug//_/ }
    local ___slug=( $__slug )
    echo "${___slug[@]^}"
}

source ~/.bashrc

# Install dependencies
cd /var/www/html/wp-content/${PROJECT_TYPE}s/${SLUG}/
npm i && npm run build

# Install WordPress and activate the plugin/theme.
cd /var/www/html/
echo "Setting up WordPress at $SITE_HOST"
wp db reset --yes
wp config set WP_DEBUG true --raw
wp config set WP_AUTO_UPDATE_CORE development
wp core install --url="$SITE_HOST" --title="$(getTitleFromSlug) Development" --admin_user="admin" --admin_email="admin@example.com" --admin_password="password" --skip-email
wp plugin install --activate gutenberg
wp plugin install --activate wordpress-beta-tester 
wp core update

echo "Activate $SLUG"
wp $PROJECT_TYPE activate $SLUG