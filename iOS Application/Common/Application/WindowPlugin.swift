//
//  WindowPlugin.swift
//  NewsReader
//
//  Created by Basem Emara on 2019-11-21.
//

import UIKit
import SwiftUI
import NewsCore

final class WindowPlugin {
    private weak var delegate: ScenePluggableDelegate?
    private let log: LogWorkerType
    
    init(for delegate: ScenePluggableDelegate, log: LogWorkerType) {
        self.delegate = delegate
        self.log = log
    }
}

// MARK: - Events

extension WindowPlugin: ScenePlugin {
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = scene as? UIWindowScene else { return }
        
        // Build and assign main window
        delegate?.window = UIWindow(windowScene: scene)
        defer { delegate?.window?.makeKeyAndVisible() }
        
        // Handle deep link if applicable
        if let userActivity = connectionOptions.userActivities.first(where: { $0.activityType == NSUserActivityTypeBrowsingWeb }),
            let webpageURL = userActivity.webpageURL
        {
            log.info("Link passed to app: \(webpageURL.absoluteString)")
            set(rootViewTo: delegate?.composer.fetch(for: webpageURL))
            return
        }
        
        // Assign default view
        set(rootViewTo: delegate?.composer.launchMain())
    }
}

extension WindowPlugin {
    
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
            let webpageURL = userActivity.webpageURL else {
                return
        }
        
        log.info("Link passed to app: \(webpageURL.absoluteString)")
        set(rootViewTo: delegate?.composer.fetch(for: webpageURL))
    }
}

// MARK: - Helpers

private extension WindowPlugin {
    
    func set<T: View>(rootViewTo view: T) {
        delegate?.window?.rootViewController = UIHostingController(
            rootView: view
        )
    }
}
