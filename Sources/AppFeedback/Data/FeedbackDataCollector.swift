//
//  FeedbackDataCollector.swift
//  
//
//  Created by Lennart Fischer on 20.08.21.
//

import Foundation

#if canImport(UIKit)
import UIKit
import OSLog

extension UIDevice.BatteryState: CustomStringConvertible {
    
    public var description: String {
        switch self {
            case .charging:
                return "charging"
            case .full:
                return "full"
            case .unknown:
                return "unknown"
            case .unplugged:
                return "unplugged"
            @unknown default:
                return "unknown"
        }
    }
    
}

public class FeedbackDataCollector: FeedbackDataCollecting {
    
    public init() {
        
    }
    
    public func collect() {
        
    }
    
    public var identifierForVendor: String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }
    
    public var name: String {
        return UIDevice.current.name
    }
    
    public var system: String {
        return "\(UIDevice.current.systemName) (\(UIDevice.current.systemVersion))"
    }
    
    public var battery: String {
        return "\(UIDevice.current.batteryState) \(UIDevice.current.batteryLevel)"
    }
    
}

#endif
