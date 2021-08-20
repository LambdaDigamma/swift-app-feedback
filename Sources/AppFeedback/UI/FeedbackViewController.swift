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
    
    public init(
        configuration: FeedbackConfiguration,
        stringResolver: StringResolver = .default
    ) {
        self.configuration = configuration
        self.stringResolver = stringResolver
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()

    }

    // MARK: - UI

    private func setupUI() {

        self.title = stringResolver.resolve("AppFeedback.title")

        let view = FeedbackView(
            stringResolver: stringResolver,
            onComposeFeedback: showFeedbackComposer,
            onRateAppStore: openReview
        )
        
        self.addSubView(view, to: self.view)

    }

    // MARK: - Actions

    private func showFeedbackComposer(attachInformation: Bool) {

        if !MFMailComposeViewController.canSendMail() {
            showNoMailConfigured()
            return logger.info("Mail services are not available")
        }
        
        let composeController = MFMailComposeViewController()
        composeController.mailComposeDelegate = self
        composeController.navigationBar.tintColor = .systemBlue
        composeController.setToRecipients(configuration.receivers)
        composeController.setSubject(configuration.subject)
        composeController.setMessageBody(collectSystemInformation(), isHTML: false)
        
        self.present(composeController, animated: true, completion: nil)

    }

    private func collectSystemInformation() -> String {
        
        let collector = FeedbackDataCollector()
        
        let data = [
            "\n",
            collector.name,
            collector.system,
            collector.identifierForVendor,
            collector.battery
        ]
        .compactMap({ $0 })
        .joined(separator: "\n")
        
        return data
        
    }
    
    private func showNoMailConfigured() {

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
    
    private func openReview() {
        
        guard configuration.showReview, let appStoreID = configuration.appStoreID else {
            return logger.error("Review is not enabled or app store id is missing.")
        }
        
        let appStorePage = AppStorePage(id: appStoreID)
        
        appStorePage.openReview()
        
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
