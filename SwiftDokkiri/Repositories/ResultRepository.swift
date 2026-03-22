//
//  ResultRepository.swift
//  SwiftDokkiri
//
//  Created by 藤田優作 on 2024/01/01.
//  Copyright © 2024 藤田優作. All rights reserved.
//

import Foundation

class ResultRepository: ResultRepositoryProtocol {
    private let userDefaults: UserDefaults
    private let recordsKey = "gameResults"
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func save(record: ResultRecord) throws {
        // UserDefaultsに保存
        var records = loadAll()
        records.append(record)
        
        // Codableを使ってJSONエンコード
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let data = try encoder.encode(records)
        userDefaults.set(data, forKey: recordsKey)
        userDefaults.synchronize()
        
        // 将来的にFirestoreを追加する場合は、ここで非同期に保存
        // 現在はUserDefaultsのみで実装
    }
    
    func loadAll() -> [ResultRecord] {
        // UserDefaultsから読み込み
        guard let data = userDefaults.data(forKey: recordsKey) else {
            return []
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            return try decoder.decode([ResultRecord].self, from: data)
        } catch {
            print("UserDefaultsからの読み込みエラー: \(error.localizedDescription)")
            return []
        }
    }
    
    func clear() throws {
        // UserDefaultsをクリア
        userDefaults.removeObject(forKey: recordsKey)
        userDefaults.synchronize()
    }
}
