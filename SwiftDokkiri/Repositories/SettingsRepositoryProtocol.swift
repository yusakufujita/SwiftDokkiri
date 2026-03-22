//
//  SettingsRepositoryProtocol.swift
//  SwiftDokkiri
//
//  Created by 藤田優作 on 2024/01/01.
//  Copyright © 2024 藤田優作. All rights reserved.
//

import Foundation

import UIKit

protocol SettingsRepositoryProtocol {
    /// 音声が有効かどうか
    var isSoundEnabled: Bool { get set }
    
    /// 振動が有効かどうか
    var isVibrationEnabled: Bool { get set }
    
    /// PushButton画面のカスタム背景画像パス
    var pushButtonCustomBackgroundImagePath: String? { get set }
    
    /// Judgement画面のカスタム背景画像パス
    var judgementCustomBackgroundImagePath: String? { get set }
    
    /// カスタム画像を保存する
    /// - Parameters:
    ///   - image: 保存する画像
    ///   - forScreen: どの画面用か（"pushButton" または "judgement"）
    /// - Returns: 保存された画像のパス
    func saveCustomBackgroundImage(_ image: UIImage, forScreen: String) -> String?
    
    /// カスタム画像を読み込む
    /// - Parameter path: 画像のパス
    /// - Returns: 読み込んだ画像、またはnil
    func loadCustomBackgroundImage(path: String) -> UIImage?
}
