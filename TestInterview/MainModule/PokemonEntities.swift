//
//  PokemonEntity.swift
//  TestInterview
//
//  Created by Jorge Angel Sanchez Martinez on 09/04/22.
//

import Foundation
import UIKit

protocol PokemonData { }

class PokemonSearch: PokemonData, Codable {
    var count: Int
    var next: String
    var previous: String?
    var results: [Pokemon] = []
}


class PokemonModel: PokemonData, Codable {
    var id: Int
    var name: String
    var baseExperience: Int
    var sprites: Sprite?
    var stats: [Stat] = []
    var types: [PokemonType] = []
    var firstType: PokemonTypes? {
        PokemonTypes(rawValue: types.first?.type?.name ?? "")
    }
    
    var frontUrlImage: URL? {
        sprites?.frontDefault.url
    }
    var shinyUrlImage: URL? {
        sprites?.shinyDefault.url
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case baseExperience = "base_experience"
        case sprites
        case stats
        case types
    }
}

class PokemonType: Codable {
    var slot: Int
    var type: PokemonInfoType?
}

class PokemonInfoType: Codable {
    var name: String
    var url: String
}

class Stat: Codable {
    var baseStat: Int
    var effort: Int
    var stat: StatData?
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort
        case stat = "stat"
    }
}

class StatData: Codable {
    var name: String
    var url: String
}

class Sprite: Codable {
    var frontDefault: String
    var shinyDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case shinyDefault = "front_shiny"
    }
}

class PokemonTypeModel: Codable {
    var name: String
    var pokemon: [PokemonInfo]
}

class PokemonInfo: PokemonData, Codable {
    var pokemon: Pokemon?
    var slot: Int
}

class Pokemon: PokemonData, Codable {
    var name: String
    var urlString: String
    var pokemonId: Int {
        Int(urlString.url?.lastPathComponent ?? "0") ?? 0

    }
    var urlImage: URL? {
        if let urlPokemon = urlString.url {
            let idPokemon = urlPokemon.lastPathComponent
            let urlImageString = String(format: UrlString.urlImage, idPokemon)
            guard let url = urlImageString.url else {
                return nil
            }
            return url
        }
        return nil
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case urlString = "url"
    }
}


enum PokemonTypes: String, CaseIterable {
    case normal
    case fire
    case water
    case electric
    case grass
    case ice
    case fighting
    case poison
    case ground
    case flying
    case psychic
    case bug
    case rock
    case ghost
    case dragon
    case dark
    case steel
    case fairy
    
    var color: UIColor {
        switch self {
        case .normal:
            return UIColor.lightGray
        case .fire:
            return UIColor.red
        case .water:
            return UIColor.blue
        case .electric:
            return UIColor.yellow
        case .grass:
            return UIColor.green
        case .ice:
            return UIColor.blue
        case .fighting:
            return UIColor.brown
        case .poison:
            return UIColor.purple
        case .ground:
            return UIColor.systemBrown
        case .flying:
            return UIColor.purple
        case .psychic:
            return UIColor.red
        case .bug:
            return UIColor.green
        case .rock:
            return UIColor.brown
        case .ghost:
            return UIColor.systemPurple
        case .dragon:
            return UIColor.purple
        case .dark:
            return UIColor.brown
        case .steel:
            return UIColor.gray
        case .fairy:
            return UIColor.systemPink
        }
    }
}
