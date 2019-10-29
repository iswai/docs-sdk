#!/bin/sh
set -eo pipefail

error()
{
	echo -e "\033[0;31m[ ERROR ] $1\033[0m" 1>&2
	exit 1
}

info()
{
	echo -e "\033[1;32m$1\033[0m" 1>&2
}

if [ "$GITHUB_WORKSPACE" ]; then
    SOURCE=$GITHUB_WORKSPACE
else
    SOURCE=/src
fi

if [ ! -d "$SOURCE/docs" ]; then
    error "Missing docs dir '$SOURCE/docs'"
fi

if [ ! -d "$SOURCE/.git" ]; then
    error "Missing .git dir '$SOURCE/.git'"
fi

info "Detected source location '$SOURCE'"

info "Mounting source paths to workspace..."

ln -sf $SOURCE/.git /workspace/.git
ln -sf $SOURCE/docs /workspace/docs

cd /workspace

info "Copying project configuration..."

cp $SOURCE/docs/config.yaml /workspace/config/production/config.yaml
cp $SOURCE/docs/params.yaml /workspace/config/production/params.yaml
cp $SOURCE/docs/params.yaml /workspace/config/staging/params.yaml

if [ "$1" == 'server' ]; then
    info "Hugo configuration..."
    hugo config --environment production

    info "Starting production server..."
    hugo server --environment production --bind 0.0.0.0 --baseURL http://localhost:1313/
    exit 0
fi

if [ "$1" == 'preview' ]; then
    info "Hugo configuration..."
    hugo config --environment staging

    info "Starting staging preview server, including drafts and future content"
    hugo server --environment staging --bind 0.0.0.0 --baseURL http://localhost:1313/ --buildDrafts --buildFuture
    exit 0
fi

if [ "$1" == 'build' ]; then
    if [ -d "$SOURCE/build" ]; then
        info "Cleaning up build path..."
        rm -rf $SOURCE/build/*
    else
        info "Creating build path..."
        mkdir $SOURCE/build
    fi

    info "Mounting build path..."
    ln -sf $SOURCE/build /workspace/build

    info "Hugo configuration..."
    hugo config --environment production

    info "Building documents..."
    hugo --environment production --minify

    info "Setting ownership for build output..."
    chown -R `stat -c "%u:%g" $SOURCE` $SOURCE/build
    exit 0
fi

error "Invalid command arguments. Use one of 'server', 'preview' or 'build'."
exit 1
