//
//  File.swift
//  
//
//  Created by Lennart Fischer on 20.08.21.
//

import Foundation

import SwiftUI

public struct BlockButtonStyle: ButtonStyle {
    
    public var color: Color = Color.accentColor
    
    public func makeBody(configuration: BlockButtonStyle.Configuration) -> some View {
        BlockButtonView(configuration: configuration, color: color)
    }
    
    struct BlockButtonView: View {
        
        @Environment(\.isEnabled) var isEnabled
        
        let configuration: BlockButtonStyle.Configuration
        let color: Color
        
        var body: some View {
            configuration.label
                .font(.body.bold())
                .padding(14)
                .padding(.horizontal, 8)
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 8).fill(color))
                .compositingGroup()
                .opacity(configuration.isPressed ? 0.5 : 1.0)
                .opacity(!isEnabled ? 0.6 : 1.0)
        }
        
    }
    
}

struct BlockButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        
        let button = Button("Give feedback", action: {})
            .buttonStyle(BlockButtonStyle())
            .padding()
        
        Group {
            
            button
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Light, enabled")
            
            button
                .disabled(true)
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Light, disabled")
            
            button
                .environment(\.colorScheme, .dark)
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Dark, enabled")
            
            button
                .disabled(true)
                .environment(\.colorScheme, .dark)
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Dark, disabled")
            
        }
    }
}
