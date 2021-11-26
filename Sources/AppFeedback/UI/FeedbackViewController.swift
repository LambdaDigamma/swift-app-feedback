//
//  FeedbackViewController.swift
//  
//
//  Created by Lennart Fischer on 20.08.21.
//

#if os(iOS)

import UIKit
import MessageUI
import OSLog

public class FeedbackViewController: UIViewController {
    
    private let logger: Logger = Logger(OSLog.feedback)
    private let configuration: FeedbackConfiguration
    private let stringResolver: StringResolver
    private let feedbackDataCollector: FeedbackDataCollecting
    
    public init(
        configuration: FeedbackConfiguration,
        feedbackDataCollector: FeedbackDataCollecting = FeedbackDataCollector(),
        stringResolver: StringResolver = .default
    ) {
        self.configuration = configuration
        self.feedbackDataCollector = feedbackDataCollector
        self.stringResolver = stringResolver
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()

        self.title = stringResolver.resolve("AppFeedback.title")
        self.setupUI()

    }

    // MARK: - UI

    /// Adds the user interface to the view controller
    /// and hooks up the actions.
    /// You may override this to provide a different user interface.
    open func setupUI() {
        
        let view = FeedbackView(
            configuration: configuration,
            stringResolver: stringResolver,
            onComposeFeedback: showFeedbackComposer,
            onRateAppStore: openReview
        )
        
        self.addSubView(view, to: self.view)

    }

    // MARK: - Actions

    /// Show the message user interface with the attached information
    /// if the user decided to provide it.
    /// You may override this to use another messaging interface.
    open func showFeedbackComposer(attachInformation: Bool) {

        if !MFMailComposeViewController.canSendMail() {
            showNoMailConfigured()
            return logger.info("Mail services are not available")
        }
        
        let composeController = MFMailComposeViewController()
        composeController.mailComposeDelegate = self
        composeController.navigationBar.tintColor = .systemBlue
        composeController.setToRecipients(configuration.receivers)
        composeController.setSubject(configuration.subject)
        
        if #available(iOS 15.0, *) {
            
            do {
                let logCollector = try LogCollector()
                
                if let url = try logCollector.collect()  {
                    let data = try Data(contentsOf: url)
                    composeController.addAttachmentData(data, mimeType: "application/json", fileName: "Activity.feedback")
                }
                
            } catch {
                
                print("data collection failed")
                print(error.localizedDescription)
                
            }
            
        }
        
        if attachInformation {
            composeController.setMessageBody(collectSystemInformation(), isHTML: false)
        }
        
        self.present(composeController, animated: true, completion: nil)

    }
    
    /// Shows an alert that no mail account is configured on this device.
    /// You may override this to present a different alert.
    open func showNoMailConfigured() {

        let alert = UIAlertController(
            title: stringResolver.resolve("AppFeedback.noMailAlertTitle"),
            message: stringResolver.resolve("AppFeedback.noMailAlertMessage"),
            preferredStyle: .alert
        )

        let action = UIAlertAction(
            title: stringResolver.resolve("AppFeedback.okay"),
            style: .default,
            handler: nil
        )

        alert.addAction(action)

        self.present(alert, animated: true, completion: nil)

    }
    
    /// Opens the App Store page of the app with a flag
    /// to prompt for a review.
    /// You may override this to show something different.
    open func openReview() {
        
        guard configuration.showReview, let appStoreID = configuration.appStoreID else {
            return logger.error("Review is not enabled or app store id is missing.")
        }
        
        let appStorePage = AppStorePage(id: appStoreID)
        
        appStorePage.openReview()
        
    }
    
    // MARK: - Helpers
    
    open func collectSystemInformation() -> String {
        
        return feedbackDataCollector.collect()
            .joined(separator: "\n")
        
    }
    
}

extension FeedbackViewController: MFMailComposeViewControllerDelegate {
    
    public func mailComposeController(
        _ controller: MFMailComposeViewController,
        didFinishWith result: MFMailComposeResult,
        error: Error?
    ) {
        
        if let error = error {
            print(error.localizedDescription)
        }
        
        controller.dismiss(animated: true, completion: nil)
        
    }
    
}


#endif
