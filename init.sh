#!/usr/bin/env bash
#########################################################################
# File Name: init.sh
# Author: Hongjin Li
# mail: 872648180@qq.com
# Created Time: Wed 22 Apr 2026 03:35:30 PM CST
#########################################################################

repo_root=""

vim_plugin_manager=""

function get_repo_root()
{
    init_tool_dir=$(dirname $(readlink -f "$0"))
    repo_root=$(git -C ${init_tool_dir} rev-parse --show-toplevel)
    echo "git repo root: ${repo_root}"
}

# =============================================================================
#  link tools
# =============================================================================

function create_link()
{
    src="$1"
    target="$2"

    [ ! -e "${src}" ] && { echo "error: source ${src} not exist!"; return 1; }

    if [ -L "${target}" ]; then
        echo "link already exists: ${target} -> $(readlink -f ${target})"
        read -p "  overwrite? [y/N]: " confirm
        [ "${confirm}" != "y" ] && { echo "  skipped."; return 0; }
        rm "${target}"
    elif [ -e "${target}" ]; then
        echo "warning: ${target} exists and is not a symlink"
        read -p "  remove and link? [y/N]: " confirm
        [ "${confirm}" != "y" ] && { echo "  skipped."; return 0; }
        rm -rf "${target}"
    fi

    ln -s "${src}" "${target}"
    echo "linked: ${target} -> ${src}"
}

# =============================================================================
#  init vim
# =============================================================================

function install_vundle()
{
    vundle_dir="${HOME}/.vim/bundle/Vundle.vim"
    if [ -e "${vundle_dir}" ]; then
        echo "vundle already exists: ${vundle_dir}"
        return 0
    fi
    echo "==> installing vundle..."
    git clone https://github.com/VundleVim/Vundle.vim.git "${vundle_dir}"
    if [ "$?" = "0" ]; then
        echo "vundle installed"
    else
        echo "error: vundle install failed"
        return 1
    fi
}

function install_vimplug()
{
    plug_file="${HOME}/.vim/autoload/plug.vim"
    if [ -e "${plug_file}" ]; then
        echo "vim-plug already exists: ${plug_file}"
        return 0
    fi
    echo "==> installing vim-plug..."
    curl -fLo "${plug_file}" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

function link_pm()
{
    pm_file="$1"
    pm_link="${repo_root}/mVimConfig/vimrcs/plugin_manager.vim"
    pm_target="${repo_root}/mVimConfig/vimrcs/${pm_file}"
    ln -sf "${pm_target}" "${pm_link}"
    echo "plugin manager: ${pm_file}"
}

function select_vim_plugin_manager()
{
    echo "select vim plugin manager:"
    echo "  1) vim-plug"
    echo "  2) vundle"
    read -p "enter choice [1-2]: " choice

    case "${choice}" in
        1) install_vimplug; link_pm "pm_vimplug.vim"; vim_plugin_manager="vimplug" ;;
        2) install_vundle; link_pm "pm_vundle.vim"; vim_plugin_manager="vundle" ;;
        *) echo "invalid choice"; return 1 ;;
    esac
}

function install_system_tools()
{
    echo "==> checking system tools (ctags, cscope, global)"
    missing=0

    for tool in ctags cscope global; do
        if command -v "${tool}" &>/dev/null; then
            echo "  ${tool}: $(command -v ${tool})"
        else
            missing=1
            echo "  ${tool}: not found"
        fi
    done

    if [ "${missing}" = "1" ]; then
        echo "  some tools missing, install with:"
        echo "    sudo apt-get install universal-ctags cscope global"
    fi
}

function install_vim_plugins()
{
    if [ -z "${vim_plugin_manager}" ]; then
        return 0
    fi

    echo "==> installing vim plugins via ${vim_plugin_manager}..."
    if ! command -v vim &>/dev/null; then
        echo "  vim not found, skip plugin install"
        return 0
    fi

    local install_cmd=""
    case "${vim_plugin_manager}" in
        vundle)   install_cmd="+PluginInstall" ;;
        vimplug)  install_cmd="+PlugInstall" ;;
    esac

    vim "${install_cmd}" +qall
    if [ "$?" = "0" ]; then
        echo "  plugins installed"
    else
        echo "  warning: some plugins may have failed, check above output"
    fi
}

