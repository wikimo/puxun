# coding: utf-8
require 'Puxun'

px =  Puxun::Sms.new
# p px
sms_hash = {
	:username => '5311',
	:passwd => 'g82720905',
	:msg => '亲爱的会员请注意每日金币值，别超标哦【金币健康管理】',
	:phone_num => "18157305082\r\n15857367715"
}
result = px.send sms_hash