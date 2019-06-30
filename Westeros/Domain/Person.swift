//
//  Person.swift
//  Westeros
//
//  Created by Estefania Sevilla on 11/06/2019.
//  Copyright © 2019 Estefania Sevilla. All rights reserved.
//

import Foundation

final class Person {
    let name: String
    let house: House
    private let _alias: String? // O tiene un nil, o tiene un string
    
    var alias: String {
        return _alias ?? ""
    }
    
    var fullName: String {
        return "\(name) \(house.name)"
    }
    
    init(name: String, alias: String? = nil, house: House) {
        self.name = name
        self._alias = alias 
        self.house = house
    }
}

extension Person {
    var proxyForEquality: String {
        return "\(name) \(alias) \(house.name)"
    }
    
    var proxyForComparison: String {
        return fullName
    }
}

extension Person: Equatable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension Person: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(alias)
        hasher.combine(house.name)
    }
}

extension Person: Comparable {
    static func < (lhs: Person, rhs: Person) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}
