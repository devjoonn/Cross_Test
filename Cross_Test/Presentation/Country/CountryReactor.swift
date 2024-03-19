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
            // API 호출 결과에서 DB에 저장된 국가, 저장되지 않은 국가
            let bookmarkedCountries = result.data.countryConfigure.filter { !checkBookmarkedCountry(country: $0).isEmpty }
            let unbookmarkedCountries = result.data.countryConfigure.filter { checkBookmarkedCountry(country: $0).isEmpty }
            
            // 저장된 국가들을 날짜순으로 정렬
            let sortedBookmarkedCountries = sortCountryByDate(bookmarkedCountries: bookmarkedCountries)
            let sortedCountries = sortedBookmarkedCountries + unbookmarkedCountries
            action.onNext(.getCountries(sortedCountries))
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
    
    func sortCountryByDate(bookmarkedCountries: [CountryConfigure]) -> [CountryConfigure] {
        let sortedCountries = realm.objects(Country.self).sorted(byKeyPath: "date")
        var sortedBookmarkedCountries: [CountryConfigure] = []
        
        for sortedCountry in sortedCountries {
            // DB 날짜 순 정렬된 국가와 API 호출 시 DB에 저장되어 분류된 국가의 이름을 비교하여 매칭된 CountryConfigure를 저장해 return
            if let matchedCountry = bookmarkedCountries.first(where: { $0.name == sortedCountry.name }) {
                sortedBookmarkedCountries.append(matchedCountry)
            }
        }
        
        return sortedBookmarkedCountries
    }
}
