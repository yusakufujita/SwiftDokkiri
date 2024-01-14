//
//  JudgementViewModel.swift
//  SwiftDokkiri
//
//  Created by 藤田優作 on 2023/12/10.
//  Copyright © 2023 藤田優作. All rights reserved.
//

import Foundation
import CoreMotion

class JudgementViewModel {
    private let motionManager = CMMotionManager()
    
    // 外部からアクセス可能なプロパティ
    private(set) var motionData: MotionData?
    
    var motionDataChanged: ((MotionData) -> Void)?
    
    func startMotionUpdates() {
        if motionManager.isDeviceMotionAvailable {
             motionManager.deviceMotionUpdateInterval = 1 / 100
             motionManager.startDeviceMotionUpdates(to: .main) { [weak self] (data, error) in
                 guard let data = data else {
                     print("モーションデータが取得できません")
                     return
                 }
                 
                 let roll = data.attitude.roll
                 let pitch = data.attitude.pitch

                 let xAngle = roll * 180 / Double.pi
                 let yAngle = pitch * 180 / Double.pi

                 let x = pow(xAngle, 2) * 100
                 let y = pow(yAngle, 2) * 100

                 let motionData = MotionData(x: x, y: y)
                 
                 // motionDataをプロパティに設定
                 self?.motionData = motionData
                 
                 // クロージャ経由で通知
                 self?.motionDataChanged?(motionData)
             }
         } else {
             print("デバイスのモーションデータは利用できません")
         }
    }
    
    func stopMotionUpdates() {
        motionManager.stopDeviceMotionUpdates()
    }
}
