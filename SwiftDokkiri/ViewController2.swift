//
//  ViewController2.swift
//  SwiftDokkiri
//
//  Created by 藤田優作 on 2020/09/23.
//  Copyright © 2020 藤田優作. All rights reserved.
//

import UIKit
import GoogleMobileAds


class ViewController2: UIViewController {
    
    //広告ユニットID
    let AdMobID = "[Your AdMob ID]"
    //テスト用広告ユニットID
    let TEST_ID = "ca-app-pub-3940256099942544/2934735716"

    //true:テスト
    let AdModTest:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Google Mobile Ads SDK version: \(GADRequest.sdkVersion())")

              var admobView = GADBannerView()

              admobView = GADBannerView(adSize:kGADAdSizeBanner)
              // iPhone X のポートレート決め打ちです
              admobView.frame.origin = CGPoint(x:0, y:self.view.frame.size.height - admobView.frame.height - 30)
              admobView.frame.size = CGSize(width:self.view.frame.width, height:admobView.frame.height)

              if AdModTest {
                  admobView.adUnitID = TEST_ID
              }
              else{
                  admobView.adUnitID = AdMobID
              }

              admobView.rootViewController = self
              admobView.load(GADRequest())

              self.view.addSubview(admobView)
          }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


