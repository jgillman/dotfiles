" From http://stackoverflow.com/a/5703164/916604

function! has#colorscheme(name)
  let pat = 'colors/' . a:name . '.vim'
  return !empty(globpath(&rtp, pat))
endfunction
