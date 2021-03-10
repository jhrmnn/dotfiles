let s:extfname = expand("%:e")
if index(["f"], s:extfname) >= 0
    let fortran_fixed_source=1
    unlet! fortran_free_source
else
    let fortran_free_source=1
    unlet! fortran_fixed_source
endif
let fortran_do_enddo=1
" let fortran_more_precise=1
let fortran_fold=1
let fortran_fold_conditionals=1
" let fortran_fold_multilinecomments=1
" let fortran_indent_less=1

