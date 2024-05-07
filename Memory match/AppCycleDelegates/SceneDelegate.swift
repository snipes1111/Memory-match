//
//  SceneDelegate.swift
//  Memory match
//
//  Created by user on 03/05/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        let rootVC = LaunchViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        window.rootViewController = navVC
        window.backgroundColor = .white
        window.makeKeyAndVisible()
        self.window = window
    }
}

