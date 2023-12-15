set shell := ["nu", "-c"]

# dev server
dev:
    watch theme {|| sass theme/index.scss theme.css}

# build html
build:
    marp main.md --theme theme.css --html

# build demo html
demo:
    marp demo.md --theme theme.css --html