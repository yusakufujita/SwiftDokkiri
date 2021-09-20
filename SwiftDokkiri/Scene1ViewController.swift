//
//  Scene1ViewController.swift
//  SwiftDokkiri
//
//  Created by 藤田優作 on 2020/04/16.
//  Copyright © 2020 藤田優作. All rights reserved.
//

import UIKit
import Accounts


class Scene1ViewController: UIViewController {

    var shareImage:UIImage?
    
    @IBAction func shareAction(_ sender: Any) {
       let text = "私は、ビビリ度1でした"
        let image: UIImage =  UIImage(named: "AppIcon")!
        let shareUrl =  "https://apps.apple.com/jp/app/びっくりアプリ/id1508282901?fbclid=IwAR0R2C5g2LaGwthNTW8qj-1XEG7Yy6Va3sFXdH_zBqSnqnHqF7bFgsA3V0s"
        let shareItems = [text,image,shareUrl] as [Any]
        let controller = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        controller.popoverPresentationController?.sourceView = self.view
        controller.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.size.width / 2.0, y: self.view.bounds.size.height / 2.0 , width: 500 , height: 500);

        present(controller, animated: true, completion: nil)
         }


    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

}
