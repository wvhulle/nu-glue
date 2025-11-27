#import "@preview/touying:0.6.1": *
#import themes.university: *
#import "@preview/cetz:0.3.2"
#import "@preview/fletcher:0.5.5" as fletcher: edge, node
#import "@preview/numbly:0.1.0": numbly
#import "@preview/theorion:0.3.2": *
#import cosmos.clouds: *
#show: show-theorion
#import "@preview/codly-languages:0.1.7": *
#import "@preview/codly:1.3.0": *

#show: codly-init.with()

#let qa(question, answer) = {
  let q-box = rect(radius: 0.5em, inset: 0.5em, outset: 0em, fill: yellow.lighten(70%))[#question]
  let a-box = rect(radius: 0.5em, inset: 0.5em, outset: 0em, fill: green.lighten(70%))[#answer]
  let curved-arrow = curve(
    stroke: green,
    curve.move((0em, 0em)),
    curve.quad((0em, 1em), (1em, 1em)),
  )
  // v(0.4em)
  box({
    set par(spacing: 0pt)
    q-box

    v(0.2em)
    pause
    align(right, stack(dir: ltr, curved-arrow, a-box))
  })
}


// cetz and fletcher bindings for touying
#let cetz-canvas = touying-reducer.with(reduce: cetz.canvas, cover: cetz.draw.hide.with(bounds: true))
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

#show: university-theme.with(
  aspect-ratio: "16-9",
  config-common(frozen-counters: (theorem-counter,), preamble: {
    codly(
      // number-format: it => text(size: 0.7em, fill: gray)[#it],
      number-format: none,
      number-placement: "outside",
      zebra-fill: gray.lighten(90%),
      inset: 0.2em,
      languages: codly-languages,
    )
  }), // freeze theorem counter for animation
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
#set text(size: 0.7em)
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
- Does not require `find` flags
- Built-in glob, duration and date type

#qa[What does Nu in NuShell stand for?][_New_ shell.]

= Prerequisites

== Try it out out yourself

No installation: https://www.nushell.sh/demo/

Install locally: https://www.nushell.sh/book/installation.html

- Download binary: #link("https://github.com/nushell/nushell/releases")[github.com/nushell/nushell/releases]
- Rust:
  - Install `rustup` from https://rustup.rs/
  - Add Cargo bin to your PATH if not done automatically
  - `cargo install nu`
- Mac: `brew install nushell`
- Windows (winget): `winget install nushell`
- Windows (chocolatey): `choco install nushell`

Linux:

- Debian: `apt install rustup`
- Nix: `nix-shell -p nushell`
- Snap: `sudo snap install nushell --classic`


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

= Basics

== Commands output tables

```sh
ls
# => ╭────┬─────────────────────┬──────┬───────────┬──────────────╮
# => │  # │        name         │ type │   size    │   modified   │
# => ├────┼─────────────────────┼──────┼───────────┼──────────────┤
# => │  0 │ CITATION.cff        │ file │     812 B │ 2 months ago │
# => │  1 │ CODE_OF_CONDUCT.md  │ file │   3.4 KiB │ 9 months ago │
# => │  2 │ CONTRIBUTING.md     │ file │  11.0 KiB │ 5 months ago │
# => │  3 │ Cargo.lock          │ file │ 194.9 KiB │ 15 hours ago │
# => │  4 │ Cargo.toml          │ file │   9.2 KiB │ 15 hours ago │
# => │  5 │ Cross.toml          │ file │     666 B │ 6 months ago │
# => │  6 │ LICENSE             │ file │   1.1 KiB │ 9 months ago │
# => │  7 │ README.md           │ file │  12.0 KiB │ 15 hours ago │
# => ...
```

== Sort output by column

```sh
ls | sort-by size | reverse
# => ╭───┬─────────────────┬──────┬───────────┬──────────────╮
# => │ # │      name       │ type │   size    │   modified   │
# => ├───┼─────────────────┼──────┼───────────┼──────────────┤
# => │ 0 │ Cargo.lock      │ file │ 194.9 KiB │ 15 hours ago │
# => │ 1 │ toolkit.nu      │ file │  20.0 KiB │ 15 hours ago │
# => │ 2 │ README.md       │ file │  12.0 KiB │ 15 hours ago │
# => │ 3 │ CONTRIBUTING.md │ file │  11.0 KiB │ 5 months ago │
# => │ 4 │ ...             │ ...  │ ...       │ ...          │
# => │ 5 │ LICENSE         │ file │   1.1 KiB │ 9 months ago │
# => │ 6 │ CITATION.cff    │ file │     812 B │ 2 months ago │
# => │ 7 │ Cross.toml      │ file │     666 B │ 6 months ago │
# => │ 8 │ typos.toml      │ file │     513 B │ 2 months ago │
# => ╰───┴─────────────────┴──────┴───────────┴──────────────╯
```


== Filtering output

```sh
ls | where size > 10kb
# => ╭───┬─────────────────┬──────┬───────────┬───────────────╮
# => │ # │      name       │ type │   size    │   modified    │
# => ├───┼─────────────────┼──────┼───────────┼───────────────┤
# => │ 0 │ CONTRIBUTING.md │ file │  11.0 KiB │ 5 months ago  │
# => │ 1 │ Cargo.lock      │ file │ 194.6 KiB │ 2 minutes ago │
# => │ 2 │ README.md       │ file │  12.0 KiB │ 16 hours ago  │
# => │ 3 │ toolkit.nu      │ file │  20.0 KiB │ 16 hours ago  │
# => ╰───┴─────────────────┴──────┴───────────┴───────────────╯
```


== Processes

```sh
ps
# => ╭───┬──────┬──────┬───────────────┬──────────┬──────┬───────────┬─────────╮
# => │ # │ pid  │ ppid │     name      │  status  │ cpu  │    mem    │ virtual │
# => ├───┼──────┼──────┼───────────────┼──────────┼──────┼───────────┼─────────┤
# => │ 0 │    1 │    0 │ init(void)    │ Sleeping │ 0.00 │   1.2 MiB │ 2.2 MiB │
# => │ 1 │    8 │    1 │ init          │ Sleeping │ 0.00 │ 124.0 KiB │ 2.3 MiB │
# => │ 2 │ 6565 │    1 │ SessionLeader │ Sleeping │ 0.00 │ 108.0 KiB │ 2.2 MiB │
# => │ 3 │ 6566 │ 6565 │ Relay(6567)   │ Sleeping │ 0.00 │ 116.0 KiB │ 2.2 MiB │
# => │ 4 │ 6567 │ 6566 │ nu            │ Running  │ 0.00 │  28.4 MiB │ 1.1 GiB │
# => ╰───┴──────┴──────┴───────────────┴──────────┴──────┴───────────┴─────────╯
```


== Running processes

```sh
ps | where status == Running
# => ╭───┬──────┬──────┬──────┬─────────┬──────┬──────────┬─────────╮
# => │ # │ pid  │ ppid │ name │ status  │ cpu  │   mem    │ virtual │
# => ├───┼──────┼──────┼──────┼─────────┼──────┼──────────┼─────────┤
# => │ 0 │ 6585 │ 6584 │ nu   │ Running │ 0.00 │ 31.9 MiB │ 1.2 GiB │
# => ╰───┴──────┴──────┴──────┴─────────┴──────┴──────────┴─────────╯
```


#pause


How does this work?

#pause

```sh
ps | describe
# => table<pid: int, ppid: int, name: string, status: string, cpu: float, mem: filesize, virtual: filesize> (stream)
```



#pause

== Exercise

Find processes sorted by greatest cpu utilization.

#pause

```sh
ps | where cpu > 0 | sort-by cpu | reverse
# => ───┬───────┬────────────────────┬───────┬─────────┬─────────
# =>  # │  pid  │        name        │  cpu  │   mem   │ virtual
# => ───┼───────┼────────────────────┼───────┼─────────┼─────────
# =>  0 │ 11928 │ nu.exe             │ 32.12 │ 47.7 MB │ 20.9 MB
# =>  1 │ 11728 │ Teams.exe          │ 10.71 │ 53.8 MB │ 50.8 MB
# =>  2 │ 21460 │ msedgewebview2.exe │  8.43 │ 54.0 MB │ 36.8 MB
# => ───┴───────┴────────────────────┴───────┴─────────┴─────────
```

= Pipelines

== Example

```sh
ls
| sort-by size
| reverse
| first
| get name
| cp $in ~
```

Whenever possible, Nushell commands are designed to act on pipeline input.

#qa[Why does `cp` need `$in`?][Because `cp` has two positional arguments.]

_No `\`  needed in multi-line pipelines._

Equivalent:

```sh
ls | sort-by size | reverse | first | get name | cp $in ~
```


== Battle of the pipelines

*Bash* pipeline:

#fletcher-diagram(
  spacing: (14em, 5em),
  node((1, 0), [Bash command], name: <bash>, fill: gray.lighten(70%)),

  pause,
  node((0, 0), [Stdin], name: <stdin>),
  edge(<stdin>, <text>, "->"),

  edge(<text>, <bash>, "->"),


  pause,


  node((2, -0.5), [Stdout], name: <stdout>),
  edge(<bash>, <text-stdout>, "->"),
  edge(<text-stdout>, <stdout>, "->"),

  node((2, 0.5), [Stderr], name: <stderr>),
  edge(<bash>, <text-stderr>, "->"),
  edge(<text-stderr>, <stderr>, "->"),
  pause,
  node((0.5, 0), [Text], name: <text>),
  node((1.5, -0.5), [Text], name: <text-stdout>),
  node((1.5, 0.5), [Text], name: <text-stderr>),
)

#pause

*Nu* pipeline:

#fletcher-diagram(
  spacing: (14em, 3em),
  node((1, 0), [Nu command], name: <nu>, fill: green.lighten(70%)),

  pause,
  node((0, 0), [Stdin], name: <stdin>),
  edge(<stdin>, <text>, "->"),

  edge(<text>, <nu>, "->"),


  pause,

  node((2, -0.5), [Stdout], name: <stdout>),

  edge(<nu>, <text-stdout>, "->"),
  edge(<text-stdout>, <stdout>, "->"),

  node((2, 0.5), [Stderr], name: <stderr>),
  edge(<nu>, <text-stderr>, "->"),
  edge(<text-stderr>, <stderr>, "->"),

  pause,
  node((1.5, -0.5), [Text], name: <text-stdout>),
  node((1.5, 0.5), [Text], name: <text-stderr>),

  pause,

  node((2, 0), [Typed out], name: <typed-out>),
  node((1.5, 0), [Structured \ data], name: <typed-data>, stroke: red),
  edge(<nu>, <typed-data>, "->"),
  edge(<typed-data>, <typed-out>, "->"),


  node((0.5, 0), [Structured \ data], name: <text>, stroke: red),

  pause,

  node(enclose: (<text-stdout>, <text-stderr>, <stderr>, <stdout>), fill: gray.lighten(70%), name: <legacy>),

  node((1.5, 1), [Side effects], name: <side-effects>),
  edge(<side-effects>, <legacy>, "->"),


  node(enclose: (<stdin>, <typed-data>, <nu>, <text>, <typed-out>), fill: green.lighten(70%)),
)

== Records

Tables are built from rows of records:

#codly(
  annotations: (
    (start: 1, end: 3, content: [Table]),
    (start: 4, end: 4, content: [Record]),
    (start: 5, end: 5, content: [Cell path]),
    (start: 6, end: 6, content: [String]),
  ),
)
```sh
ls
| sort-by size
| reverse
| first
| get name
| cp $in ~
```

Another way to find this out:


```sh
ls | sort-by size | reverse | first | describe
# => record<name: string, type: string, size: filesize, modified: datetime>
```


== Exercise

Spawn a process and kill it based on its name.

Hint:

#pause

```sh
ps | where name == Notepad2.exe
# => ───┬──────┬──────────────┬──────┬─────────┬─────────
# =>  # │ pid  │     name     │ cpu  │   mem   │ virtual
# => ───┼──────┼──────────────┼──────┼─────────┼─────────
# =>  0 │ 9268 │ Notepad2.exe │ 0.00 │ 32.0 MB │  9.8 MB
# => ───┴──────┴──────────────┴──────┴─────────┴─────────
```

Solution:

#pause

```sh
ps | where name == Notepad2.exe | get pid | get 0 | kill $in
# => ───┬────────────────────────────────────────────────────────────────
# =>  0 │ SUCCESS: Sent termination signal to the process with PID 9268.
# => ───┴────────────────────────────────────────────────────────────────
```

Or more concisely:

#pause

```Sh
ps | where name == Notepad2.exe | get pid.0 | kill $in
```

= Explore

== Help

Telescoping into structured data:

```sh
help commands | explore
```

Key bindings:

- Go deeper: `Enter`
- Go back: `ESC` / `q`
- Navigate: Arrow keys or `j`/`k`



== Try REPL

Open interactive data explorer with `:try` in `explore` mode.

Pipe current `explore` view into a pipeline with:

```sh
$in | select name description | where name == "ls"
```
_(in older versions, maybe `$nu` instead of `$in`)_

== Exercise


Find the help page for the `cp` command and explore its output.





Use `help commands | explore` to find all commands in the `filters` category that contain "by" in their name.

_Hint: In `:try` mode, use `where` and `=~` (or `str contains`)._

Solution:

#pause

```sh
$in | where category == filters and name =~ by
```

Shorthand for:

#pause

#codly(
  highlights: (
    (line: 3, start: 4, end: 15, fill: red),
    (line: 4, start: 4, end: 11, fill: red),
  ),
  annotations: (
    (start: 1, end: 1, content: [Table output]),
    (start: 3, end: 3, content: [Row condition 1]),
    (start: 4, end: 4, content: [Row condition 2]),
    (start: 2, end: 2, content: [Filter]),
  ),
)
```sh
help commands |
where (
  ($it.category == "filters") and
  ($it.name | str contains "by")
)
```


