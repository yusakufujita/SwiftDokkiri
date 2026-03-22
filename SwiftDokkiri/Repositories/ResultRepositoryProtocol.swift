//
//  ResultRepositoryProtocol.swift
//  SwiftDokkiri
//
//  Created by 藤田優作 on 2024/01/01.
//  Copyright © 2024 藤田優作. All rights reserved.
//

import Foundation

protocol ResultRepositoryProtocol {
    /// ゲーム結果を保存する（UserDefaults + Firestore）
    /// - Parameter record: 保存する結果レコード
    func save(record: ResultRecord) throws
    
    /// すべてのゲーム結果を読み込む
    /// - Returns: 保存されているすべての結果レコード
    func loadAll() -> [ResultRecord]
    
    /// すべてのゲーム結果を削除する
    func clear() throws
}
