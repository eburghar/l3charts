-- build script for l3charts-doc.tex
module = "l3charts"

-- Typeset configuration
typesetexe = "lualatex"
typesetopts = "--interaction=nonstopmode --shell-escape --recorder --file-line-error --synctex 1"
typesetfiles = {
    "l3charts-doc.tex"
}

-- As we don't use .dtx and .ins copy all files needed to build doc
sourcefiles = {
    "*.sty", "*.cls", "*.ist", "*.tex"
}

-- custom index style
indexstyle = "l3charts-doc.ist"

installfiles = sourcefiles

uploadconfig = {
    pkg          = "l3charts",
    version      = "0.7.0",
    author       = "Éric BURGHARD",
    uploader     = "Éric BURGHARD",
    email        = "ctan@itsufficient.me",
    license      = "lppl1.3c",
    summary      = "Customizable charts made with TikZ and LaTeX3",
    topics       = {"expl3", "pgf-tikz"},
    ctanPath     = "/graphics/pgf/contrib/l3charts",
    home         = "https://github.com/eburghar/l3charts.git",
    repository   = "https://github.com/eburghar/l3charts.git",
    bugtracker   = "https://github.com/eburghar/l3charts/issues",
    note         = [[Uploaded automatically by l3build]]
  }
