configuration files

---

setup for new device:
* install homebrew
* install Kitty
* install oh-my-zsh (and zsh)
* reinstall vim using brew to fix paths (or UltiSnips complains)
  * if not fixed: use `brew link vim`
* install nvim
* for fzf vim - Bat, the_silver_searcher
* for latex - MacTex, latexmk
* misc: Alfred and Amethyst
* mac keyboard shortcuts
    * move focus to next window: CMD+\`
    * new kitty window here: CMD+SHIFT+\`

#### change kitty icon

* [instructions](https://sw.kovidgoyal.net/kitty/faq/#i-do-not-like-the-kitty-icon)
* [whiskers icon](https://github.com/igrmk/whiskers)

resize to fit with other Dock icons:

```bash
convert ~/Downloads/whiskers_256x256.png -resize 235x235 -gravity center -background transparent -extent 256x256 ~/Downloads/output.png
```

