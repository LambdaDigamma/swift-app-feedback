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

public struct AppInformation: Codable {
    
    public var buildNumber: String?
    public var versionNumber: String?
    public var bundleIdentifier: String?
    
    public init(buildNumber: String? = nil, versionNumber: String? = nil, bundleIdentifier: String?) {
        self.buildNumber = buildNumber
        self.versionNumber = versionNumber
        self.bundleIdentifier = bundleIdentifier
    }
    
    public enum CodingKeys: String, CodingKey {
        case buildNumber = "buildNumber"
        case versionNumber = "versionNumber"
        case bundleIdentifier = "bundleIdentifier"
    }
    
    public static func loadCurrent() -> AppInformation {
        return AppInformation(
            buildNumber: Bundle.main.buildVersionNumber,
            versionNumber: Bundle.main.releaseVersionNumber,
            bundleIdentifier: Bundle.main.bundleID
        )
    }
    
}

public struct Feedback<DeviceState: DeviceStateProviding>: Codable {
    
    public let logEntries: [LogEntry]
    public let deviceState: DeviceState
    public let appInformation: AppInformation
    
    public init(
        deviceState: DeviceState,
        appInformation: AppInformation,
        logEntries: [LogEntry]
    ) {
        self.appInformation = appInformation
        self.deviceState = deviceState
        self.logEntries = logEntries
    }
    
    public enum CodingKeys: String, CodingKey {
        
        case logEntries = "logEntries"
        case deviceState = "deviceState"
        case appInformation = "appInformation"
        
    }
    
}
