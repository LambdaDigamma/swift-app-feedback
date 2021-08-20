//
//  StringBundleResolving.swift
//  
//
//  Created by Lennart Fischer on 20.08.21.
//

import Foundation

public class StringResolver: ObservableObject {
    
    public static let `default` = StringResolver(bundle: .module)
    
    private let bundle: Bundle
    
    public init(bundle: Bundle) {
        self.bundle = bundle
    }
    
    public init() {
        self.bundle = Bundle.module
    }
    
    /// Resolves the localized string from the provided bundle
    /// to enable customizable copy in your application.
    /// - Parameter key: The key of the localized string
    /// - Returns: The localized string
    open func resolve(_ key: String) -> String {
        return NSLocalizedString(key, bundle: bundle, value: "", comment: "")
    }
    
}
