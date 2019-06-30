//
//  EpisodeTests.swift
//  WesterosTests
//
//  Created by Estefania Sevilla on 29/06/2019.
//  Copyright © 2019 Estefania Sevilla. All rights reserved.
//

import XCTest
@testable import Westeros

class EpisodeTests: XCTestCase {

    var ep1x1: Episode!
    var ep1x2: Episode!
    var ep2x1: Episode!
    var ep2x2: Episode!
    var season1: Season!
    
    override func setUp() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        ep1x1 = Episode (name: "Winter Is Coming", releaseDate: dateFormatter.date(from: "17-04-2011")!)
        ep1x2 = Episode (name: "The Kingsroad", releaseDate: dateFormatter.date(from: "24-04-2011")!)
        season1 = Season(name: "Temporada 1", releaseDate: dateFormatter.date(from: "17-04-2011")!, episodes: [ep1x1, ep1x2])
        season1.add(episode: ep1x1)
        season1.add(episode: ep1x2)
        
    }
    
    func testEpisodeExistence() {
        XCTAssertNotNil(ep1x1)
        XCTAssertNotNil(ep1x2)
    }
    
    func testEpisodeAddSeason() {
        ep1x1.add(season: season1)
        XCTAssertNotNil(ep1x1.season)
    }
    
    func testEpisodeEquality() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        // Identidad
        XCTAssertEqual(season1, season1)
        
        // Igualdad
        let episode1Test = Episode (name: "Winter Is Coming", releaseDate: dateFormatter.date(from: "17-04-2011")!)
        XCTAssertEqual(episode1Test, ep1x1)
        
        // Desigualdad
        XCTAssertNotEqual(ep1x1, ep1x2)
    }
    
    func testEpisodeConformsToHashable() {
        XCTAssertNotNil(ep1x1.hashValue)
    }
    
    func testEpisodeComparison() {
        XCTAssertLessThan(ep1x1, ep1x2)
    }
    
    func testSeasonCustomStringConvertible() {
        XCTAssertNotNil(ep1x1.description)
        XCTAssertNotNil(ep1x2.description)
    }
}
