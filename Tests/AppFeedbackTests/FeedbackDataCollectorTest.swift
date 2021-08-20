//
//  FeedbackDataCollectorTest.swift
//  
//
//  Created by Lennart Fischer on 20.08.21.
//

import XCTest
@testable import AppFeedback

final class FeedbackDataCollectorTest: XCTestCase {
    
    var collector: FeedbackDataCollector!
    
    override func setUp() {
        super.setUp()
        
        self.collector = FeedbackDataCollector()
    }
    
    func test_identifierForVendor() {
        
        XCTAssertNotNil(collector.identifierForVendor)
        
    }
    
    func test_name() {
        
        XCTAssertFalse(collector.name.isEmpty)
        
    }
    
    func test_system() {
        
        XCTAssertFalse(collector.system.isEmpty)
        
    }
    
    func test_battery() {
        
        XCTAssertFalse(collector.battery.isEmpty)
        
        print(collector.battery)
        
    }
    
    static var allTests = [
        ("test_identifierForVendor", test_identifierForVendor),
        ("test_name", test_name),
        ("test_system", test_system),
        ("test_battery", test_battery),
    ]
}
