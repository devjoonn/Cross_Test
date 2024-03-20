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
        case resultCurrency(String)
    }
    
    enum Mutation {
        case resultCurrency(String)
    }
    
    struct State {
        var country: CountryConfigure
        var resultCurrency: String = ""
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
        case .resultCurrency(let currency):
            return .just(.resultCurrency(currency))
        }
    }
    
    // MARK: - Reduce
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .resultCurrency(let currency):
            newState.resultCurrency = currency
        }
        
        return newState
    }
    
    @MainActor
    func fetchCurrency() {
        Task {
            let platformId = currentState.country.platformID
            let result = try await countryUseCase.getCurrency(platformId: platformId)
            
            let formattedSendingAmount = formatNumberWithComma(result.data.sendingAmount)
            let formattedReceivingAmount = formatNumberWithComma(result.data.receivingAmount)
            let resultCurrency = "\(formattedSendingAmount) KRW = \(formattedReceivingAmount) \(result.data.currency)"
            action.onNext(.resultCurrency(resultCurrency))
        }
    }
    
    private func formatNumberWithComma(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: number)) ?? ""
    }
}
