//
//  ViewController.swift
//  SwiftDokkiri
//
//  Created by 藤田優作 on 2019/03/18.
//  Copyright © 2019 藤田優作. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    
//    // 広告ユニットID
//    let AdMobID = "[Your AdMob ID]"
//    // テスト用広告ユニットID
//    let TEST_ID = "ca-app-pub-3940256099942544/2934735716"

    // true:テスト
//    let AdMobTest:Bool = true

    var a:Int = 0
    var inputText:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        
//        print("Google Mobile Ads SDK version: \(GADRequest.sdkVersion())")
//
//        var admobView = GADBannerView()
//
//        admobView = GADBannerView(adSize:kGADAdSizeBanner)
        // iPhone X のポートレート決め打ちです
//        admobView.frame.origin = CGPoint(x:0, y:self.view.frame.size.height - admobView.frame.height - 34)
//        admobView.frame.size = CGSize(width:self.view.frame.width, height:admobView.frame.height)
//
//        if AdMobTest {
//            admobView.adUnitID = TEST_ID
//        }
//        else{
//            admobView.adUnitID = AdMobID
//        }

//        admobView.rootViewController = self
//        admobView.load(GADRequest())

//        self.view.addSubview(admobView)

    }

    @IBAction func button(_ sender: Any) {
                }
           }
class ExpansionButton: UIButton {
    var insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
           var rect = bounds
           rect.origin.x -= insets.left
           rect.origin.y -= insets.top
           rect.size.width += insets.left + insets.right
           rect.size.height += insets.top + insets.bottom

           // 拡大したViewサイズがタップ領域に含まれているかどうかを返します
        return rect.contains(point)
       }
}
   
    
    


