-- build script for l3charts.dtx
module = "l3charts"
bundle = ""

-- Typeset configuration
typesetexe = "lualatex"
typesetopts = "--interaction=nonstopmode --shell-escape --recorder"
typesetdemofiles = {
    "l3charts-doc.tex"
}

-- Copy all files match pattern to build/doc
-- therefore use \input{java-program} instead of \input{demo-code/java-program.tex}
sourcefiles = {
    "*.sty", "*.cls", "*.ist"
}

indexstyle = "l3charts-doc.ist"

installfiles = sourcefiles

uploadconfig = {
    pkg          = "l3charts",
    version      = "0.2.0",
    author       = "Éric BURGHARD",
    uploader     = "Éric BURGHARD",
    email        = "ctan@itsufficient.me",
    license      = "lppl1.3c",
    summary      = "Customizable charts made with latex3",
    ctanPath     = "/graphics/pgf/contrib/l3charts",
    home         = "https://github.com/eburghar/l3charts.git",
    repository   = "https://github.com/eburghar/l3charts.git",
    bugtracker   = "https://github.com/eburghar/l3charts/issues",
    note         = [[Uploaded automatically by l3build]]
  }
