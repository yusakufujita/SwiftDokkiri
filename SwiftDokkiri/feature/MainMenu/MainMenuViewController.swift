//
//  MainMenuViewController.swift
//  SwiftDokkiri
//
//  Created by 藤田優作 on 2024/01/01.
//  Copyright © 2024 藤田優作. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

  @IBOutlet weak var startGameButton: UIButton!
  @IBOutlet weak var statisticsButton: UIButton!
  @IBOutlet weak var settingsButton: UIButton!

  var hapticManager: HapticManager?

  override func viewDidLoad() {
    super.viewDidLoad()
    // デバッグ: viewDidLoadが呼ばれたことを確認
    print("MainMenuViewController - viewDidLoad called")

    // 依存注入
    hapticManager = appDelegate.hapticManager
    setupUI()

    // デバッグ: ナビゲーションスタックの状態を確認
    if let navController = self.navigationController {
      print(
        "MainMenuViewController - Navigation Stack Count: \(navController.viewControllers.count)")
      for (index, vc) in navController.viewControllers.enumerated() {
        print("  [\(index)]: \(type(of: vc))")
      }
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    // 戻るボタンを隠す（StartViewControllerに戻らないようにする）
    self.navigationItem.hidesBackButton = true

    // ナビゲーションバーを表示し、背景色をクリーム色に設定
    if let navController = navigationController {
      navController.setNavigationBarHidden(false, animated: animated)
      // ナビゲーションバーの背景色をクリーム色に設定（グラデーション背景の最初の色と同じ）
      let creamColor = UIColor(red: 1.0, green: 0.95, blue: 0.9, alpha: 1.0)
      navController.navigationBar.backgroundColor = creamColor
      navController.navigationBar.barTintColor = creamColor
      // 影を削除してスッキリ見せる
      navController.navigationBar.shadowImage = UIImage()
      navController.navigationBar.setBackgroundImage(UIImage(), for: .default)
      navController.navigationBar.isTranslucent = false
      // タイトルとボタンの文字色を濃い色に設定（クリーム色の背景でも見やすくする）
      let darkColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)  // 濃いグレー
      navController.navigationBar.titleTextAttributes = [
        .foregroundColor: darkColor,
        .font: UIFont.boldSystemFont(ofSize: 17),
      ]
      navController.navigationBar.tintColor = darkColor
    }

    // デバッグ: viewWillAppearが呼ばれたことを確認
    print("MainMenuViewController - viewWillAppear called")
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    // 次の画面（Settings/Statistics）でナビゲーションバーを表示する設定は、
    // それぞれの画面のviewWillAppearで行うため、ここでは何もしない
  }

  private func setupUI() {
    // 戻るボタンを隠す（StartViewControllerに戻らないようにする）
    self.navigationItem.hidesBackButton = true
    navigationItem.title = "メインメニュー"

    // グラデーション背景を設定（extensionメソッドを使用）
    setupGradientBackground()

    // ボタンの設定
    startGameButton.addTarget(
      self, action: #selector(startGameButtonTapped(_:)), for: .touchUpInside)
    statisticsButton.addTarget(
      self, action: #selector(statisticsButtonTapped(_:)), for: .touchUpInside)
    settingsButton.addTarget(self, action: #selector(settingsButtonTapped(_:)), for: .touchUpInside)

    // ボタンに角丸を追加
    startGameButton.layer.cornerRadius = 12
    statisticsButton.layer.cornerRadius = 12
    settingsButton.layer.cornerRadius = 12

    // ボタンに影を追加
    startGameButton.layer.shadowColor = UIColor.black.cgColor
    startGameButton.layer.shadowOffset = CGSize(width: 0, height: 2)
    startGameButton.layer.shadowOpacity = 0.2
    startGameButton.layer.shadowRadius = 4

    statisticsButton.layer.shadowColor = UIColor.black.cgColor
    statisticsButton.layer.shadowOffset = CGSize(width: 0, height: 2)
    statisticsButton.layer.shadowOpacity = 0.2
    statisticsButton.layer.shadowRadius = 4

    settingsButton.layer.shadowColor = UIColor.black.cgColor
    settingsButton.layer.shadowOffset = CGSize(width: 0, height: 2)
    settingsButton.layer.shadowOpacity = 0.2
    settingsButton.layer.shadowRadius = 4
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    // ビューのサイズが変更されたときにグラデーションを更新（extensionメソッドを使用）
    updateGradientBackground()
  }

  @objc private func startGameButtonTapped(_ sender: UIButton) {
    hapticManager?.selection()
    // PushButton画面に遷移
    pushViewControllerOverNavigation("PushButton")
  }

  @objc private func statisticsButtonTapped(_ sender: UIButton) {
    hapticManager?.selection()
    // 統計画面に遷移
    pushViewControllerOverNavigation("Statistics") { (vc: StatisticsViewController) in
      // 依存注入
      vc.resultRepository = self.appDelegate.resultRepository
    }
  }

  @objc private func settingsButtonTapped(_ sender: UIButton) {
    hapticManager?.selection()
    // 設定画面に遷移
    pushViewControllerOverNavigation("Settings") { (vc: SettingsViewController) in
      // 依存注入
      vc.settingsRepository = self.appDelegate.settingsRepository
      vc.resultRepository = self.appDelegate.resultRepository
      vc.hapticManager = self.appDelegate.hapticManager
    }
  }
}
