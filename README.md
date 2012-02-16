# DNSPod 宕机监控URL回调 ASP服务端 示例

## 它的作用

    通过DNSPod提供的宕机监控URL回调，您可以将DNSPod的监控轻松地整合到您的项目中。

## 环境要求

    这是基于asp(vbscript)的一个实现，环境要求为：

    $ asp(vbscript)的web环境，Scripting.FileSystemObject支持

## 如何安装

    直接放到网站的任何目录，然后在DNSPod添加监控的时候设置相应的地址。
    
    打开 index.asp 修改其中的 callback_key 让它跟您在DNSPod添加监控时设置的回调密钥一致。

## 技术支持

    http://discussdns.com/forum-45-1.html
    
