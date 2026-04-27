# KwachaAI Website

This folder holds the public-facing KwachaAI website content that will be published to `kwachaai.github.io`.

Keep public docs and web pages here, separate from the internal `_docs/` repo documentation.

From the main repo, run `npm.cmd run publish:website` to push the separate `kwachaai.github.io` repo. If you want to mirror this folder into that repo first, set `KWACHA_WEBSITE_SOURCE=website`.

## Layout

- `docs/` public documentation pages for users and readers
- `pages/` standalone public pages such as landing, about, or FAQ
- `assets/` shared images, icons, styles, and other static website files

## Notes

- This folder is content-first for now.
- Build tooling can be added later if we decide to generate the site from source instead of serving static files directly.
