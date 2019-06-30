//
//  Repository.swift
//  Westeros
//
//  Created by Estefania Sevilla on 13/06/2019.
//  Copyright © 2019 Estefania Sevilla. All rights reserved.
//

import UIKit

final class Repository {
    static let local = LocalFactory()
}

protocol HouseFactory {
    var houses: [House] { get }
    typealias HouseFilter = (House) -> Bool  // (Tipo param) -> Tipo return
    
    func house(named: String) -> House?
    func houses(filteredBy: HouseFilter) -> [House]
}

protocol SeasonFactory {
    typealias SeasonFilter = (Season) -> Bool
    var seasons: [Season] { get }
    
    func seasons(filteredBy: SeasonFilter) -> [Season]
}

enum HouseNames: String {
    case Stark = "Stark"
    case Lannister = "Lannister"
    case Targaryen = "Targaryen"
}

final class LocalFactory: HouseFactory, SeasonFactory {

    var houses: [House] {
        
        // Me creo las casas
        let starkSigil = Sigil(description: "Lobo Huargo", image: UIImage(named: "stark")!)
        let lannisterSigil = Sigil(description: "León Rampante", image: UIImage(named: "lannister")!)
        let targaryenSigil = Sigil(description: "Dragón tricéfalo", image: UIImage(named: "targaryen")!)
        
        let starkURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!
        let lannisterURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!
        let targaryenURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Targaryen")!
        
        let lannisterHouse = House(
            name: "Lannister",
            sigil: lannisterSigil,
            words: "Oye mi rugido",
            url: lannisterURL
        )
        
        let starkHouse = House(
            name: "Stark",
            sigil: starkSigil,
            words: "Se acerca el invierno",
            url: starkURL
        )
        
        let targaryenHouse = House(
            name: "Targaryen",
            sigil: targaryenSigil,
            words: "Fuego Y Sangre",
            url: targaryenURL
        )
        
        // Add characters
        let robb = Person(name: "Robb", alias: "El Joven Lobo", house: starkHouse)
        let arya = Person(name: "Arya", alias: "Nadie", house: starkHouse)
        let tyrion = Person(name: "Tyrion", alias: "El Gnomo", house: lannisterHouse)
        let jaime = Person(name: "Jaime", alias: "El Matarreyes", house: lannisterHouse)
        let cersei = Person(name: "Cersei", house: lannisterHouse)
        let dani = Person(name: "Daenerys", alias: "La Madre de Dragones", house: targaryenHouse)
        
        starkHouse.add(persons: arya, robb)
        lannisterHouse.add(persons: tyrion, jaime, cersei)
        targaryenHouse.add(person: dani)
        
        return [starkHouse, lannisterHouse, targaryenHouse].sorted()
    }
    
    func house(named name: String) -> House? {
        return houses.first { $0.name.uppercased() == name.uppercased() } // filter + first
    }
    
    func houses(filteredBy theFilter: (House) -> Bool) -> [House] {
        return houses.filter(theFilter)
    }
    
    func house(named name: HouseNames) -> House?{
        return houses.first { $0.name == name.rawValue }
    }
    
    
    var seasons: [Season] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        // MARK: Creación de las temporadas con sus episodios
        
        // Episodios de la temporada 1
        let ep1x1 = Episode (name: "Winter Is Coming", releaseDate: dateFormatter.date(from: "17-04-2011")!)
        let ep1x2 = Episode (name: "The Kingsroad", releaseDate: dateFormatter.date(from: "24-04-2011")!)
        let season1 = Season(name: "Temporada 1", releaseDate: dateFormatter.date(from: "17-04-2011")!, episodes: [ep1x1, ep1x2])
        season1.add(episode: ep1x1)
        season1.add(episode: ep1x2)
        