function post_install_ycm()
{
    local ycm_dir=""
    case "${vim_plugin_manager}" in
        vundle)  ycm_dir="${HOME}/.vim/bundle/YouCompleteMe" ;;
        vimplug) ycm_dir="${HOME}/.vim/plugged/YouCompleteMe" ;;
    esac
    [ ! -d "${ycm_dir}" ] && return 0

    # 补全 YCM 的 git 历史（管理器默认浅克隆只保留一个 commit）
    if git -C "${ycm_dir}" rev-parse --is-shallow-repository 2>/dev/null | grep -q true; then
        echo "==> unshallow YouCompleteMe for full git history..."
        git -C "${ycm_dir}" fetch --unshallow
    fi

    echo "==> note: if using YouCompleteMe, run:"
    echo "   cd ${ycm_dir} && python install.py --all && cd -"

    # 检查 Vim 版本是否满足 YCM 要求
    local vim_ver=$(vim --version 2>/dev/null | head -1 | grep -oP '\d+\.\d+' | head -1)
    if [ -n "${vim_ver}" ]; then
        local major=$(echo "${vim_ver}" | cut -d. -f1)
        local minor=$(echo "${vim_ver}" | cut -d. -f2)
        if [ "${major}" -lt 9 ] || { [ "${major}" -eq 9 ] && [ "${minor}" -lt 1 ]; }; then
            echo "  warning: Vim ${vim_ver} < 9.1, YCM may not work"
            echo "  YCM requires Vim >= 9.1.0016, upgrade Vim or use an older YCM release"
        fi
    fi
}

function link_tools()
{
    echo "==> linking tools to ~/bin"
    mkdir -p "${HOME}/bin"
    create_link "${repo_root}/gen_symbols.sh" "${HOME}/bin/gen_symbols"
}

function init_vim()
{
    echo "==> init vim config"
    create_link "${repo_root}/mVimConfig/vimrc" "${HOME}/.vimrc"
    create_link "${repo_root}/mVimConfig" "${HOME}/.vim"
    select_vim_plugin_manager
    install_system_tools
    install_vim_plugins
    post_install_ycm
    link_tools
}

# =============================================================================
#  init nvim
# =============================================================================

function install_nvim_plugins()
{
    if ! command -v nvim &>/dev/null; then
        echo "  nvim not found, skip plugin install"
        return 0
    fi

    echo "==> installing nvim plugins via lazy.nvim..."
    nvim --headless "+Lazy! sync" +qall
    if [ "$?" = "0" ]; then
        echo "  plugins installed"
    else
        echo "  warning: some plugins may have failed, check above output"
        echo "  you can also open nvim and run :Lazy to check"
    fi
}

function init_nvim()
{
    echo "==> init nvim config"
    [ ! -e "${HOME}/.config" ] && mkdir -p "${HOME}/.config"
    ln -sfn "${repo_root}/mNvimConfig" "${HOME}/.config/nvim"
    echo "linked: ${HOME}/.config/nvim -> ${repo_root}/mNvimConfig"

    # clean up old plugin manager artifacts to avoid conflict with lazy.nvim
    local nvim_data="${HOME}/.local/share/nvim"
    local old_dirs=(
        "${nvim_data}/site/pack"           # vim native package dir (packer, vundle, etc.)
    )
    local old_files=(
        "${nvim_data}/site/lua/packer_compiled.lua"  # packer compiled cache
    )
    for d in "${old_dirs[@]}"; do
        if [ -d "${d}" ]; then
            echo "==> removing old dir: ${d}"
            rm -rf "${d}"
        fi
    done
    for f in "${old_files[@]}"; do
        if [ -f "${f}" ]; then
            echo "==> removing old file: ${f}"
            rm -f "${f}"
        fi
    done

    install_nvim_plugins
    echo
    echo "==> done. open nvim to start using."
}

# =============================================================================
#  main
# =============================================================================

function main()
{
    get_repo_root

    echo "select editor config to deploy:"
    echo "  1) vim"
    echo "  2) nvim"
    echo "  3) both"
    read -p "enter choice [1-3]: " choice

    case "${choice}" in
        1) init_vim ;;
        2) init_nvim ;;
        3) init_vim; init_nvim ;;
        *) echo "invalid choice: ${choice}"; return 1 ;;
    esac

    echo "==> done"
}

main
