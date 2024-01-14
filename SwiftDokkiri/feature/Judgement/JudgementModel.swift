//
//  JudgementModel.swift
//  SwiftDokkiri
//
//  Created by 藤田優作 on 2023/12/10.
//  Copyright © 2023 藤田優作. All rights reserved.
//

import Foundation

// Model
struct MotionData: Equatable {
    var x: Double
    var y: Double
    
    // Equatableプロトコルに準拠するための比較演算子
    static func ==(lhs: MotionData, rhs: MotionData) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}
