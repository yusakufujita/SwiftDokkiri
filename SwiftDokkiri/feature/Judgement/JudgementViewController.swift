//
//  Sound2ViewController.swift
//  SwiftDokkiri
//
//  Created by 藤田優作 on 2020/04/14.
//  Copyright © 2020 藤田優作. All rights reserved.
//

import UIKit
import CoreMotion

class JudgementViewController: UIViewController {
    
    var viewModel: JudgementViewModel!
    var audioManager: AudioManager?
    var hapticManager: HapticManager?
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 依存注入
        audioManager = appDelegate.audioManager
        hapticManager = appDelegate.hapticManager
        setupUI()
        setupViewModel()
        viewModel.startMotionUpdates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 画面が表示されるたびに背景画像を更新（設定が変更された可能性があるため）
        loadBackgroundImage()
    }
    
    private func setupUI() {
        self.navigationItem.hidesBackButton = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        // AudioManagerを使って音声を再生（設定されている場合のみ）
        audioManager?.playSound(name: "explosion")
        // HapticManagerを使って振動を発生（設定されている場合のみ）
        hapticManager?.impact()
        
        // 背景画像を読み込む
        loadBackgroundImage()
    }
    
    private func loadBackgroundImage() {
        let settingsRepository = appDelegate.settingsRepository
        
        // カスタム画像が設定されている場合はそれを優先
        if let customImagePath = settingsRepository.judgementCustomBackgroundImagePath,
           let customImage = settingsRepository.loadCustomBackgroundImage(path: customImagePath) {
            backgroundImageView?.image = customImage
        } else {
            // デフォルト画像を使用
            backgroundImageView?.image = UIImage(named: "horrorman")
        }
    }
    
    private func setupViewModel() {
        viewModel = JudgementViewModel()
        viewModel.motionDataChanged = { [weak self] motionData in
            self?.updateUI(with: motionData)
        }
    }
    ///
    /// - Parameters:
    ///   - motionData: モーションデータが入ってくる
    private func updateUI(with motionData: MotionData) {
        print("attitude roll: \(motionData.x)")
        print("attitude pitch: \(motionData.y)")
    }
    
    @IBAction func judgementButtonAction(_ sender: Any) {
        // ボタン押下時の振動フィードバック（設定されている場合のみ）
        hapticManager?.selection()
        
        viewModel.stopMotionUpdates()
        pushViewControllerOverNavigation("Result") {(vc: ResultViewController) in
            // 依存注入
            vc.resultRepository = self.appDelegate.resultRepository
            if let x = self.viewModel.motionData?.x, let y = self.viewModel.motionData?.y {
                vc.result = x + y
            } else {
                // エラーハンドリングやデフォルトの処理を行う
                vc.result = 0
            }
        }
    }
}
