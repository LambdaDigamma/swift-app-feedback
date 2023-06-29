//
//  Bundle+Extensions.swift
//
//
//  Created by Lennart Fischer on 01.12.21.
//

import Foundation

public extension Bundle {
    
    internal var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    internal var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    
    internal var bundleID: String? {
        return Bundle.main.bundleIdentifier?.lowercased()
    }
    
}
