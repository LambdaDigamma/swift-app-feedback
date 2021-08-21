//
//  FeedbackActionRow.swift
//  
//
//  Created by Lennart Fischer on 20.08.21.
//

import Foundation
import SwiftUI

public struct FeedbackActionRow: View {
    
    @EnvironmentObject var stringResolver: StringResolver
    @State public var attachInformation: Bool = true
    
    public var composeFeedback: (_ attachInformation: Bool) -> Void
    public let configuration: FeedbackConfiguration
    
    public init(
        configuration: FeedbackConfiguration,
        composeFeedback: @escaping (_ attachInformation: Bool) -> Void
    ) {
        self.composeFeedback = composeFeedback
        self.configuration = configuration
    }
    
    public var body: some View {
        
        VStack {
            
            Divider()
            
            VStack {
                
                Button(action: {
                    composeFeedback(attachInformation)
                }, label: {
                    Text(stringResolver.resolve("AppFeedback.action"))
                        .foregroundColor(configuration.buttonAppearance.foregroundColor)
                })
                .accessibility(identifier: "AppFeedback.actionButton")
                .buttonStyle(BlockButtonStyle(color: configuration.buttonAppearance.backgroundColor))
                .padding(.bottom, 8)
                
                Toggle(isOn: $attachInformation, label: {
                    Text(stringResolver.resolve("AppFeedback.includeAttachmentLabel"))
                        .font(.subheadline)
                        .lineLimit(nil)
                        .foregroundColor(.secondary)
                        .accessibility(identifier: "AppFeedback.includeAttachmentLabel")
                })
                .accessibility(identifier: "AppFeedback.includeAttachmentToggle")
                
            }
            .padding()
            
        }
        
    }
    
}

struct FeedbackActionRow_Previews: PreviewProvider {
    static var previews: some View {
        
        let stringResolver = StringResolver(bundle: .module)
        let firstConfiguration = FeedbackConfiguration(receiver: "test@example.org", subject: "Feedback")
        let secondConfiguration = FeedbackConfiguration(receiver: "test@example.org", subject: "Feedback", buttonAppearance: ButtonAppearance(backgroundColor: .red, foregroundColor: .white))
        
        FeedbackActionRow(configuration: firstConfiguration, composeFeedback: { _ in })
            .environmentObject(stringResolver)
            .previewLayout(.sizeThatFits)
        
        FeedbackActionRow(configuration: secondConfiguration, composeFeedback: { _ in })
            .environmentObject(stringResolver)
            .previewLayout(.sizeThatFits)
            .environment(\.colorScheme, .dark)
            .background(Color.black)
            
    }
}