        // Episodios de la temporada 2
        let ep2x1 = Episode (name: "The North Remembers", releaseDate: dateFormatter.date(from: "01-04-2012")!)
        let ep2x2 = Episode (name: "The Night Lands", releaseDate: dateFormatter.date(from: "08-04-2012")!)
        let season2 = Season(name: "Temporada 2", releaseDate: dateFormatter.date(from: "01-04-2012")!, episodes: [ep2x1, ep2x2])
        season2.add(episode: ep2x1)
        season2.add(episode: ep2x2)
        
        // Episodios de la temporada 3
        let ep3x1 = Episode (name: "Valar Dohaeris", releaseDate: dateFormatter.date(from: "31-03-2013")!)
        let ep3x2 = Episode (name: "Dark Wings, Dark Words", releaseDate: dateFormatter.date(from: "07-04-2013")!)
        let season3 = Season(name: "Temporada 3", releaseDate: dateFormatter.date(from: "31-03-2013")!, episodes: [ep3x1, ep3x2])
        season3.add(episode: ep3x1)
        season3.add(episode: ep3x2)
        
        // Episodios de la temporada 4
        let ep4x1 = Episode (name: "Two Swords", releaseDate: dateFormatter.date(from: "06-04-2014")!)
        let ep4x2 = Episode (name: "The Lion and the Rose", releaseDate: dateFormatter.date(from: "13-04-2014")!)
        let season4 = Season(name: "Temporada 4", releaseDate: dateFormatter.date(from: "06-04-2014")!, episodes: [ep4x1, ep4x2])
        season4.add(episode: ep4x1)
        season4.add(episode: ep4x2)
        
        // Episodios de la temporada 5
        let ep5x1 = Episode (name: "The Wars To Come", releaseDate: dateFormatter.date(from: "12-04-2015")!)
        let ep5x2 = Episode (name: "The House of Black and White", releaseDate: dateFormatter.date(from: "19-04-2015")!)
        let season5 = Season(name: "Temporada 5", releaseDate: dateFormatter.date(from: "12-04-2015")!, episodes: [ep5x1, ep5x2])
        season5.add(episode: ep5x1)
        season5.add(episode: ep5x2)
        
        // Episodios de la temporada 6
        let ep6x1 = Episode (name: "The Red Woman", releaseDate: dateFormatter.date(from: "24-04-2016")!)
        let ep6x2 = Episode (name: "Home", releaseDate: dateFormatter.date(from: "01-05-2016")!)
        let season6 = Season(name: "Temporada 6", releaseDate: dateFormatter.date(from: "24-04-2016")!, episodes: [ep6x1, ep6x2])
        season6.add(episode: ep6x1)
        season6.add(episode: ep6x2)
        
        // Episodios de la temporada 7
        let ep7x1 = Episode (name: "Dragonstone", releaseDate: dateFormatter.date(from: "16-07-2017")!)
        let ep7x2 = Episode (name: "Stormborn", releaseDate: dateFormatter.date(from: "23-07-2017")!)
        let season7 = Season(name: "Temporada 7", releaseDate: dateFormatter.date(from: "16-07-2017")!, episodes: [ep7x1, ep7x2])
        season7.add(episode: ep7x1)
        season7.add(episode: ep7x2)
        
        // Episodios de la temporada 8
        let ep8x1 = Episode (name: "TWinterfell", releaseDate: dateFormatter.date(from: "14-04-2019")!)
        let ep8x2 = Episode (name: "A Knight of the Seven Kingdoms", releaseDate: dateFormatter.date(from: "21-04-2019")!)
        let season8 = Season(name: "Temporada 8", releaseDate: dateFormatter.date(from: "14-04-2019")!, episodes: [ep8x1, ep8x2])
        season8.add(episode: ep8x1)
        season8.add(episode: ep8x2)
        
        return [season1, season2, season3, season4, season5, season6, season7, season8].sorted()
    }
    
    func seasons(filteredBy theFilter: (Season) -> Bool) -> [Season] {
        return seasons.filter(theFilter)
    }
}
