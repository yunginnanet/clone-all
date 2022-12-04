# clone-all

![Screenshot](https://tcp.ac/i/OFqeb.png)

Clones and updates all github repos of a given user or organization. Supports SSH and HTTPS.

### Usage

  0) don't be on windows
  1) clone this repo
  2) run `install.sh`
  3) `clone-all target` or `clone-all --ssh target`

### Environment Variables

  - `CLONEALL_SSH`: set/export this to `true` to enable fetching/pulling via ssh by default without flag
  - `CLONEALL_DESTINATION`: set/export this to the directory you want the cloned/updated repos to live
