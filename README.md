# docs-sdk

## Preview documentation

```bash
# Build documentation into ./build
docker run --rm -v ${PWD}:/src iswai/docs build

# Preview documentation at http:/localhost:1313/
docker run --rm -p 1313:1313 -v ${PWD}:/src iswai/docs server

# Preview documentation at http:/localhost:1313/ (including draft and future content)
docker run --rm -p 1313:1313 -v ${PWD}:/src iswai/docs preview
```

## Build container locally

```bash
# Build container
docker build -t docs .

# Run container
docker run --rm -it -p 1313:1313 -v ${PWD}:/src docs [server|preview|build]
```

## TODO

### Add hugo checksum

    && wget --quiet -P /tmp https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_checksums.txt \
    && grep "${HUGO_PACKAGE}" "/tmp/hugo_${HUGO_VERSION}_checksums.txt" | sha256sum -c - \

## Resources

- https://github.com/actions/checkout
- https://help.github.com/en/github/automating-your-workflow-with-github-actions/virtual-environments-for-github-actions#environment-variables
- https://help.github.com/en/github/automating-your-workflow-with-github-actions/contexts-and-expression-syntax-for-github-actions

- https://github.com/peaceiris/actions-gh-pages
- https://github.com/peaceiris/hugo-test-project/tree/master/themes/hugo-iris
- https://stackoverflow.com/questions/57570355/replace-one-branch-with-current-branch-using-github-actions
- https://github.com/squidfunk/mkdocs-material
- http://sangsoonam.github.io/2019/02/08/using-git-worktree-to-deploy-github-pages.html
