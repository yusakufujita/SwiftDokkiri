//
//  ResultRecord.swift
//  SwiftDokkiri
//
//  Created by 藤田優作 on 2024/01/01.
//  Copyright © 2024 藤田優作. All rights reserved.
//

import Foundation

struct ResultRecord: Codable {
  let id: String
  let level: Int
  let score: Double
  let date: Date

  init(level: Int, score: Double, id: String = UUID().uuidString, date: Date = Date()) {
    self.id = id
    self.level = level
    self.score = score
    self.date = date
  }
}

struct Statistics {
  let totalPlays: Int
  let averageScore: Double
  let bestScore: Double
  let level1Count: Int
  let level2Count: Int
  let level3Count: Int

  init(from records: [ResultRecord]) {
    totalPlays = records.count
    averageScore =
      records.isEmpty ? 0 : records.map { $0.score }.reduce(0, +) / Double(records.count)
    bestScore = records.map { $0.score }.max() ?? 0
    level1Count = records.filter { $0.level == 1 }.count
    level2Count = records.filter { $0.level == 2 }.count
    level3Count = records.filter { $0.level == 3 }.count
  }
}
