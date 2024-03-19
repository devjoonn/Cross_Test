//
//  CountryRepository.swift
//  Cross_Test
//
//  Created by 박현준 on 3/19/24.
//

import Foundation
import Moya

struct CountryRepository: CountryRepositoryInterface {

    let provider = MoyaProvider<CountryService>(plugins: [NetworkLogger()])
    
    func getCountries() async throws -> CountryListResponse {
        let result = await provider.request(.getCountries)
        
        switch result {
        case .success(let response):
            return try decode(data: response.data)
        case .failure(let error):
            throw error
        }
    }
    
    func getCurrency(platformId: Int) async throws -> CurrencyResponse {
        let result = await provider.request(.getCurrency(platformId: platformId))
        
        switch result {
        case .success(let response):
            return try decode(data: response.data)
        case .failure(let error):
            throw error
        }
    }
}
