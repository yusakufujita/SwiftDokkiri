//
//  AppDelegate.swift
//  SwiftDokkiri
//
//  Created by 藤田優作 on 2019/03/18.
//  Copyright © 2019 藤田優作. All rights reserved.
//

import UIKit
import Firebase
import GoogleMobileAds
import AppTrackingTransparency
import AdSupport

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // MARK: - Dependency Injection
    /// 依存関係を管理するプロパティ
    lazy var settingsRepository: SettingsRepositoryProtocol = {
        return SettingsRepository()
    }()
    
    lazy var resultRepository: ResultRepositoryProtocol = {
        return ResultRepository()
    }()
    
    lazy var audioManager: AudioManager = {
        return AudioManager(settingsRepository: settingsRepository)
    }()
    
    lazy var hapticManager: HapticManager = {
        return HapticManager(settingsRepository: settingsRepository)
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // ここで許可リクエストを行う
        requestAppTrackingTransparencyAuthorization()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    private func requestAppTrackingTransparencyAuthorization() {
        if #available(iOS 14.5, *) {
            // .notDeterminedの場合にだけリクエスト呼び出しを行う
            guard ATTrackingManager.trackingAuthorizationStatus == .notDetermined else { return }
            
            // タイミングを遅らせる為に処理を遅延させる
            DispatchQueue.main.async {
                ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                    // リクエスト後の状態に応じた処理を行う
                    switch status {
                    case .authorized:
                        print("🎉")
                        //IDFA取得
                        print("IDFA: \(ASIdentifierManager.shared().advertisingIdentifier)")
                    case .denied, .restricted, .notDetermined:
                        print("😥")
                    @unknown default:
                        fatalError()
                    }
                })
            }
        }
    }
}

