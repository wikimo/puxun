# coding: utf-8
require "puxun/version"

require 'faraday'
require 'rtesseract'  
require 'nokogiri'

module Puxun
  class Sms
  	def initialize
  		@conn = Faraday.new(:url => 'http://duanxin.pushing.com.cn') do |faraday|
			  faraday.request  :url_encoded
			  # faraday.response :logger  
			  faraday.adapter  Faraday.default_adapter
			  # faraday.use :cookie_jar
			end

			#获取并设置cookie
			response = @conn.get '/login.jsp'
			cookie =  response['set-cookie'].split('; ')[0]
			@conn.headers['Cookie'] =  cookie
			@conn.headers[:user_agent] = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:26.0) Gecko/20100101 Firefox/26.0'
  	end

  	#发送短信
  	def send(sms_hash)
  		return 'sms_hash_nil' if sms_hash.nil?

      response = @conn.post '/servlet/Login?method=login', { :username => sms_hash[:username],:passwd => sms_hash[:passwd],:rand => get_captcha } 
      response = @conn.get '/servlet/SmsManage?method=sms_write'
      doc = Nokogiri::HTML(response.body)

      # app.rb:32:in `<main>': undefined method `[]' for nil:NilClass (NoMethodError)

      if doc.css('#realNum').first.nil?
      	return  'real_num_nil'
      else
      	smsNum = doc.css('#realNum').first['value']
      end

      msg = sms_hash[:msg].encode('gbk')
      phoneNum = sms_hash[:phone_num]

			msg_info = {
				:IDSMSUser => 999999,
				:PhoneNum => phoneNum,
				:Msg => msg,
				:Submit => '下一步'.encode('gbk'),
				:chrLen => msg.length,
				:chrPhoneLen=>phoneNum.split('\r\n').length,
				:method => 'confirm',
				:realNum => smsNum,
				:smsLen => 1,
				:timetype => 0}

      response = @conn.post '/servlet/SmsManage?method=confirm', msg_info
      doc = Nokogiri::HTML(response.body)
      confirm_txt = doc.css('.right_TitleC0').text #确认发送
      # p confirm_txt
      sendCountNum = doc.css('#sendCountNum').first['value']

			confirm_data = {
						:sendCountNum =>sendCountNum,
						:timetype => 0,
						:Msg => msg,
						:submit => '确认发送'.encode('gbk')
					}

			response = @conn.post '/servlet/SmsManage?method=finish', confirm_data

			return true
  	end

  	private
	  	#识别验证码
	  	def get_captcha
	      response = @conn.get '/authImg' 
	      open("captcha.jpg" ,"wb") { |file|file.write(response.body)}

	      str = RTesseract.new("captcha.jpg").to_s
	      File.unlink("captcha.jpg")
	      captcha = str.strip.sub(/\n/,'').to_s if !str.nil?
	  	end


  end	
end
