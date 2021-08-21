//
//  FeedbackView.swift
//  
//
//  Created by Lennart Fischer on 20.08.21.
//

import SwiftUI

public struct FeedbackView: View {

    @ObservedObject var stringResolver: StringResolver
    @State public var attachInformation: Bool = true

    private let configuration: FeedbackConfiguration
    
    /// Function called when user tapped compose feedback.
    /// Boolean determines whether technical information
    /// should be attached.
    public var onComposeFeedback: (Bool) -> Void = { _ in }
    
    public var onRateAppStore: () -> Void
    
    public init(
        configuration: FeedbackConfiguration,
        stringResolver: StringResolver,
        onComposeFeedback: @escaping (Bool) -> Void,
        onRateAppStore: @escaping () -> Void
    ) {
        self.configuration = configuration
        self.stringResolver = stringResolver
        self.onComposeFeedback = onComposeFeedback
        self.onRateAppStore = onRateAppStore
    }

    public var body: some View {
        VStack {
            
            ScrollView {
                VStack {
                    
                    VStack {
                        
                        configuration.feedbackImage
                            .resizable()
                            .scaledToFit()
                            .accessibility(identifier: "AppFeedback.feedbackImage")
                            .frame(maxWidth: 500, alignment: .center)
                            .padding(.bottom, 20)
                        
                        Text(stringResolver.resolve("AppFeedback.infoTextIntro"))
                            .bold()
                            + Text(stringResolver.resolve("AppFeedback.infoText"))
                            .foregroundColor(.secondary)
                        
                    }
                    .padding()
                    
                    FeedbackActionRow(
                        configuration: configuration,
                        composeFeedback: onComposeFeedback
                    )
                    .frame(maxWidth: .infinity)
                    
                    if configuration.showReview {
                        
                        Divider()
                        
                        Button(action: onRateAppStore, label: {
                            Text("\(Image(systemName: "star")) \(stringResolver.resolve("AppFeedback.rateAction"))")
                                .foregroundColor(.secondary)
                        })
                        .accessibility(identifier: "AppFeedback.rateButton")
                        .padding(.vertical, 8)
                        
                        Divider()
                            .padding(.bottom, 20)
                        
                    }
                    
                }
                
            }.frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle(stringResolver.resolve("AppFeedback.title"))
        .environmentObject(stringResolver)
        
    }
    
    private func composeFeedback() {
        self.onComposeFeedback(attachInformation)
    }

}

struct FeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        
        let configuration = FeedbackConfiguration(receiver: "info@example.org", subject: "Feedback")
        
        NavigationView {
            FeedbackView(configuration: configuration, stringResolver: .default, onComposeFeedback: { _ in }, onRateAppStore: {})
        }
    }
}
