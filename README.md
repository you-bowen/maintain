# maintain -- repo maintained frequently

## target

1. 打造和我工作相关的装机脚本
2. 写一些好用的小工具
3. 打造优秀的.zshrc
4. 打造换源脚本

## 各项目标的进展

### 装机脚本

目前是专注于**ubuntu**的装机，能够满足一下几个功能

1. zsh安装
2. base install
3. git -- 一键初始化和添加密钥
4. ctf (pwn re ...)
5. docker -- tobe added

### 小工具

`asm` 汇编知识查询器
`clone` 更加方便的clone工具
`translate` 命令行google翻译工具
`vscode` vscode用户片段编辑工具
`copy` 跨平台剪贴板复制

### .zshrc

1. 针对不同平台进行优化，非常适合跨平台用户
2. 常见的命令简写
3. 好用的插件

- **存在的问题以及解决方案**

  粘贴的时候非常的慢

  vim ~/.oh-my-zsh/lib/misc.zsh 并加入`DISABLE_MAGIC_FUNCTIONS=true`
