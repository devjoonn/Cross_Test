//
//  CountryCoordinator.swift
//  Cross_Test
//
//  Created by 박현준 on 3/19/24.
//

import UIKit

final class CountryCoordinator: Coordinator {

    var navigationController: UINavigationController
    let countryFactory: CountryFactory
    
    init(navigationController: UINavigationController, countryFactory: CountryFactory) {
        self.navigationController = navigationController
        self.countryFactory = countryFactory
    }
    
    func start() {
        let countryController = countryFactory.createCountryViewController(coordinator: self)
        navigationController.pushViewController(countryController, animated: true)
    }
}
