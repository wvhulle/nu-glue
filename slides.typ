#import "@preview/touying:0.6.1": *
#import themes.university: *
#import "@preview/cetz:0.3.2"
#import "@preview/fletcher:0.5.5" as fletcher: edge, node
#import "@preview/numbly:0.1.0": numbly
#import "@preview/theorion:0.3.2": *
#import cosmos.clouds: *
#show: show-theorion

// cetz and fletcher bindings for touying
#let cetz-canvas = touying-reducer.with(reduce: cetz.canvas, cover: cetz.draw.hide.with(bounds: true))
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

#show: university-theme.with(
  aspect-ratio: "16-9",
  // align: horizon,
  // config-common(handout: true),
  config-common(frozen-counters: (theorem-counter,)), // freeze theorem counter for animation
  config-info(
    title: [NuShell],
    subtitle: [Superglue for your OS],
    author: [Willem Vanhulle],
    date: [Wednesday, Dec 3, 2025],
    institution: [SysGhent],
    logo: emoji.shell,
  ),
)

#title-slide()

= Introduction

#pagebreak()

What does the following Bash code do?

```bash
find . -type f -name "*.log" -mtime +30 -exec rm {} \;
```

#pause

Nu:

```sh
ls **/*.log | where modified < (date now) - 30day | rm
```

Improvements:

- Decomposes the problem with pipes
- Does not require lean `find` flags
- Built-in glob, duration and date type

= Workshop

== Installation

https://www.nushell.sh/book/installation.html

- Rust: `cargo install nu`
- Mac: `brew install nushell`
- Windows: `winget install nushell`
- Nix: `nix-shell -p nushell`
- Binaries: #link("https://github.com/nushell/nushell/releases")[github.com/nushell/nushell/releases]

== Exercises

Have a look at the `*.nu` files in this repo.

To run an exercise:

```bash
workshop.nu # With shebang
nu workshop.nu
```

To pipe in data from Bash:

```bash
cat somefile.txt | exercise.nu # With shebang
cat somefile.txt | nu exercise.nu
```

Piping within NuShell:

```sh
open somefile.txt | exercise.nu
```
