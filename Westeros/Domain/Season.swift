//
//  Season.swift
//  Westeros
//
//  Created by Estefania Sevilla on 29/06/2019.
//  Copyright © 2019 Estefania Sevilla. All rights reserved.
//

import Foundation

typealias Episodes = Set <Episode>

final class Season {
    let name: String
    let releaseDate: Date
    var episodes: Episodes
    
    
    init (name: String, releaseDate: Date, episodes: Episodes){
        self.name = name
        self.releaseDate = releaseDate
        self.episodes = episodes
    }
}

extension Season {
    var sortedEpisodes: [Episode]{
        return episodes.sorted()
    }
    
    var count: Int {
        return episodes.count
    }
    
    func add(episode: Episode){
      //  if episode.season != nil {
        //    episodes.insert(episode)
        //}
      //  guard self == episode.season else{
        //    return
        //}
        episodes.insert(episode)
    }
    
    func add(episodes: Episode...){
        episodes.forEach {
            add(episode: $0)
        }
    }
}

extension Season: CustomStringConvertible {
    var description: String {
        let dateFormated = DateFormatter()
        dateFormated.dateFormat = "dd/MM/yyyy"
        return "Temporada \(name), emitido en el \(dateFormated.string(from: releaseDate))"
    }
}

extension Season {
    var proxyForEquality: String {
        return "\(name) \(releaseDate)"
    }
    
    var proxyForComparison: Date {
        return releaseDate
    }
}

extension Season: Equatable {
    static func == (lhs: Season, rhs: Season) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension Season: Hashable{
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(releaseDate)
    }
}

extension Season: Comparable {
    static func < (lhs: Season, rhs: Season) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}



