//
//  CountryUseCase.swift
//  Cross_Test
//
//  Created by 박현준 on 3/19/24.
//

import Foundation

protocol CountryUseCase {
    func getCountries() async throws -> CountryListResponse
    func getCurrency(platformId: Int) async throws -> CurrencyResponse
}

struct CountryUseCaseImp: CountryUseCase {
    
    private(set) var countryRepository: CountryRepositoryInterface
    
    func getCountries() async throws -> CountryListResponse {
        try await countryRepository.getCountries()
    }
    
    func getCurrency(platformId: Int) async throws -> CurrencyResponse {
        try await countryRepository.getCurrency(platformId: platformId)
    }
}
