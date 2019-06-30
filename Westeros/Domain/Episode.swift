//
//  Episode.swift
//  Westeros
//
//  Created by Estefania Sevilla on 29/06/2019.
//  Copyright © 2019 Estefania Sevilla. All rights reserved.
//

import Foundation

final class Episode {
    
    let name: String
    let releaseDate: Date
    weak var season: Season?
    
    init (name: String, releaseDate: Date, season: Season? = nil){
        self.name = name
        self.releaseDate = releaseDate
        self.season = season
       // self.season?.add(episode: self)
    }
    
}

    extension Episode {
        func add(season: Season){
            if season.episodes.contains(self){
                self.season = season
            }
        }
    }

    extension Episode {
        var proxyForEquality: String {
            return "\(name) \(releaseDate)"
        }
        
        var proxyForComparison: Date {
            return releaseDate
        }
    }
    
    extension Episode: Equatable {
        static func == (lhs: Episode, rhs: Episode) -> Bool {
            return lhs.proxyForEquality == rhs.proxyForEquality
        }
    }

    extension Episode: Hashable{
        func hash(into hasher: inout Hasher) {
            hasher.combine(name)
            hasher.combine(releaseDate)
        }
    }

    extension Episode: Comparable {
        static func < (lhs: Episode, rhs: Episode) -> Bool {
            return lhs.proxyForComparison < rhs.proxyForComparison
        }
    }
    
    extension Episode: CustomStringConvertible {
        var description: String {
            let dateFormated = DateFormatter()
            dateFormated.dateFormat = "dd/MM/yyyy"
            if let season = season {
                return "\(season.name): episodio \(name), emitido en el \(dateFormated.string(from: releaseDate))"
            } else {
                return "Episodio \(name), emitido en el \(dateFormated.string(from: releaseDate))"
            }
        }
    }

