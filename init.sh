#!/usr/bin/env bash
#########################################################################
# File Name: init.sh
# Author: Hongjin Li
# mail: 872648180@qq.com
# Created Time: Wed 22 Apr 2026 03:35:30 PM CST
#########################################################################

repo_root=""

function get_repo_root()
{
    init_tool_dir=$(dirname $(readlink -f "$0"))
    repo_root=$(git -C ${init_tool_dir} rev-parse --show-toplevel)
    echo "git repo root: ${repo_root}"
}

get_repo_root
