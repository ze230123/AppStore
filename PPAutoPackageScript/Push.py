#!/usr/bin/python
#coding=utf-8

import sys
import json
import properties
from aliyunsdkpush.request.v20160801 import PushRequest
from aliyunsdkcore import client
from datetime import *
import time

# title = "fjafdjakl"
# body = "hahahahahah"

def push(title, body):
	clt = client.AcsClient(properties.accessKeyId,properties.accessKeySecret,properties.regionId)

	request = PushRequest.PushRequest()
	request.set_AppKey(properties.appKey)
	#推送目标: DEVICE:按设备推送 ALIAS : 按别名推送 ACCOUNT:按帐号推送  TAG:按标签推送; ALL: 广播推送
	request.set_Target('ALIAS')
	#根据Target来设定，如Target=DEVICE, 则对应的值为 设备id1,设备id2. 多个值使用逗号分隔.(帐号与设备有一次最多100个的限制)
	request.set_TargetValue('test')
	#设备类型 ANDROID iOS ALL
	request.set_DeviceType("iOS")
	#消息类型 MESSAGE NOTICE
	request.set_PushType("NOTICE")
	#消息的标题
	request.set_Title(title)
	#消息的内容
	request.set_Body(body)

	# iOS配置

	#iOS应用图标右上角角标
	request.set_iOSBadge(1)
	#开启静默通知
	request.set_iOSSilentNotification(False)
	#iOS通知声音
	request.set_iOSMusic("default")
	#iOS的通知是通过APNs中心来发送的，需要填写对应的环境信息。"DEV" : 表示开发环境 "PRODUCT" : 表示生产环境
	request.set_iOSApnsEnv("DEV")
	# 消息推送时设备不在线（既与移动推送的服务端的长连接通道不通），则这条推送会做为通知，通过苹果的APNs通道送达一次。注意：离线消息转通知仅适用于生产环境
	request.set_iOSRemind(True)
	#iOS消息转通知时使用的iOS通知内容，仅当iOSApnsEnv=PRODUCT && iOSRemind为true时有效
	request.set_iOSRemindBody("iOSRemindBody");
	#自定义的kv结构,开发者扩展用 针对iOS设备
	request.set_iOSExtParameters("{\"k1\":\"ios\",\"k2\":\"v2\"}")

	#推送控制
	#30秒之后发送, 也可以设置成你指定固定时间
	pushDate = datetime.utcnow() #+ timedelta(seconds = +30)
	#24小时后消息失效, 不会再发送
	expireDate = datetime.utcnow() + timedelta(hours = +24)
	#转换成ISO8601T数据格式
	pushTime = pushDate.strftime("%Y-%m-%dT%XZ")
	expireTime = expireDate.strftime("%Y-%m-%dT%XZ")
	request.set_PushTime(pushTime)
	request.set_ExpireTime(expireTime)
	#设置过期时间，单位是小时
	# request.set_TimeOut(24)
	request.set_StoreOffline(True)
	print request
	result = clt.do_action_with_exception(request)
	print result
	json2python = json.loads(result)
	print type(json2python)
	success = len(json2python) > 0
	print type(success)
	return success
	# def send_push(title, body):
	# 	pass

if push(sys.argv[1], sys.argv[2]):
	print "已推送通知"
else:
	print "推送通知失败"

