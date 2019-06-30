//
//  House.swift
//  Westeros
//
//  Created by Estefania Sevilla on 11/06/2019.
//  Copyright © 2019 Estefania Sevilla. All rights reserved.
//

import Foundation

typealias Words = String
typealias Members = Set<Person>

final class House {
    let name: String
    let sigil: Sigil
    let words: Words
    let wikiURL: URL
    private var _members: Members
    
    init(name: String, sigil: Sigil, words: Words, url: URL) {
        self.name = name
        self.sigil = sigil
        self.words = words
        self.wikiURL = url
        _members = Members()
    }
}

extension House {
    var count: Int {
        return _members.count
    }
    
    var sortedMembers: [Person] {
        return _members.sorted()
    }
    
    func add(person: Person) {
        if self == person.house {
            _members.insert(person)
        }
    }
    
    // Funciones variádicas
    func add(persons: Person...) {
        // persons: [Person]
         persons.forEach{ add(person: $0) }
        
     //   for person in persons {
     //       add(person: person)
     //   }
    }
}

extension House {
    var proxyForEquality: String {
        return "\(name) \(words)"
    }
    
    var proxyForComparison: String {
        return name.uppercased()
    }
}

extension House: Equatable {
    static func == (lhs: House, rhs: House) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension House: Comparable {
    static func < (lhs: House, rhs: House) -> Bool {
        // alguna lógica para definir cuándo el lhs < rhs
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}
