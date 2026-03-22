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
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppManager.addAdmob(viewController: self)
        self.navigationItem.hidesBackButton = true
        heartButton.layer.shadowOpacity = 0.7
        heartButton.layer.shadowRadius = 3
        heartButton.layer.shadowColor = UIColor.black.cgColor
        heartButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        navigationItem.backButtonTitle = "戻る"
        
        // 背景画像を読み込む
        loadBackgroundImage()
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(onTapBackButton(_:)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 画面が表示されるたびに背景画像を更新（設定が変更された可能性があるため）
        loadBackgroundImage()
    }
    
    private func loadBackgroundImage() {
        let settingsRepository = appDelegate.settingsRepository
        
        // カスタム画像が設定されている場合はそれを優先
        if let customImagePath = settingsRepository.pushButtonCustomBackgroundImagePath,
           let customImage = settingsRepository.loadCustomBackgroundImage(path: customImagePath) {
            backgroundImageView?.image = customImage
        } else {
            // デフォルト画像を使用
            backgroundImageView?.image = UIImage(named: "cat-4644008_1920")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // JudgementViewControllerへの遷移時に依存注入
        if let judgementVC = segue.destination as? JudgementViewController {
            judgementVC.audioManager = appDelegate.audioManager
            judgementVC.hapticManager = appDelegate.hapticManager
        }
    }
    
//    @objc func onTapBackButton(_ sender: UIBarButtonItem) {
//        self.navigationController?.popViewController(animated: true)
//    }
}
