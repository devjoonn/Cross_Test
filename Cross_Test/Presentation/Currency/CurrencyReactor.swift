//
//  CurrencyReactor.swift
//  Cross_Test
//
//  Created by 박현준 on 3/20/24.
//

import UIKit

import ReactorKit
import RxSwift
import RealmSwift

final class CurrencyReactor: Reactor {
    
    enum Action {
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        var country: CountryConfigure
    }
    
    var initialState: State
    private let countryUseCase: CountryUseCase
    
    
    init(countryUseCase: CountryUseCase, country: CountryConfigure) {
        self.countryUseCase = countryUseCase
        self.initialState = State(country: country)
    }
    
    // MARK: - Mutate
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            
        }
    }
    
    // MARK: - Reduce
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
            
        }
        
        return newState
    }
}
