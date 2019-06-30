//
//  SeasonTests.swift
//  WesterosTests
//
//  Created by Estefania Sevilla on 29/06/2019.
//  Copyright © 2019 Estefania Sevilla. All rights reserved.
//

import XCTest
@testable import Westeros

class SeasonTests: XCTestCase {

    var season1: Season!
    var season2: Season!
    
    var ep1x1: Episode!
    var ep1x2: Episode!
    var ep2x1: Episode!
    var ep2x2: Episode!
    
    
    override func setUp() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        ep1x1 = Episode (name: "Winter Is Coming", releaseDate: dateFormatter.date(from: "17-04-2011")!)
        ep1x2 = Episode (name: "The Kingsroad", releaseDate: dateFormatter.date(from: "24-04-2011")!)
        season1 = Season(name: "Temporada 1", releaseDate: dateFormatter.date(from: "17-04-2011")!, episodes: [ep1x1, ep1x2])
        season1.add(episode: ep1x1)
        season1.add(episode: ep1x2)
        
        ep2x1 = Episode (name: "The North Remembers", releaseDate: dateFormatter.date(from: "01-04-2012")!)
        ep2x2 = Episode (name: "TThe Night Lands", releaseDate: dateFormatter.date(from: "08-04-2012")!)
        season2 = Season(name: "Temporada 2", releaseDate: dateFormatter.date(from: "24-04-2012")!, episodes: [ep2x1, ep2x2])
        season2.add(episode: ep2x1)
        season2.add(episode: ep2x2)
    }
    
    func testSeasonExistence() {
        XCTAssertNotNil(season1)
        XCTAssertNotNil(season2)
    }
    
    func testSeasonHasTheCorrectEpisodesCount() {
        XCTAssertEqual(season1.count, 2)
        XCTAssertEqual(season2.count, 2)
    }
    
    func testSeasonCustomStringConvertible() {
        XCTAssertNotNil(season1.description)
        XCTAssertNotNil(season2.description)
    }
    
    func testConformsToHashable() {
        XCTAssertNotNil(season1.hashValue)
    }
    
    func testSeasonEquality() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        // Identidad
        XCTAssertEqual(season1, season1)
        
        // Igualdad
        let season1Test = Season(name: "Temporada 1", releaseDate: dateFormatter.date(from: "17-04-2011")!, episodes: [ep1x1, ep1x2])
        season1Test.add(episodes: ep1x1, ep1x2)
        XCTAssertEqual(season1Test, season1)
        
        // Desigualdad
        XCTAssertNotEqual(season1, season2)
    }
    
    func testSeasonComparison() {
        XCTAssertLessThan(season1, season2)
    }
    
    func testSeasonAddEpisodesAtOnce() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let ep1x3 = Episode (name: "Lord Snow", releaseDate: dateFormatter.date(from: "01-05-2011")!)
        let ep1x4 = Episode (name: "Cripples, Bastards, and Broken Things", releaseDate: dateFormatter.date(from: "08-05-2011")!)
        season1.add(episodes: ep1x4, ep1x3)
        XCTAssertEqual(season1.count, 4)
    }
    
    func testSeasonSortedReturnsASortedListOfEpisodes() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let ep1x3 = Episode (name: "Lord Snow", releaseDate: dateFormatter.date(from: "01-05-2011")!)
        let ep1x4 = Episode (name: "Cripples, Bastards, and Broken Things", releaseDate: dateFormatter.date(from: "08-05-2011")!)
        season1.add(episodes: ep1x4, ep1x3)
        XCTAssertEqual(season1.sortedEpisodes, [ep1x1, ep1x2, ep1x3, ep1x4])
    }
    
}
