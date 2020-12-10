# Defined in - @ line 1
function ls --wraps='exa -la --group-directories-first' --description 'alias ls=exa -la --group-directories-first'
  exa -la --group-directories-first $argv;
end
