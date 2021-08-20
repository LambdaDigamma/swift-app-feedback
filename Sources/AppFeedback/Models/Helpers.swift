//
//  Helpers.swift
//  
//
//  Created by Lennart Fischer on 20.08.21.
//

import Foundation
import OSLog

extension OSLog {
    
    internal static let feedback = OSLog(
        subsystem: Bundle.main.bundleIdentifier ?? "com.lambdadigamma.app-feedback",
        category: "AppFeedback"
    )
    
}

#if canImport(UIKit)

import UIKit
import SwiftUI

extension UIViewController {
    
    /// Add a SwiftUI `View` as a child of the input `UIView`.
    /// - Parameters:
    ///   - swiftUIView: The SwiftUI `View` to add as a child.
    ///   - view: The `UIView` instance to which the view should be added.
    internal func addSubView<Content>(_ swiftUIView: Content, to view: UIView) where Content : View {
        let hostingController = UIHostingController(rootView: swiftUIView)
        
        addChild(hostingController)
        
        view.addSubview(hostingController.view)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            view.bottomAnchor.constraint(equalTo: hostingController.view.bottomAnchor),
            view.rightAnchor.constraint(equalTo: hostingController.view.rightAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        hostingController.didMove(toParent: self)
    }
    
}

#endif
