//
//  Sound2ViewController.swift
//  SwiftDokkiri
//
//  Created by 藤田優作 on 2020/04/14.
//  Copyright © 2020 藤田優作. All rights reserved.
//

import UIKit
import AVFoundation
import CoreMotion

class JudgementViewController: UIViewController,AVAudioPlayerDelegate {
    
    var viewModel: JudgementViewModel!
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModel()
        viewModel.startMotionUpdates()
    }
    
    private func setupUI() {
        self.navigationItem.hidesBackButton = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        playSound(name: "explosion")
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
    
//TODO: 音をiPhoneのデバイスで必ずでるようにする
    func playSound(name: String) {
        guard let path = Bundle.main.path(forResource: name, ofType:"mp3") else {
            print("音源ファイルが見つかりません")
            return
        }
        do {
            // AVAudioPlayerのインスタンス化
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            // AVAudioPlayerのデリゲートをセット
            audioPlayer.delegate = self
            // 音声の再生
            audioPlayer.play()
        } catch {
            
        }
    }
    
    
    @IBAction func judgementButtonAction(_ sender: Any) {
        viewModel.stopMotionUpdates()
        pushViewControllerOverNavigation("Result") {(vc: ResultViewController) in
            if let x = self.viewModel.motionData?.x, let y = self.viewModel.motionData?.y {
                vc.result = x + y
            } else {
                // エラーハンドリングやデフォルトの処理を行う
                vc.result = 0
            }
        }
    }
}
