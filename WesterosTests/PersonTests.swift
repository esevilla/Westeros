//
//  PersonTests.swift
//  WesterosTests
//
//  Created by Estefania Sevilla on 11/06/2019.
//  Copyright © 2019 Estefania Sevilla. All rights reserved.
//

import XCTest
@testable import Westeros

class PersonTests: XCTestCase {

    // Opcional explícitamente desempaquetado
    // Tiene sentido por dos cosas
    // 1. Si me olvido de darle un valor, quiero que "crashee"
    // 2: En este no controlamos cuándo se hace el init de esta clase
    
    var starkSigil: Sigil!
    var starkHouse: House!
    var lannisterSigil: Sigil!
    var lannisterHouse: House!
    var ned: Person!
    var tyrion: Person!
    
    override func setUp() {
        let starkURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!
        let lannisterURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!
        
        
        starkSigil = Sigil(description: "Lobo Huargo", image: UIImage())
        
        starkHouse = House(
            name: "Stark",
            sigil: starkSigil,
            words: "Se acerca el invierno",
            url: starkURL
        )
        
        lannisterSigil = Sigil(description: "León Rampante", image: UIImage())
        lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido", url: lannisterURL)
        
        ned = Person(name: "Eddard", alias: "Ned", house: starkHouse)
        tyrion = Person(name: "Tyrion", alias: "El gnomo", house: lannisterHouse)
    }

    override func tearDown() {
    }

    func testCharacterExistence() {
        XCTAssertNotNil(ned)
    }
    
    func testCharacterExistenceWithoutAlias() {
        
        let arya = Person(name: "Arya", house: starkHouse)
        XCTAssertNotNil(arya)
        XCTAssertEqual(arya.alias, "")
    }
    
    func testPersonFullName() {
        XCTAssertEqual(ned.fullName, "Eddard Stark")
    }
    
    func testPersonConformsToHashable() {
        XCTAssertNotNil(ned.hashValue)
    }
    
    func testPersonEquality() {
        // 1. Identidad
        XCTAssertEqual(ned, ned)
        
        // 2. Igualdad
        let eddard = Person(name: "Eddard", alias: "Ned", house: starkHouse)
        XCTAssertEqual(ned, eddard)
        
        // 3. Desigualdad
        XCTAssertNotEqual(ned, tyrion)
    }
}
