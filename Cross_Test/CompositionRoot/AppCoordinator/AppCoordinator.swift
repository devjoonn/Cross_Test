//
//  AppCoordinator.swift
//  Cross_Test
//
//  Created by 박현준 on 3/19/24.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    private let appFactory: AppFactory
    private var countryCoordinator: Coordinator?
    
    init(navigationController: UINavigationController, appFactory: AppFactory) {
        self.navigationController = navigationController
        self.appFactory = appFactory
    }
    
    func start() {
        countryCoordinator = appFactory.createCountryCoordinator(navigationController: navigationController)
        countryCoordinator?.start()
    }
}
