//
//  MessengerTests.swift
//  MessengerTests
//
//  Created by Mohar on 31/03/25.
//

import XCTest
@testable import Messenger

final class MessengerTests: XCTestCase {
    
    private var viewModel = ChatViewModel()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
            self.measure {
                // Put the code you want to measure the time of here.
            }
        }
        
        // MARK: - Message Model Tests
        func testMessageModelInitialization() throws {
            let message = Message(sender: "Alice", text: "Hello!", date: Date(), isSentByCurrentUser: false)

            XCTAssertEqual(message.sender, "Alice")
            XCTAssertEqual(message.text, "Hello!")
            XCTAssertFalse(message.isSentByCurrentUser)
        }

        // MARK: - ChatViewModel Tests
        func testSendingNewMessageIncreasesMessageCount() throws {
            let initialCount = viewModel.messages.count

            viewModel.newMessageText = "Testing message"
            viewModel.sendMessage()

            XCTAssertEqual(viewModel.messages.count, initialCount + 1)
            XCTAssertEqual(viewModel.messages.last?.text, "Testing message")
            XCTAssertTrue(viewModel.messages.last?.isSentByCurrentUser ?? false)
        }

        func testSendingEmptyMessageDoesNotIncreaseCount() throws {
            let initialCount = viewModel.messages.count

            viewModel.newMessageText = "   " // spaces only
            viewModel.sendMessage()

            XCTAssertEqual(viewModel.messages.count, initialCount)
        }

        func testNewMessageTextClearsAfterSending() throws {
            viewModel.newMessageText = "This will clear"
            viewModel.sendMessage()

            XCTAssertEqual(viewModel.newMessageText, "")
        }

        func testDateFormatterExtension() throws {
            let date = Date(timeIntervalSince1970: 0) // 1 Jan 1970, 00:00 UTC
            let formattedTime = DateFormatter.shortTimeFormatter.string(from: date)

            XCTAssertFalse(formattedTime.isEmpty, "Formatted time should not be empty.")
        }

    
}
