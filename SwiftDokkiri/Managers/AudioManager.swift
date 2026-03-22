//
//  AudioManager.swift
//  SwiftDokkiri
//
//  Created by 藤田優作 on 2024/01/01.
//  Copyright © 2024 藤田優作. All rights reserved.
//

import Foundation
import AVFoundation

class AudioManager {
    private let settingsRepository: SettingsRepositoryProtocol
    private var audioPlayer: AVAudioPlayer?
    
    init(settingsRepository: SettingsRepositoryProtocol) {
        self.settingsRepository = settingsRepository
    }
    
    /// 音声を再生する
    /// - Parameter name: 音源ファイル名（拡張子なし）
    func playSound(name: String) {
        // 設定がOFFの場合は再生しない
        guard settingsRepository.isSoundEnabled else {
            return
        }
        
        guard let path = Bundle.main.path(forResource: name, ofType: "mp3") else {
            print("音源ファイルが見つかりません: \(name)")
            return
        }
        
        do {
            // AVAudioPlayerのインスタンス化
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("音声の再生エラー: \(error.localizedDescription)")
        }
    }
    
    /// 音声の再生を停止する
    func stopSound() {
        audioPlayer?.stop()
        audioPlayer = nil
    }
}
