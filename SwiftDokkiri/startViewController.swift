//
//  startViewController.swift
//  SwiftDokkiri
//
//  Created by 藤田優作 on 2020/04/14.
//  Copyright © 2020 藤田優作. All rights reserved.
//

import UIKit
import AppTrackingTransparency
import AdSupport

class StartViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("Google Mobile Ads SDK version: \(GADRequest.sdkVersion())")
        AppManager.addAdmob(viewController: self)
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.step), userInfo: nil, repeats: true)
        // スタートボタンのアクションを設定
        startButton.addTarget(self, action: #selector(startButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func startButtonTapped(_ sender: UIButton) {
        // MainMenu画面に遷移
        pushViewControllerOverNavigation("MainMenu") { (vc: MainMenuViewController) in
            // 依存注入
            vc.hapticManager = self.appDelegate.hapticManager
        }
    }
    
    @objc func step() {
        imageView.center.x += 10
        let imageWidth = imageView.bounds.width
        if imageView.center.x>(view.bounds.width + imageWidth/2){
            imageView.center.x = -imageWidth
            let viewH = view.bounds.height
            imageView.center.y = CGFloat(arc4random_uniform(UInt32(viewH)))
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //ATT対応
        if #available(iOS 14, *) {
            switch ATTrackingManager.trackingAuthorizationStatus {
            case .authorized:
                print("Allow Tracking")
                print("IDFA: \(ASIdentifierManager.shared().advertisingIdentifier)")
            case .denied:
                print("拒否")
            case .restricted:
                print("制限")
            case .notDetermined:
                showRequestTrackingAuthorizationAlert()
            @unknown default:
                fatalError()
            }
        } else {// iOS14未満
            if ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
                print("Allow Tracking")
                print("IDFA: \(ASIdentifierManager.shared().advertisingIdentifier)")
            } else {
                print("制限")
            }
        }
    }
    
    
    private func showRequestTrackingAuthorizationAlert() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
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
