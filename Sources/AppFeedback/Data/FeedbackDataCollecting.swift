//
//  FeedbackDataCollecting.swift
//  
//
//  Created by Lennart Fischer on 20.08.21.
//

import Foundation

public protocol FeedbackDataCollecting: AnyObject {
    
    func collect() -> [String]
    
}
