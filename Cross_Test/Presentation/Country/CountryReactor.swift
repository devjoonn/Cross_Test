//
//  CountryReactor.swift
//  Cross_Test
//
//  Created by 박현준 on 3/18/24.
//

import UIKit

import ReactorKit
import RxSwift
import RealmSwift

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
    let realm: Realm
    private let countryUseCase: CountryUseCase
    
    
    init(countryUseCase: CountryUseCase) {
        self.countryUseCase = countryUseCase
        self.initialState = State()
        self.realm = try! Realm()
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
    
    @MainActor
    func fetchCountries() {
        Task {
            let result = try await countryUseCase.getCountries()
            var countries: [CountryConfigure] = []
            var bookmarkedCountries: [CountryConfigure] = []
            
            for country in result.data.countryConfigure {
                if checkBookmarkedCountry(country: country).isEmpty {
                    countries.append(country)
                } else {
                    bookmarkedCountries.append(country)
                }
            }
            
            bookmarkedCountries.append(contentsOf: countries)
            action.onNext(.getCountries(bookmarkedCountries))
        }
    }
    
    func bookmarkCountry(country: CountryConfigure) {
        let checkedCountryData = checkBookmarkedCountry(country: country)
        
        if checkedCountryData.isEmpty {
            // realm 즐겨찾기 데이터 추가
            let newCountry = Country()
            newCountry.name = country.name
            newCountry.platformId = country.platformID
            newCountry.sendingAmount = 1000000
            newCountry.date = Date()
            
            try! realm.write {
                realm.add(newCountry)
            }
            // 데이터 삭제
        } else {
            try! realm.write {
                realm.delete(checkedCountryData)
            }
        }
    }
    
    func checkBookmarkedCountry(country: CountryConfigure) -> Results<Country> {
        return realm.objects(Country.self).filter("name = '\(country.name)'")
    }
}
