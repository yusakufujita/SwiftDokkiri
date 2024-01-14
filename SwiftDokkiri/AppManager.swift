//
//  AppManager.swift
//  SwiftDokkiri
//
//  Created by 藤田優作 on 2022/08/28.
//  Copyright © 2022 藤田優作. All rights reserved.
//

import Foundation
import UIKit
import GoogleMobileAds

struct AppManager {
    static func addAdmob(viewController: UIViewController) {
        // 広告ユニットID
        let AdMobID = "ca-app-pub-5863451431578196/6283721919"
//        ca-app-pub-5863451431578196/6283721919
//        ca-app-pub-5863451431578196/7774549949"
        // テスト用広告ユニットID
        let TEST_ID = "ca-app-pub-3940256099942544/2934735716"
        var admobView = GADBannerView()
        // true:テスト
        let AdMobTest: Bool = false
        admobView = GADBannerView(adSize:kGADAdSizeBanner)

        admobView.frame.origin = CGPoint(x:0, y: viewController.view.frame.size.height - admobView.frame.height - 34)
        admobView.frame.size = CGSize(width: viewController.view.frame.width, height:admobView.frame.height)

        if AdMobTest {
            admobView.adUnitID = TEST_ID
        } else {
            admobView.adUnitID = AdMobID
        }

        admobView.rootViewController = viewController
        admobView.load(GADRequest())

        viewController.view.addSubview(admobView)
    }
}
