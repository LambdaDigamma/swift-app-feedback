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
    
    public init(
        composeFeedback: @escaping (_ attachInformation: Bool) -> Void
    ) {
        self.composeFeedback = composeFeedback
    }
    
    public var body: some View {
        
        VStack {
            
            Divider()
            
            VStack {
                
                Button(action: {
                    composeFeedback(attachInformation)
                }, label: {
                    Text(stringResolver.resolve("AppFeedback.action"))
                        .foregroundColor(.white)
                })
                .accessibility(identifier: "AppFeedback.actionButton")
                .buttonStyle(BlockButtonStyle(color: .blue))
                .padding(.bottom, 8)
                
                Toggle(isOn: $attachInformation, label: {
                    Text(stringResolver.resolve("AppFeedback.includeAttachmentLabel"))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(nil)
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
        
        FeedbackActionRow(composeFeedback: { _ in })
            .environmentObject(stringResolver)
            .previewLayout(.sizeThatFits)
        
        FeedbackActionRow(composeFeedback: { _ in })
            .environmentObject(stringResolver)
            .previewLayout(.sizeThatFits)
            .environment(\.colorScheme, .dark)
            .background(Color.black)
            
    }
}
