//
//  LogCollector.swift
//  TFdoors
//
//  Created by Lennart Fischer on 30.10.21.
//  Copyright © 2021 Inventas. All rights reserved.
//

import Foundation
import OSLog

@available(iOS 15.0, *)
extension OSLogEntryLog.Level: CustomDebugStringConvertible {
    
    var description: String {
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
            @unknown default:
                return "unknown"
        }
    }
    
    public var debugDescription: String {
        return description
    }
    
}

public protocol LogCollecting {
    
}

struct FileHandlerOutputStream: TextOutputStream {
    private let fileHandle: FileHandle
    let encoding: String.Encoding
    
    init(_ fileHandle: FileHandle, encoding: String.Encoding = .utf8) {
        self.fileHandle = fileHandle
        self.encoding = encoding
    }
    
    mutating func write(_ string: String) {
        if let data = string.data(using: encoding) {
            fileHandle.write(data)
        }
    }
}

/// The `LogCollector` uses the `OSLog` framework to collect
/// the device logs from the app. It stores the logs and additional
/// device information in a custom json format on disk.
@available(iOS 15.0, *)
public class LogCollector: LogCollecting {
    
    private let store: OSLogStore
    private let collectedMinutesSinceNow: Double
    
    /// Initalize the `LogCollector` with a time since
    /// when the system logs should be retrieved.
    /// - Parameter collectedMinutesSinceNow: Specify the number of minutes the log collector should go back
    public init(collectedMinutesSinceNow: Double = 15) throws {
        self.collectedMinutesSinceNow = collectedMinutesSinceNow
        #if os(macOS)
        store = try OSLogStore.local()
        #else
        store = try OSLogStore(scope: .currentProcessIdentifier)
        #endif
    }
    
    public func collect() throws -> URL? {
        
        let startStorePosition = store.position(timeIntervalSinceEnd: -60.0 * collectedMinutesSinceNow)
        let entries = try store.getEntries(with: [], at: startStorePosition, matching: nil)
        
        let url = FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent("Activity.appfeedback")
        
        if let url = url {
            
            FileManager.default.createFile(atPath: url.path, contents: nil, attributes: nil)
            
            let logEntries = entries
                .compactMap({ $0 as? OSLogEntryLog })
                .map({ LogEntry(osLogEntryLog: $0) })
                
            let feedback = Feedback(
                deviceState: DefaultStateInformation(batteryLevel: 1),
                appInformation: AppInformation.loadCurrent(),
                logEntries: logEntries
            )
            
            let encoder = JSONEncoder()
            let data = try encoder.encode(feedback)
            
            try data.write(to: url)
            
//            let formatter = ISO8601DateFormatter()
//            formatter.timeZone = TimeZone(abbreviation: "UTC")
//            let fileHandle = try FileHandle(forWritingTo: url)
//            var output = FileHandlerOutputStream(fileHandle)
//            data
//                .forEach { (entryLog: OSLogEntryLog) in
//
//                    let date = formatter.string(from: entryLog.date)
//
//                    print("Cateogry \(entryLog.category)")
//                    print("Sender \(entryLog.sender)")
//                    print("Level \(entryLog.level)")
//                    print("Subsystem \(entryLog.subsystem)")
//
//                    let logLine = "\(formatter.string(from: entryLog.date))      \(entryLog.composedMessage)\n"
//
//                    output.write(logLine)
//                }
//
//            try fileHandle.close()
            
            return url
            
        }
        
        return nil
        
    }
    
}
