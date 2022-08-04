# l3charts LaTeX package

This package defines a few simple TikZ charts that can be drawn using LaTeX
environments. This has mainly been developed as an experimentation of `expl3`
for checking what LaTeX3 really brought to facilitate package development (expansion
control, seq, prop, keys, int, bool, fp, dim, ...).

See examples in the [included documentation](l3charts-doc.pdf).

It is not yet published on [CTAN](https://www.ctan.org), but you can clone the
repository and do a `l3build install`.

```sh
git clone https://github.com/eburghar/l3charts
cd l3charts
l3build install
```
