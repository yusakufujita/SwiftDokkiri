//
//  ResultViewController.swift
//  SwiftDokkiri
//
//  Created by 藤田優作 on 2023/12/08.
//  Copyright © 2023 藤田優作. All rights reserved.
//

import UIKit
import CoreMotion

class ResultViewController: UIViewController {
    
    @IBOutlet var backImageView: UIImageView!
    @IBOutlet var levelLabel: UILabel!
    @IBOutlet var shareButton: UIButton!
    @IBOutlet var bibiriLabel: UILabel!
    @IBOutlet var yarukiLabel: UILabel!
    @IBOutlet var shareLabel: UILabel!
    
    let motionManager = CMMotionManager()
    var result: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        shareButton.titleLabel?.adjustsFontSizeToFitWidth = true
        shareButton.titleLabel?.minimumScaleFactor = 0.8
        
        bibiriLabel.adjustsFontSizeToFitWidth = true
        bibiriLabel.minimumScaleFactor = 0.8
        
        yarukiLabel.adjustsFontSizeToFitWidth = true
        yarukiLabel.minimumScaleFactor = 0.8
        
        shareLabel.adjustsFontSizeToFitWidth = true
        shareLabel.minimumScaleFactor = 0.8
        
        if result < 1 {
            levelLabel.text = "1"
            backImageView.image = UIImage(named: "egypt-21157_1920")
        } else if result < 4 {
            levelLabel.text = "2"
            backImageView.image = UIImage(named: "calling-1299741_1280")
        } else {
            levelLabel.text = "3"
            backImageView.image = UIImage(named: "munch-scream-247514_1920")
        }
    }
    
    @IBAction func shareButtonAction(_ sender: Any) {
        var text: String = ""
        if result < 1 {
            text = "私は、ビビリ度1でした"
        } else if result < 4 {
            text = "私は、ビビリ度2でした"
        } else {
            text = "私は、ビビリ度3でした"
        }
        let image: UIImage =  UIImage(named: "S__54313005")!
        let shareUrl =  "https://apps.apple.com/jp/app/びっくりアプリ/id1508282901?fbclid=IwAR0R2C5g2LaGwthNTW8qj-1XEG7Yy6Va3sFXdH_zBqSnqnHqF7bFgsA3V0s"
        let shareItems = [text,image,shareUrl] as [Any]
        let controller = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        controller.popoverPresentationController?.sourceView = self.view
        controller.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.size.width / 2.0, y: self.view.bounds.size.height / 2.0 , width: 500 , height: 500);
        
        present(controller, animated: true, completion: nil)
    }
}
