//
//  CountryRepositoryInterface.swift
//  Cross_Test
//
//  Created by 박현준 on 3/19/24.
//

protocol CountryRepositoryInterface {
    func getCountries() async throws -> CountryListResponse
    func getCurrency(platformId: Int) async throws -> CurrencyResponse
}
