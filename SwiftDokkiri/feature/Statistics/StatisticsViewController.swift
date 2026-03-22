//
//  StatisticsViewController.swift
//  SwiftDokkiri
//
//  Created by 藤田優作 on 2024/01/01.
//  Copyright © 2024 藤田優作. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {
    
    @IBOutlet weak var totalPlaysLabel: UILabel!
    @IBOutlet weak var averageScoreLabel: UILabel!
    @IBOutlet weak var bestScoreLabel: UILabel!
    @IBOutlet weak var level1CountLabel: UILabel!
    @IBOutlet weak var level2CountLabel: UILabel!
    @IBOutlet weak var level3CountLabel: UILabel!
    
    var resultRepository: ResultRepositoryProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // デバッグ: viewDidLoadが呼ばれたことを確認
        print("StatisticsViewController - viewDidLoad called")
        setupGradientBackground()

        // 依存注入
        resultRepository = appDelegate.resultRepository
        setupUI()
        loadStatistics()
        
        // デバッグ: ナビゲーションスタックの状態を確認
        if let navController = self.navigationController {
            print("StatisticsViewController - Navigation Stack Count: \(navController.viewControllers.count)")
            for (index, vc) in navController.viewControllers.enumerated() {
                print("  [\(index)]: \(type(of: vc))")
            }
        }
    }

    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 戻るボタンを確実に表示する
        self.navigationItem.hidesBackButton = false
        
        // ナビゲーションバーを表示し、背景色をクリーム色に設定
        if let navController = self.navigationController {
            navController.setNavigationBarHidden(false, animated: animated)
            // ナビゲーションバーの背景色をクリーム色に設定
            let creamColor = UIColor(red: 1.0, green: 0.95, blue: 0.9, alpha: 1.0)
            navController.navigationBar.backgroundColor = creamColor
            navController.navigationBar.barTintColor = creamColor
            // ナビゲーションコントローラーのビューの背景色もクリーム色に設定（黒い部分をなくす）
            navController.view.backgroundColor = creamColor
            // 影を削除してスッキリ見せる
            navController.navigationBar.shadowImage = UIImage()
            navController.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navController.navigationBar.isTranslucent = false
            // タイトルとボタンの文字色を濃い色に設定（クリーム色の背景でも見やすくする）
            let darkColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0) // 濃いグレー
            navController.navigationBar.titleTextAttributes = [
                .foregroundColor: darkColor,
                .font: UIFont.boldSystemFont(ofSize: 17)
            ]
            navController.navigationBar.tintColor = darkColor
        }
        
        // デバッグ: ナビゲーションスタックの状態を確認
        if let navController = self.navigationController {
            print("StatisticsViewController - Navigation Stack Count: \(navController.viewControllers.count)")
            for (index, vc) in navController.viewControllers.enumerated() {
                print("  [\(index)]: \(type(of: vc))")
            }
        }
        // 画面が表示されるたびに統計を更新
        loadStatistics()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 戻るボタンを確実に表示する（viewDidAppearでも設定）
        self.navigationItem.hidesBackButton = false
        // ナビゲーションバーを表示する
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setupUI() {
        self.navigationItem.hidesBackButton = false
        navigationItem.title = "統計"
    }
    
    /// ResultRepositoryから履歴を読み込んで統計を計算し、UIに表示する
    private func loadStatistics() {
        let records = resultRepository.loadAll()
        let statistics = Statistics(from: records)
        
        // UIに統計情報を表示
        totalPlaysLabel.text = "\(statistics.totalPlays)"
        totalPlaysLabel.textColor = .black
        averageScoreLabel.text = String(format: "%.2f", statistics.averageScore)
        bestScoreLabel.text = String(format: "%.2f", statistics.bestScore)
        level1CountLabel.text = "\(statistics.level1Count)"
        level2CountLabel.text = "\(statistics.level2Count)"
        level3CountLabel.text = "\(statistics.level3Count)"
    }
}
