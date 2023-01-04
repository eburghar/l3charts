# l3charts LaTeX package

This package defines a few simple TikZ charts that can be drawn using LaTeX
environments.

See examples in the [included documentation](l3charts-doc.pdf).

# Motivation

This package has been developed mainly to typeset a fancy résumé, but perhaps it could be
used in other contexts too. I didn't want to write TikZ charts directly in the document
as it would have turned a simple typesetting file into an unreadable document, and I would have
forgotten every detail after just a few months.

I wouldn't have the patience to develop this with LaTeX or TeX either, but I was curious enough
about `expl3` to try an implementation. You should probably take this package as a rough
tutorial on how to develop with `expl3` because it uses nearly all the types defined in the
reference documentation (expansion control, `seq`, `prop`, `keys`, `int`, `bool`, `fp`, `dim`,
`msg`, ...) in straightforward ways.

TeX will always be that dusty tech you can't ignore because there are so many (unmatched)
packages coming from academic circles. `expl3` gives a touch of modernity and facilitates a
lot package development by allowing to easily bridge LaTeX packages together (here LaTeX and TikZ).

# Installation

It is not yet published on [CTAN](https://www.ctan.org), but you can clone the
repository and do a `l3build install`.

```sh
git clone https://github.com/eburghar/l3charts
cd l3charts
l3build install
```
