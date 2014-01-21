# coding: utf-8
require File.join(File.dirname(__FILE__), 'lib', 'puxun')

px =  Puxun::Sms.new

sms_hash = {
	:username => 'xxx',
	:passwd => 'xxx',
	:msg => '亲爱的会员，今天你喝水了没有，记得及时补充水分【金币减重】',
	:phone_num => "15012345678\r\n13212345678"
}

result = px.send sms_hash

p result