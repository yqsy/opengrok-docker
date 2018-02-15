<!-- TOC -->

- [1. 说明](#1-说明)

<!-- /TOC -->


<a id="markdown-1-说明" name="1-说明"></a>
# 1. 说明


持久文件
```bash
# 源码
/src

# 索引
/data
```

如何启动
```bash
git clone https://github.com/yqsy/opengrok-docker.git
cd opengrok-docker
docker build --build-arg http_proxy=http://host1:1080 \
    --build-arg https_proxy=http://host1:1080 \
    -t="yqsy021/opengrok:latest" .

mkdir -p ~/env/opengrok && cd ~/env/opengrok
mkdir -p src data

docker run -d --name opengrok \
    -p 8080:8080 \
    -e JAVA_OPTS="-Xms512m -Xmx512m" \
    -v `pwd`/src:/var/opengrok/src:rw \
    -v `pwd`/data:/var/opengrok/data:rw \
    yqsy021/opengrok

# 第一次启动时必须执行
# 重建索引时执行
docker exec opengrok OpenGrok index

```
