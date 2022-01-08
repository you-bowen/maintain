# docker images
> 主要是构建一些平时用的到的基础镜像，官方的镜像太基础了，另外需要进行换源，所以有了这个文件夹
> 目前主要用到两个平台，以后应该会扩

## 镜像命名格式
build之后打上标签🏷️
格式：`utils/ubuntu:[arch]`

```shell
dkbt utils/ubuntu:arm64 arm64/ubuntu2004
dkbt utils/ubuntu:amd64 amd64/ubuntu2004
```