//
//  CountryReactor.swift
//  Cross_Test
//
//  Created by 박현준 on 3/18/24.
//

import UIKit

import ReactorKit
import RxSwift
import RxCocoa

final class CountryReactor: Reactor {
    
    enum Action {
        case getCountries([CountryConfigure])
    }
    
    enum Mutation {
        case getCountries([CountryConfigure])
    }
    
    struct State {
        var countries: [CountryConfigure] = .init()
    }
    
    var initialState: State
    private let countryUseCase: CountryUseCase
    
    
    init(countryUseCase: CountryUseCase) {
        self.countryUseCase = countryUseCase
        self.initialState = State()
    }
    
    // MARK: - Mutate
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .getCountries(let countries):
            return .just(.getCountries(countries))
        }
    }
    
    // MARK: - Reduce
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .getCountries(let countries):
            newState.countries = countries
        }
        
        return newState
    }
    
    func fetchCountries() {
        Task {
            let result = try await countryUseCase.getCountries()
            action.onNext(.getCountries(result.data.countryConfigure))
        }
    }
}
