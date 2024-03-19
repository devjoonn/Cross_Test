//
//  AppFactory.swift
//  Cross_Test
//
//  Created by 박현준 on 3/19/24.
//

import UIKit

protocol AppFactory {
    func createCountryCoordinator(navigationController: UINavigationController) -> Coordinator
}

struct AppFactoryImp: AppFactory {
    func createCountryCoordinator(navigationController: UINavigationController) -> Coordinator {
        let countryFactory = CountryFactoryImp()
        let countryCoordinator = CountryCoordinator(navigationController: navigationController, countryFactory: countryFactory)
        return countryCoordinator
    }
}
