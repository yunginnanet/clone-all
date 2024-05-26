# clone-all

![Screenshot](https://tcp.ac/i/OFqeb.png)

Bash tool to clones and update all github repos of a given user or organization. Supports SSH and HTTPS.

### Quick Start

```bash
git clone https://github.com/yunginnanet/clone-all && cd clone-all && make install

```

### Environment Variables

#### Building

  - `CLONEALL_INSTALL_TARGET`: directory _(preferably in your path)_ to copy `clone-all` exec when running `make install`.
  - uses [install](https://linux.die.net/man/1/install).
  - defaults to `${HOME}/.local/bin` and warns if target is not in `$PATH`.

#### Runtime

- `CLONEALL_SSH`: set/export this to `true` to enable fetching/pulling via ssh by default without flag
- `CLONEALL_DESTINATION`: set/export this to the directory you want the cloned/updated repos to live
