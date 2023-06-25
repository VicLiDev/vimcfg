参考代码：
GitHub: https://github.com/jdhao

建议直接在.config 中创建软连接到git仓库中
ln -s ${HOME}/Projects/vimcfg/mNvimConfig ${HOME}/.config/nvim

第一次启动需要同步一下插件:
:PackerSync
