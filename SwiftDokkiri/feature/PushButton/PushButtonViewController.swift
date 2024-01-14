//
//  ViewController2.swift
//  SwiftDokkiri
//
//  Created by 藤田優作 on 2020/09/23.
//  Copyright © 2020 藤田優作. All rights reserved.
//

import UIKit

class PushButtonViewController: UIViewController {
        
    @IBOutlet weak var heartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppManager.addAdmob(viewController: self)
        self.navigationItem.hidesBackButton = true
        heartButton.layer.shadowOpacity = 0.7
        heartButton.layer.shadowRadius = 3
        heartButton.layer.shadowColor = UIColor.black.cgColor
        heartButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        navigationItem.backButtonTitle = "戻る"
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(onTapBackButton(_:)))
    }
    
//    @objc func onTapBackButton(_ sender: UIBarButtonItem) {
//        self.navigationController?.popViewController(animated: true)
//    }
}
