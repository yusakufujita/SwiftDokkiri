//
//  SettingsRepository.swift
//  SwiftDokkiri
//
//  Created by 藤田優作 on 2024/01/01.
//  Copyright © 2024 藤田優作. All rights reserved.
//

import Foundation
import UIKit

class SettingsRepository: SettingsRepositoryProtocol {
    private let userDefaults: UserDefaults
    private let soundEnabledKey = "isSoundEnabled"
    private let vibrationEnabledKey = "isVibrationEnabled"
    private let pushButtonCustomBackgroundImagePathKey = "pushButtonCustomBackgroundImagePath"
    private let judgementCustomBackgroundImagePathKey = "judgementCustomBackgroundImagePath"
    
    // カスタム画像を保存するディレクトリ
    private var customImagesDirectory: URL {
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let imagesDirectory = documentsPath.appendingPathComponent("CustomBackgroundImages")
        
        // ディレクトリが存在しない場合は作成
        if !FileManager.default.fileExists(atPath: imagesDirectory.path) {
            try? FileManager.default.createDirectory(at: imagesDirectory, withIntermediateDirectories: true, attributes: nil)
        }
        
        return imagesDirectory
    }
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    var isSoundEnabled: Bool {
        get {
            // デフォルト値はtrue（音声ON）
            if userDefaults.object(forKey: soundEnabledKey) == nil {
                return true
            }
            return userDefaults.bool(forKey: soundEnabledKey)
        }
        set {
            userDefaults.set(newValue, forKey: soundEnabledKey)
            userDefaults.synchronize()
        }
    }
    
    var isVibrationEnabled: Bool {
        get {
            // デフォルト値はtrue（振動ON）
            if userDefaults.object(forKey: vibrationEnabledKey) == nil {
                return true
            }
            return userDefaults.bool(forKey: vibrationEnabledKey)
        }
        set {
            userDefaults.set(newValue, forKey: vibrationEnabledKey)
            userDefaults.synchronize()
        }
    }
    
    var pushButtonCustomBackgroundImagePath: String? {
        get {
            return userDefaults.string(forKey: pushButtonCustomBackgroundImagePathKey)
        }
        set {
            if let path = newValue {
                userDefaults.set(path, forKey: pushButtonCustomBackgroundImagePathKey)
            } else {
                userDefaults.removeObject(forKey: pushButtonCustomBackgroundImagePathKey)
            }
            userDefaults.synchronize()
        }
    }
    
    var judgementCustomBackgroundImagePath: String? {
        get {
            return userDefaults.string(forKey: judgementCustomBackgroundImagePathKey)
        }
        set {
            if let path = newValue {
                userDefaults.set(path, forKey: judgementCustomBackgroundImagePathKey)
            } else {
                userDefaults.removeObject(forKey: judgementCustomBackgroundImagePathKey)
            }
            userDefaults.synchronize()
        }
    }
    
    func saveCustomBackgroundImage(_ image: UIImage, forScreen: String) -> String? {
        // 画像をJPEG形式で保存
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            return nil
        }
        
        // ファイル名を生成（タイムスタンプを使用）
        let fileName = "\(forScreen)_\(Date().timeIntervalSince1970).jpg"
        let fileURL = customImagesDirectory.appendingPathComponent(fileName)
        
        // ファイルに保存
        do {
            try imageData.write(to: fileURL)
            return fileURL.path
        } catch {
            print("画像の保存に失敗しました: \(error.localizedDescription)")
            return nil
        }
    }
    
    func loadCustomBackgroundImage(path: String) -> UIImage? {
        guard FileManager.default.fileExists(atPath: path) else {
            return nil
        }
        
        let fileURL = URL(fileURLWithPath: path)
        guard let imageData = try? Data(contentsOf: fileURL) else {
            return nil
        }
        
        return UIImage(data: imageData)
    }
}
