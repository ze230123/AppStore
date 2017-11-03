#!/usr/bin/env python
# -*- coding: utf-8 -*-

import smtplib,sys
from email.mime.text import MIMEText

mail_host = 'smtp.qq.com'
mail_user = '4674069'
mail_pass = 'pujhembozxbycbbg'

sender = '4674069@qq.com'
receivers = ['15545583589@163.com;','517493061@qq.com;', '85231152@qq.com;','83449688@qq.com','ljn@hh-game.com']

def send_mail(title, content):
	try:
		message = MIMEText(content,'plain','utf-8')

		message['subject'] = title
		message['Form'] = sender
		message['To'] = ";".join(receivers)

		smtpObj = smtplib.SMTP_SSL(mail_host, 465)
		smtpObj.connect(mail_host,465)
		smtpObj.login(mail_user,mail_pass)
		smtpObj.sendmail(sender,receivers,message.as_string())
		smtpObj.quit()
		print('success')
		return True	
	except Exception, e:
		print str(e)
		return False

if send_mail(sys.argv[1], sys.argv[2]):
	print "已发送邮件给测试人员-- 😁 😁 😁 😁 😁 😁 😁 😁 😁 😁"
else:
	print "发送邮件失败-- 😂 😂 😂 😂 😂 😂 😂 😂 😂 😂"
