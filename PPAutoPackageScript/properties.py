#!/usr/bin/python
#coding=utf-8

accessKeyId = 'LTAI8AXwLmRWOuMy'
accessKeySecret = 'y86bsU4zcmkt1WGEEsp7MvgURJhgv3'

appKey = '24599210'


# 发送的deviceId, 列表用逗号分隔 比如:  111 或是  111,222
deviceIds ='_YOUR_DEVICEID_LIST_HERE_'
deviceId = '_YOUR_DEVICEID_'

# 发送的account, 列表用逗号分隔 比如:  account1 或是  account1,account2
accounts = '_YOUR_ACCOUNT_LIST_HERE_'
account = '_YOUR_ACCOUNT_'

# 发送的alias, 列表用逗号分隔 比如:  alias1,alias2
aliases = '_YOUR_ALIAS_LIST_HERE_'
alias = '_YOUR_ALIAS_'

# 发送的tag, tag表达式参考文档:https://help.aliyun.com/document_detail/48055.html?
tag = 'tag1'
tagExpression = '{"and": [ {"tag": "男性" },{"tag": "90后"},{"not": {"tag": "IT"} } ] }'


regionId='cn-hangzhou'
