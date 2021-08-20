//
//  FeedbackConfiguration.swift
//  
//
//  Created by Lennart Fischer on 20.08.21.
//

import Foundation

public struct FeedbackConfiguration {
    
    public let receivers: [String]
    public let subject: String
    public let showReview: Bool
    public let appStoreID: AppStoreID?
    
    public init(
        receiver: String,
        subject: String,
        showReview: Bool = true,
        appStoreID: String? = nil
    ) {
        self.receivers = [receiver]
        self.subject = subject
        self.showReview = showReview
        self.appStoreID = appStoreID
    }
    
}
