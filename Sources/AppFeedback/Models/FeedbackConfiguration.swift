//
//  FeedbackConfiguration.swift
//  
//
//  Created by Lennart Fischer on 20.08.21.
//

import Foundation
import SwiftUI

public struct ButtonAppearance {
    
    public let backgroundColor: Color
    public let foregroundColor: Color
    
    public init(
        backgroundColor: Color = .blue,
        foregroundColor: Color = .white
    ) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
    }
    
}

public struct FeedbackConfiguration {
    
    public let receivers: [String]
    public let subject: String
    public let showReview: Bool
    public let appStoreID: AppStoreID?
    public let buttonAppearance: ButtonAppearance
    public let feedbackImage: Image
    
    public init(
        receiver: String,
        subject: String,
        showReview: Bool = true,
        appStoreID: String? = nil,
        buttonAppearance: ButtonAppearance = ButtonAppearance(),
        feedbackImage: Image
    ) {
        self.receivers = [receiver]
        self.subject = subject
        self.showReview = showReview
        self.appStoreID = appStoreID
        self.buttonAppearance = buttonAppearance
        self.feedbackImage = feedbackImage
    }
    
    public init(
        receiver: String,
        subject: String,
        showReview: Bool = true,
        appStoreID: String? = nil,
        buttonAppearance: ButtonAppearance = ButtonAppearance()
    ) {
        self.receivers = [receiver]
        self.subject = subject
        self.showReview = showReview
        self.appStoreID = appStoreID
        self.buttonAppearance = buttonAppearance
        self.feedbackImage = Image("feedback-illustration", bundle: .module)
    }
    
}
