//
//  JudgementViewModelTests.swift
//  JudgementViewModelTests
//
//  Created by 藤田優作 on 2023/12/11.
//  Copyright © 2023 藤田優作. All rights reserved.
//

import XCTest
@testable import suprisedApp

final class JudgementViewModelTests: XCTestCase {

    var sut: JudgementViewModel!
    
    override func setUpWithError() throws {
        sut = JudgementViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testMotionUpdates() {
        // 期待されるモーションデータ
        var expectedMotionData: MotionData?
        
        // 期待されるモーションデータを受け取るためのexpectationを作成
        let expectation = self.expectation(description: "Motion data updated")
        
        // motionDataChangedクロージャが呼ばれたら期待通りのデータか確認し、expectationをfulfill
        sut.motionDataChanged = { motionData in
            print("Motion data updated: \(motionData)")
            expectedMotionData = motionData
            expectation.fulfill()
        }
        
        // モーションデータ更新を開始
        sut.startMotionUpdates()
        
        // モーションデータの更新が終わるまで待つ
        waitForExpectations(timeout: 2, handler: nil)
        
        // 期待値がnilでないことを確認
        XCTAssertNotNil(expectedMotionData)
    }
    
    // デバイスのモーションデータが利用できない場合のテスト
    func testMotionDataNotAvailable() {
        // モーションデータの更新を開始
        sut.startMotionUpdates()
        
        // モーションデータが取得できない場合はnilであることを確認
        XCTAssertNil(sut.motionData)
        
        // モーションデータの更新を停止
        sut.stopMotionUpdates()
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
