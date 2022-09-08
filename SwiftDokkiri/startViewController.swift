//
//  startViewController.swift
//  SwiftDokkiri
//
//  Created by 藤田優作 on 2020/04/14.
//  Copyright © 2020 藤田優作. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("Google Mobile Ads SDK version: \(GADRequest.sdkVersion())")
        AppManager.addAdmob(viewController: self)
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.step), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
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
}
