//
//  CountryFactory.swift
//  Cross_Test
//
//  Created by 박현준 on 3/19/24.
//

import UIKit

protocol CountryFactory {
    func createCountryViewController(coordinator: CountryCoordinator) -> UIViewController
    func createCurrencyViewController(country: CountryConfigure, coordinator: CountryCoordinator) -> UIViewController
}

struct CountryFactoryImp: CountryFactory {
    func createCountryViewController(coordinator: CountryCoordinator) -> UIViewController {
        let countryRepository = CountryRepository()
        let countryUseCase = CountryUseCaseImp(countryRepository: countryRepository)
        let countryReactor = CountryReactor(countryUseCase: countryUseCase)
        let countryViewController = CountryViewController(reactor: countryReactor, coordinator: coordinator)
        return countryViewController
    }
    
    func createCurrencyViewController(country: CountryConfigure, coordinator: CountryCoordinator) -> UIViewController {
        return CurrencyViewController()
    }
}
