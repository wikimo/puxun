# 普迅短信接口

因信息管理原因，利用[普迅自身短信后台](http://duanxin.pushing.com.cn/)进行短信发送

## 依赖环境
需要leptonica，tesseract支持，主要为了做登录验证码识别。安装完毕后，请先在命令行下测试tesseract可用性，然后再测下rtesseract可用性，如果无法识别，请设置clear_console_output，查看错误输出信息。[可参看](https://github.com/dannnylo/rtesseract/issues/13)

## 安装

在 Gemfile 中加入:

    gem 'puxun'

然后执行:

    $ bundle

或通过以下方式安装:

    $ gem install puxun

## 使用方法

见测试文件test.rb


