# coding: utf-8
require File.join(File.dirname(__FILE__), 'lib', 'puxun')

px =  Puxun::Sms.new

sms_hash = {
	:username => 'xxx', #在pushing上的用户名
	:passwd => 'xxx',#在pushing上的密码
	:msg => '亲爱的会员，今天你喝水了没有，记得及时补充水分【金币减重】', #短信内容
	:phone_num => "15012345678\r\n13212345678" #需要推送的号码列表‘\r\n’分割
}

result = px.send sms_hash

p result