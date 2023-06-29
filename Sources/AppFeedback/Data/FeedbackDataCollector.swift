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

public extension UIDevice {
    
    var modelIdentifier: String {
        
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        return identifier
        
    }
    
}

public class FeedbackDataCollector: FeedbackDataCollecting {
    
    public init(additionalInformation: [String] = []) {
        self.additionalInformation = additionalInformation
    }
    
    public func collect() -> [String] {
        
        return [
            "\n",
            self.name,
            self.modelIdentifier,
            self.system,
            "\(Bundle.main.releaseVersionNumber ?? "n/v") (\(Bundle.main.buildVersionNumber ?? "n/v"))",
            self.identifierForVendor,
        ]
        .compactMap({ $0 }) + additionalInformation
        
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
    
    public var modelIdentifier: String {
        return UIDevice.current.modelIdentifier
    }
    
    public var battery: String {
        return "\(UIDevice.current.batteryState) \(UIDevice.current.batteryLevel)"
    }
    
    public var additionalInformation: [String] = []
    
}

#endif
