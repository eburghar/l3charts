$pdf_mode = 4;
$postscript_mode = $dvi_mode = 0;
$lualatex = 'lualatex --synctex=1 --interaction=nonstopmode --file-line-error --shell-escape %O %S';
# $kak_session = $ENV{KAKOUNE_SESSION} || $ENV{kak_session};
$pdf_previewer=qq(start okular --unique --editor-cmd "sh -c \'echo \\"evaluate-commands -client %%opt{texlab_client} %%{evaluate-commands -try-client %%opt{jumpclient} %%{edit -- %%f %%l %%c}}\\" | kak -p \$kak_session\'" %S);
$makeindex = 'makeindex -s l3charts-doc.ist %S';
