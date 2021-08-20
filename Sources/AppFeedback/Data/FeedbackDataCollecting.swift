//
//  FeedbackDataCollecting.swift
//  
//
//  Created by Lennart Fischer on 20.08.21.
//

import Foundation

public protocol FeedbackDataCollecting: AnyObject {
    
    func collect()
    
    var identifierForVendor: String? { get }
    
    var name: String { get }
    
    var system: String { get }
    
    var battery: String { get }
    
}
