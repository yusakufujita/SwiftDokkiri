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
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    
    let motionManager = CMMotionManager()
    var result: Double = 0.0
    var resultRepository: ResultRepositoryProtocol?
    var hapticManager: HapticManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 依存注入（まだ注入されていない場合のみ）
        if resultRepository == nil {
            resultRepository = appDelegate.resultRepository
        }
        if hapticManager == nil {
            hapticManager = appDelegate.hapticManager
        }
        self.navigationItem.hidesBackButton = true
        shareButton.titleLabel?.adjustsFontSizeToFitWidth = true
        shareButton.titleLabel?.minimumScaleFactor = 0.8
        
        bibiriLabel.adjustsFontSizeToFitWidth = true
        bibiriLabel.minimumScaleFactor = 0.8
        
        yarukiLabel.adjustsFontSizeToFitWidth = true
        yarukiLabel.minimumScaleFactor = 0.8
        
        shareLabel.adjustsFontSizeToFitWidth = true
        shareLabel.minimumScaleFactor = 0.8
        
        // レベル判定
        let level: Int
        if result < 1 {
            level = 1
            levelLabel.text = "1"
            backImageView.image = UIImage(named: "egypt-21157_1920")
        } else if result < 4 {
            level = 2
            levelLabel.text = "2"
            backImageView.image = UIImage(named: "calling-1299741_1280")
        } else {
            level = 3
            levelLabel.text = "3"
            backImageView.image = UIImage(named: "munch-scream-247514_1920")
        }
        
        // 結果を履歴に保存
        saveResult(level: level, score: result)
    }
    
    /// ゲーム結果を履歴に保存する
    /// - Parameters:
    ///   - level: 判定されたレベル（1, 2, 3）
    ///   - score: スコア（result値）
    private func saveResult(level: Int, score: Double) {
        guard let resultRepository = resultRepository else {
            // 依存注入されていない場合は保存しない（エラーにはしない）
            print("ResultRepositoryが設定されていません。履歴は保存されません。")
            return
        }
        
        let record = ResultRecord(level: level, score: score)
        
        do {
            try resultRepository.save(record: record)
            print("ゲーム結果を保存しました: Level \(level), Score \(score)")
        } catch {
            print("ゲーム結果の保存に失敗しました: \(error.localizedDescription)")
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
    
    @IBAction func topButtonTapped(_ sender: UIButton) {
        hapticManager?.selection()
        
        guard let navController = self.navigationController else { return }
        
        // デバッグ: 現在のナビゲーションスタックの状態を確認
        print("ResultViewController - topButtonTapped - Current Stack Count: \(navController.viewControllers.count)")
        for (index, vc) in navController.viewControllers.enumerated() {
            print("  [\(index)]: \(type(of: vc))")
        }
        
        // MainMenuViewControllerを取得
        let storyboard = UIStoryboard(name: "MainMenu", bundle: nil)
        guard let mainMenuVC = storyboard.instantiateInitialViewController() as? MainMenuViewController else {
            print("ResultViewController - Failed to instantiate MainMenuViewController")
            return
        }
        
        // 依存注入
        mainMenuVC.hapticManager = self.appDelegate.hapticManager
        
        // ナビゲーションスタックを正しく構築するため、一度ルートに戻る
        navController.popToRootViewController(animated: false)
        
        // 少し遅延させてからMainMenuViewControllerにpush
        // これにより、ナビゲーションスタックが正しく構築される
        DispatchQueue.main.async {
            print("ResultViewController - Pushing MainMenuViewController")
            navController.pushViewController(mainMenuVC, animated: true)
        }
    }
    
    @IBAction func playAgainButtonTapped(_ sender: UIButton) {
        hapticManager?.selection()
        
        // PushButton画面に遷移
        pushViewControllerOverNavigation("PushButton") { (vc: PushButtonViewController) in
            // PushButtonViewControllerには特別な依存注入は不要
        }
    }
}
