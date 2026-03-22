//
//  UIViewController+Extension.swift
//  SwiftDokkiri
//
//  Created by 藤田優作 on 2023/12/08.
//  Copyright © 2023 藤田優作. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func pushViewControllerOverNavigation<T: UIViewController>(_ storyboard: String, _ additionalOperation: ((T) -> ())? = nil) {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let nextVC = storyboard.instantiateInitialViewController()
        if let nextVC = nextVC as? T {
            additionalOperation?(nextVC)
        }
        navigationController?.pushViewController(nextVC!, animated: true)
    }
    
    /// AppDelegateから依存関係を取得する
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    /// グラデーション背景を設定する
    /// - Parameters:
    ///   - colors: グラデーションの色配列（デフォルトは柔らかいピンク系）
    ///   - locations: 各色の位置（0.0〜1.0、デフォルトは[0.0, 0.5, 1.0]）
    ///   - startPoint: グラデーションの開始点（デフォルトは左上: 0,0）
    ///   - endPoint: グラデーションの終了点（デフォルトは右下: 1,1）
    func setupGradientBackground(
        colors: [UIColor]? = nil,
        locations: [NSNumber]? = nil,
        startPoint: CGPoint = CGPoint(x: 0.0, y: 0.0),
        endPoint: CGPoint = CGPoint(x: 1.0, y: 1.0)
    ) {
        // グラデーションレイヤーを作成
        let gradientLayer = CAGradientLayer()
        
        // デフォルトの色を使用（指定されていない場合）
        let defaultColors = [
            UIColor(red: 1.0, green: 0.95, blue: 0.9, alpha: 1.0).cgColor,  // 薄いクリーム色
            UIColor(red: 1.0, green: 0.9, blue: 0.85, alpha: 1.0).cgColor,  // 薄いピーチ色
            UIColor(red: 0.95, green: 0.85, blue: 0.9, alpha: 1.0).cgColor  // 薄いラベンダー色
        ]
        
        gradientLayer.colors = colors?.map { $0.cgColor } ?? defaultColors
        gradientLayer.locations = locations ?? [0.0, 0.5, 1.0]
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        
        // ビューのサイズに合わせる
        gradientLayer.frame = view.bounds
        
        // 既存のグラデーションレイヤーを削除してから追加
        if let existingLayer = view.layer.sublayers?.first(where: { $0 is CAGradientLayer }) {
            existingLayer.removeFromSuperlayer()
        }
        
        // グラデーションレイヤーを最背面に追加
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    /// グラデーション背景を更新する（viewDidLayoutSubviewsで呼び出す）
    func updateGradientBackground() {
        if let gradientLayer = view.layer.sublayers?.first(where: { $0 is CAGradientLayer }) as? CAGradientLayer {
            gradientLayer.frame = view.bounds
        }
    }
}
