//
//  Country.swift
//  Cross_Test
//
//  Created by 박현준 on 3/19/24.
//

import Foundation
import RealmSwift

class Country: Object {
    @Persisted(primaryKey: true) var name: String
    @Persisted var date: Date
}
