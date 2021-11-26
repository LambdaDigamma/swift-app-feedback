//
//  Feedback.swift
//  
//
//  Created by Lennart Fischer on 31.10.21.
//

import Foundation

public protocol DeviceStateProviding: Codable {
    
    var batteryLevel: Float { get set }
    
}

public struct DefaultStateInformation: DeviceStateProviding {
    
    public var batteryLevel: Float
    
    public init(
        batteryLevel: Float
    ) {
        self.batteryLevel = batteryLevel
    }
    
}

public protocol DeviceInformationProviding: Codable {
    
    var deviceName: String { get set }
    
}

public struct Feedback<DeviceState: DeviceStateProviding>: Codable {
    
    public let logEntries: [LogEntry]
    public let deviceState: DeviceState
    
    public init(
        deviceState: DeviceState,
        logEntries: [LogEntry]
    ) {
        self.logEntries = logEntries
        self.deviceState = deviceState
    }
    
    public enum CodingKeys: String, CodingKey {
        
        case logEntries = "logEntries"
        case deviceState = "deviceState"
        
    }
    
}
