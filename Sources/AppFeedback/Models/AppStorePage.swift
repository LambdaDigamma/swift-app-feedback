//
//  AppStorePage.swift
//  
//
//  Created by Lennart Fischer on 20.08.21.
//

import Foundation
import OSLog
#if canImport(UIKit)
import UIKit
#endif

public typealias AppStoreID = String

public class AppStorePage {
    
    private let logger: Logger = Logger(OSLog.feedback)
    public var id: AppStoreID
    
    public init(id: AppStoreID) {
        self.id = id
    }
    
    public func openReview() {
        
        guard let productPageURL = productPageURL else { return }
        var components = URLComponents(url: productPageURL, resolvingAgainstBaseURL: false)
        
        components?.queryItems = [
            URLQueryItem(name: "action", value: "write-review")
        ]
        
        guard let writeReviewURL = components?.url else {
            return
        }
        
        #if os(iOS)
        logger.info("Opening App Store write review page: \(writeReviewURL.absoluteString)")
        UIApplication.shared.open(writeReviewURL)
        #else
        logger.error("Not able to open write review url")
        #endif
        
    }
    
    public var productPageURL: URL? {
        return URL(string: "itms-apps://itunes.apple.com/app/id\(id)")
    }
    
}
