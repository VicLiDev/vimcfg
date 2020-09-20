#########################################################################
# File Name: ../genCs.sh
# Author: LiHongjin
# mail: 872648180@qq.com
# Created Time: Mon 14 Sep 2020 11:06:47 PM CST
#########################################################################
#!/bin/bash

#使用方法：
#    1.将该文件放在项目目录的上一级
#    2.编辑该文件中的文件搜索一行(find ...)，选择需要加入cs库的文件,有需要可以多复制几次
#    3.在项目跟目录下执行： sh ../genCs.sh
#    4.进入vi，添加cs库: cscope add ./cscope.out

#筛选需要加入库中的文件
find $PWD/* | grep "\.[ch]$" >> cscope.file

#生成库文件
time cscope -Rbkq -i ./cscope.file
time ctags -R ./*

#删除文件列表
rm cscope.file
