//
//  LogEntry.swift
//  
//
//  Created by Lennart Fischer on 31.10.21.
//

import Foundation
import OSLog

public struct LogEntry: Codable, Hashable {
    
    public var date: Date
    public var message: String
    public var category: String
    public var subsystem: String
    public var sender: String
    public var level: LogLevel
    
    @available(iOS 15.0, *)
    public init(
        osLogEntryLog: OSLogEntryLog
    ) {
        self.date = osLogEntryLog.date
        self.message = osLogEntryLog.composedMessage
        self.category = osLogEntryLog.category
        self.subsystem = osLogEntryLog.subsystem
        self.sender = osLogEntryLog.sender
        self.level = LogLevel(level: osLogEntryLog.level)
    }
    
    public init(
        date: Date,
        message: String,
        category: String,
        subsystem: String,
        sender: String,
        level: LogLevel
    ) {
        self.date = date
        self.message = message
        self.category = category
        self.subsystem = subsystem
        self.sender = sender
        self.level = level
    }
    
    public enum LogLevel: String, Codable, CustomDebugStringConvertible {
        
        case undefined = "undefined"
        case debug = "debug"
        case info = "info"
        case notice = "notice"
        case error = "error"
        case fault = "fault"
        case unknown = "unknown"
        
        @available(iOS 15.0, *)
        public init(level: OSLogEntryLog.Level) {
            switch level {
                case .undefined:
                    self = .undefined
                case .debug:
                    self = .debug
                case .info:
                    self = .info
                case .notice:
                    self = .notice
                case .error:
                    self = .error
                case .fault:
                    self = .fault
                @unknown default:
                    self = .unknown
            }
        }
        
        public var description: String {
            switch self {
                case .undefined:
                    return "undefined"
                case .error:
                    return "error"
                case .debug:
                    return "debug"
                case .fault:
                    return "fault"
                case .info:
                    return "info"
                case .notice:
                    return "notice"
                case .unknown:
                    return "unknown"
            }
        }
        
        public var debugDescription: String {
            return description
        }
        
    }
    
}
