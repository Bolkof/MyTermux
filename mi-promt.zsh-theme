# ==============================
# VARIABLES BÁSICAS DEL PROMPT
# ==============================

# Usuario y host
user_host="%{$fg[cyan]%}%n@%m%{$reset_color%} "

# Directorio actual
current_dir="%{$fg[blue]%}%~%{$reset_color%} "

# Entornos dinámicos
local conda_prompt='$(conda_prompt_info)'
local vcs_branch='$(git_prompt_info_extended)$(hg_prompt_info)'
local rvm_ruby='$(ruby_prompt_info)'
local venv_prompt='$(virtualenv_prompt_info)'

# Kubernetes
if [[ "${plugins[@]}" =~ 'kube-ps1' ]]; then
    local kube_prompt='$(kube_ps1)'
else
    local kube_prompt=''
fi

ZSH_THEME_RVM_PROMPT_OPTIONS="i v g"

# ==============================
# PROMPT PRINCIPAL
# ==============================
PROMPT="╭─${conda_prompt}${user_host}${current_dir}${rvm_ruby}${vcs_branch}${venv_prompt}${kube_prompt}
╰─%B${user_symbol}%b "
RPROMPT="%B${return_code}%b"

# ==============================
# COLORES Y PREFIJOS
# ==============================
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}●%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[yellow]%}"

ZSH_THEME_HG_PROMPT_PREFIX="$ZSH_THEME_GIT_PROMPT_PREFIX"
ZSH_THEME_HG_PROMPT_SUFFIX="$ZSH_THEME_GIT_PROMPT_SUFFIX"
ZSH_THEME_HG_PROMPT_DIRTY="$ZSH_THEME_GIT_PROMPT_DIRTY"
ZSH_THEME_HG_PROMPT_CLEAN="$ZSH_THEME_GIT_PROMPT_CLEAN"

ZSH_THEME_RUBY_PROMPT_PREFIX="%{$fg[red]%}‹"
ZSH_THEME_RUBY_PROMPT_SUFFIX="› %{$reset_color%}"

ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX="%{$fg[green]%}‹"
ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="› %{$reset_color%}"
ZSH_THEME_VIRTUALENV_PREFIX="$ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX"
ZSH_THEME_VIRTUALENV_SUFFIX="$ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX"

# ==============================
# FUNCIÓN: git_prompt_info_extended
# Muestra rama, commits adelante/atrás y estado (mini git status en español)
# ==============================
git_prompt_info_extended() {
    local branch ahead behind untracked staged conflicts changed

    # Rama actual
    branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null) || return

    # Adelante / atrás respecto a origin
    #ahead=$(git rev-list --left-only origin/$branch...HEAD 2>/dev/null | wc -l | tr -d ' ')
    #behind=$(git rev-list --right-only origin/$branch...HEAD 2>/dev/null | wc -l | tr -d ' ')
    # Adelante / atrás respecto a origin
    ahead=$(git rev-list --count --left-only HEAD...origin/$branch 2>/dev/null)
    behind=$(git rev-list --count --right-only HEAD...origin/$branch 2>/dev/null)



    # Estado de archivos
    untracked=$(git ls-files --others --exclude-standard 2>/dev/null | wc -l | tr -d ' ')
    staged=$(git diff --cached --name-only 2>/dev/null | wc -l | tr -d ' ')
    conflicts=$(git diff --name-only --diff-filter=U 2>/dev/null | wc -l | tr -d ' ')
    changed=$(git diff --name-only 2>/dev/null | wc -l | tr -d ' ')

    # Construcción del prompt
    local out="%{$fg[yellow]%}‹${branch}"

    # Adelante / atrás
    [[ $ahead -gt 0 ]] && out+=" %{$fg[green]%}+${ahead}%{$fg[yellow]%}"
    [[ $behind -gt 0 ]] && out+=" %{$fg[red]%}-${behind}%{$fg[yellow]%}"

    # Estado del repo (mini git status)
    [[ $staged -gt 0 ]] && out+=" %{$fg[green]%}⧉${staged}%{$fg[yellow]%}"        # staged
    [[ $changed -gt 0 ]] && out+=" %{$fg[blue]%}✎${changed}%{$fg[yellow]%}"       # modificados
    [[ $untracked -gt 0 ]] && out+=" %{$fg[magenta]%}?${untracked}%{$fg[yellow]%}" # sin seguimiento
    [[ $conflicts -gt 0 ]] && out+=" %{$fg[red]%}✖${conflicts}%{$fg[yellow]%}"     # conflictos

    out+="› %{$reset_color%}"

    echo $out
}
