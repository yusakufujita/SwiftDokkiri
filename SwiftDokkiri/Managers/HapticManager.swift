//
//  HapticManager.swift
//  SwiftDokkiri
//
//  Created by 藤田優作 on 2024/01/01.
//  Copyright © 2024 藤田優作. All rights reserved.
//

import UIKit

class HapticManager {
    private let settingsRepository: SettingsRepositoryProtocol
    private let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
    private let notificationFeedbackGenerator = UINotificationFeedbackGenerator()
    private let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
    
    init(settingsRepository: SettingsRepositoryProtocol) {
        self.settingsRepository = settingsRepository
        // パフォーマンス向上のため、事前に準備
        impactFeedbackGenerator.prepare()
        notificationFeedbackGenerator.prepare()
        selectionFeedbackGenerator.prepare()
    }
    
    /// インパクトフィードバック（中程度の振動）
    func impact() {
        guard settingsRepository.isVibrationEnabled else {
            return
        }
        impactFeedbackGenerator.impactOccurred()
    }
    
    /// インパクトフィードバック（軽い振動）
    func lightImpact() {
        guard settingsRepository.isVibrationEnabled else {
            return
        }
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()
        generator.impactOccurred()
    }
    
    /// インパクトフィードバック（重い振動）
    func heavyImpact() {
        guard settingsRepository.isVibrationEnabled else {
            return
        }
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.prepare()
        generator.impactOccurred()
    }
    
    /// 通知フィードバック（成功）
    func success() {
        guard settingsRepository.isVibrationEnabled else {
            return
        }
        notificationFeedbackGenerator.notificationOccurred(.success)
    }
    
    /// 通知フィードバック（警告）
    func warning() {
        guard settingsRepository.isVibrationEnabled else {
            return
        }
        notificationFeedbackGenerator.notificationOccurred(.warning)
    }
    
    /// 通知フィードバック（エラー）
    func error() {
        guard settingsRepository.isVibrationEnabled else {
            return
        }
        notificationFeedbackGenerator.notificationOccurred(.error)
    }
    
    /// 選択フィードバック（軽い振動）
    func selection() {
        guard settingsRepository.isVibrationEnabled else {
            return
        }
        selectionFeedbackGenerator.selectionChanged()
    }
}
