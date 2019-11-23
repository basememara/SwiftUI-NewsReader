//
//  WindowPlugin.swift
//  NewsReader iOS
//
//  Created by Basem Emara on 2019-11-21.
//

import UIKit
import SwiftUI
import NewsCore

final class WindowPlugin {
    
    // MARK: - Components
    
    private let dependency: AppDependency
    private let state: AppState
    private let composer: SceneComposer
    
    // MARK: - State
    
    private weak var delegate: ScenePluggableDelegate?
    private lazy var log: LogWorkerType = dependency.resolve()
    
    // MARK: - Lifecycle
    
    init(
        for delegate: ScenePluggableDelegate?,
        dependency: AppDependency,
        state: AppState,
        composer: SceneComposer
    ) {
        self.delegate = delegate
        self.dependency = dependency
        self.state = state
        self.composer = composer
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
            let webpageURL = userActivity.webpageURL {
                log.info("Link passed to app: \(webpageURL.absoluteString)")
                set(rootViewTo: composer.fetch(for: webpageURL, with: state))
                return
        }
        
        // Assign default view
        set(rootViewTo: composer.launchMain())
    }
}

extension WindowPlugin {
    
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
            let webpageURL = userActivity.webpageURL else {
                return
        }
        
        log.info("Link passed to app: \(webpageURL.absoluteString)")
        set(rootViewTo: composer.fetch(for: webpageURL, with: state))
    }
}

// MARK: - Helpers

private extension WindowPlugin {
    
    func set<T: View>(rootViewTo view: T) {
        delegate?.window?.rootViewController = UIHostingController(
            rootView: view
                .environmentObject(dependency)
                .environmentObject(state)
                .environmentObject(composer)
        )
    }
}
