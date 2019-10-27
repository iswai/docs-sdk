# Hugo GH pages test

## Build container

```bash
# Build container
docker build -t iswai-docs .

# Run container
docker run --rm -it -p 1313:1313 -v ${PWD}:/src iswai-docs [server|preview|build]
```

## Example sites

- https://getbootstrap.com/
- https://github.com/kubernetes/website
- https://github.com/gohugoio/hugoDocs
- https://github.com/peaceiris/hugo-test-project/tree/master/themes/hugo-iris

- https://github.com/klakegg/docker-hugo/blob/master/dist/alpine/Dockerfile-ext-alpine
- https://stackoverflow.com/questions/57570355/replace-one-branch-with-current-branch-using-github-actions
- https://hub.docker.com/r/squidfunk/mkdocs-material/
- https://github.com/squidfunk/mkdocs-material
- http://sangsoonam.github.io/2019/02/08/using-git-worktree-to-deploy-github-pages.html
- https://github.com/unacast/actions/tree/master/github-deploy
- https://github.com/peaceiris/actions-gh-pages

- https://github.com/actions/checkout
- https://help.github.com/en/github/automating-your-workflow-with-github-actions/virtual-environments-for-github-actions#environment-variables
- https://help.github.com/en/github/automating-your-workflow-with-github-actions/contexts-and-expression-syntax-for-github-actions
- https://github.com/peaceiris/actions-gh-pages/blob/master/entrypoint.sh



## TODO

### Add hugo checksum

    && wget --quiet -P /tmp https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_checksums.txt \
    && grep "${HUGO_PACKAGE}" "/tmp/hugo_${HUGO_VERSION}_checksums.txt" | sha256sum -c - \
