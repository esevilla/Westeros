//
//  RepositoryTests.swift
//  WesterosTests
//
//  Created by Estefania Sevilla on 13/06/2019.
//  Copyright © 2019 Estefania Sevilla. All rights reserved.
//

import XCTest
@testable import Westeros

class RepositoryTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }
    
    func testLocalRepositoryExistence() {
        XCTAssertNotNil(Repository.local)
    }
    
    func testLocalFactoryHasHouses() {
        let houses = Repository.local.houses
        XCTAssertNotNil(houses)
    }
    
    func testLocalFactoryHasTheCorrectHouseCount() {
        let houses = Repository.local.houses
        XCTAssertEqual(houses.count, 3)
    }
    
    func testLocalRepositoryReturnsSortedArrayOfHouses() {
        let houses = Repository.local.houses
        XCTAssertEqual(houses, houses.sorted())
    }
    
    func testLocalRepositoryReturnsHouseByNameCaseInsensitively() {
        let stark = Repository.local.house(named: "Stark")
        XCTAssertNotNil(stark)
        
        let lannister = Repository.local.house(named: "lAnniStEr")
        XCTAssertNotNil(lannister)
        
        let keepcoding = Repository.local.house(named: "Keepcoding")
        XCTAssertNil(keepcoding)
    }
    
    func testLocalRepositoryHouseFiltering() {
        let filteredHouseList = Repository.local.houses(filteredBy: { house in
            house.count == 1 // true or false
        })

        XCTAssertEqual(filteredHouseList.count, 1)
        
        let wordsFilter = { (house: House) -> Bool in
            house.words == "Se acerca el verano"
        }
        
        let list = Repository.local.houses(filteredBy: wordsFilter)
        XCTAssertEqual(list.count, 0)
    }
    
    func testLocalFactoryHasSeasons() {
        let seasons = Repository.local.seasons
        XCTAssertNotNil(seasons)
    }
    
    func testLocalFactoryHasTheCorrectSeasonCount() {
        let seasons = Repository.local.seasons
        XCTAssertEqual(seasons.count, 8)
    }
    
    func testLocalRepositoryReturnsSortedArrayOfSeasons() {
        let seasons = Repository.local.seasons
        XCTAssertEqual(seasons, seasons.sorted())
    }
    
    func testLocalRepositorySeasonFiltering() {
        let filteredSeasonList = Repository.local.seasons(filteredBy: { season in
            season.count == 2 // true or false
        })
        
        XCTAssertEqual(filteredSeasonList.count, 8)
        
        let nameFilter = { (season : Season) -> Bool in
            season.name == "Temporada 1"
        }
        
        let list = Repository.local.seasons(filteredBy: nameFilter)
        XCTAssertEqual(list.count, 1)
    }
}
