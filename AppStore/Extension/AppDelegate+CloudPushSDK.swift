//
//  AppDelegate+CloudPushSDK.swift
//  wanlezu
//
//  Created by 泽i on 2017/8/21.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//
import UserNotifications

let testAppKey = "24599210"
let testAppSecret = "3b9931061df9d66f23ae95668acc90e3"

extension AppDelegate {

    func initNotification(_ application: UIApplication, launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        // APNs注册，获取deviceToken并上报
        registerAPNs(application)
        // 初始化阿里云推送SDK
        initCloudPushSDK()
        // 监听推送通道打开动作
        listenOnChannelOpened()
        // 监听推送消息到达
        registerMessageReceive()
        // 点击通知将App从关闭状态启动时，将通知打开回执上报
        //CloudPushSDK.handleLaunching(launchOptions)(Deprecated from v1.8.1)
        CloudPushSDK.sendNotificationAck(launchOptions)
    }

    func registerAPNs(_ application: UIApplication) {
        if #available(iOS 10, *) {
            let center = UNUserNotificationCenter.current()
            // 创建category，并注册到通知中心
            createCustomNotificationCategory()
            center.delegate = self
            // 请求推送权限
            center.requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { (granted, _) in
                if granted {
                    printLog("USER authored notification. ✅✅✅✅✅✅")
                    // 向APNs注册获取deviceToken
                    DispatchQueue.main.async {
                        application.registerForRemoteNotifications()
                    }
                } else {
                    printLog("User denied notification. ❌❌❌❌❌❌")
                }
            })
        } else if #available(iOS 8, *) {
            application.registerUserNotificationSettings(UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil))
            application.registerForRemoteNotifications()
        }
    }

    // 创建自定义category，并注册到通知中心
    @available(iOS 10, *)
    func createCustomNotificationCategory() {
        let action1 = UNNotificationAction.init(identifier: "action1", title: "test1", options: [])
        let action2 = UNNotificationAction.init(identifier: "action2", title: "test2", options: [])
        let category = UNNotificationCategory.init(identifier: "test_category", actions: [action1, action2], intentIdentifiers: [], options: UNNotificationCategoryOptions.customDismissAction)
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
    // 初始化推送SDK
    func initCloudPushSDK() {
        // 打开Log，线上建议关闭
        #if DEBUG
//        CloudPushSDK.turnOnDebug()
        #endif
        CloudPushSDK.asyncInit(testAppKey, appSecret: testAppSecret) { (res) in
            if res!.success {
                printLog("Push SDK init success, deviceId: \(CloudPushSDK.getDeviceId()!)")
                CloudPushSDK.addAlias("test", withCallback: nil)
            } else {
                printLog("Push SDK init failed, error: \(res!.error!).")
            }
        }
    }
    // 监听推送通道是否打开
    func listenOnChannelOpened() {
        let notificationName = Notification.Name("CCPDidChannelConnectedSuccess")
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(channelOpenedFunc),
                                               name: notificationName,
                                               object: nil)
    }

    @objc func channelOpenedFunc(_ notification: Notification) {
//        printLog("Push SDK channel opened.")
    }

    // 注册消息到来监听
    func registerMessageReceive() {
        let notificationName = Notification.Name("CCPDidReceiveMessageNotification")
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onMessageReceivedFunc(notification:)),
                                               name: notificationName,
                                               object: nil)
    }

    // 处理推送消息
    @objc func onMessageReceivedFunc(notification: Notification) {
        printLog("送到一个推送消息")
        guard let pushMessage = notification.object as? CCPSysMessage else {
            return
        }
        let date = Date().timeIntervalSince1970
        let title = String.init(data: pushMessage.title, encoding: String.Encoding.utf8) ?? ""
        let body = String.init(data: pushMessage.body, encoding: String.Encoding.utf8) ?? ""
//        let message = MessageModel()
//        message.title = title
//        message.body = body
//        message.date = date
//
//        let realm = try? Realm()
//        try? realm?.write {
//            realm?.add(message)
//        }

        printLog("Message title: \(title), body: \(body).", date)
    }

    // App处于启动状态时，通知打开回调（< iOS 10）
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        printLog("Receive one notification.")
        let aps = userInfo["aps"] as? [AnyHashable : Any] ?? [:]
        let alert = aps["alert"] ?? "none"
        let badge = aps["badge"] ?? 0
        let sound = aps["sound"] ?? "none"
        let extras = userInfo["Extras"]
        printLog("Notification, alert: \(alert), badge: \(badge), sound: \(sound), extras: \(String(describing: extras)).")
        application.applicationIconBadgeNumber = 0
    }
    // 处理iOS 10通知(iOS 10+)
    @available(iOS 10.0, *)
    func handleiOS10Notification(_ notification: UNNotification) {
        let content: UNNotificationContent = notification.request.content
        let userInfo = content.userInfo
        // 通知时间
        let noticeDate = notification.date
        // 标题
        let title = content.title
        // 副标题
        let subtitle = content.subtitle
        // 内容
        let body = content.body
        // 角标
        let badge = content.badge ?? 0
        // 取得通知自定义字段内容，例：获取key为"Extras"的内容
        let extras = userInfo["Extras"]
        // 通知打开回执上报
        CloudPushSDK.sendNotificationAck(userInfo)
        printLog("Notification, date: \(noticeDate), title: \(title), subtitle: \(subtitle), body: \(body), badge: \(badge), extras: \(String(describing: extras)).")
        UIApplication.shared.applicationIconBadgeNumber = 0
    }

    // APNs注册成功
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        printLog("Get deviceToken from APNs success.")
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()

        printLog("😇😇😇😇😇😇😇😇😇😇😇😇", token)
        CloudPushSDK.registerDevice(deviceToken) { (res) in
            if res!.success {
                printLog("Upload deviceToken to Push Server, deviceToken: \(CloudPushSDK.getApnsDeviceToken()!)")
            } else {
                printLog("Upload deviceToken to Push Server failed, error: \(String(describing: res?.error))")
            }
        }
    }

    // APNs注册失败
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        printLog("Get deviceToken from APNs failed, error: \(error).")
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    // App处于前台时收到通知(iOS 10+)
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        printLog("Receive a notification in foreground.")
        handleiOS10Notification(notification)
        // 通知不弹出
        completionHandler([])
        // 通知弹出，且带有声音、内容和角标
//        completionHandler([.alert, .badge, .sound])
    }

    // 触发通知动作时回调，比如点击、删除通知和点击自定义action(iOS 10+)
    @available(iOS 10, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userAction = response.actionIdentifier
        if userAction == UNNotificationDefaultActionIdentifier {
            printLog("User opened the notification.")
            // 处理iOS 10通知，并上报通知打开回执
            handleiOS10Notification(response.notification)
        }

        if userAction == UNNotificationDismissActionIdentifier {
            printLog("User dismissed the notification.")
        }

        let customAction1 = "action1"
        let customAction2 = "action2"
        if userAction == customAction1 {
            printLog("User touch custom action1.")
        }

        if userAction == customAction2 {
            printLog("User touch custom action2.")
        }
        completionHandler()
    }
}
