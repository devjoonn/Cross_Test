//
//  SceneDelegate.swift
//  Cross_Test
//
//  Created by 박현준 on 3/18/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        let countryRepository = CountryRepository()
        let countryUseCase = CountryUseCaseImp(countryRepository: countryRepository)
        let countryReactor = CountryReactor(countryUseCase: countryUseCase)
        let countryViewController = CountryViewController(reactor: countryReactor)
        window?.rootViewController = UINavigationController(rootViewController: countryViewController)
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }
}
