//
//  Card.swift
//  PokemonApp
//
//  Created by Emre on 18.01.2022.
//

import Foundation

struct Card: Codable {

    let id, name: String?
    let nationalPokedexNumber: Int?
    let imageURL, imageURLHiRes: String?
    let types: [String]?
    let supertype: String?
    let subtype: String?
    let hp: String?
    let retreatCost: [String]?
    let convertedRetreatCost: Int?
    let number, artist: String?
    let rarity: String?
    let series: String?
    let cardSet: String?
    let setCode: String?
    let text: [String]?
    let attacks: [Attack]?
    let weaknesses: [Resistance]?
    let ability: Ability?
    let evolvesFrom: String?
    let resistances: [Resistance]?
    let ancientTrait: AncientTrait?

    enum CodingKeys: String, CodingKey {
        case id, name, nationalPokedexNumber
        case imageURL = "imageUrl"
        case imageURLHiRes = "imageUrlHiRes"
        case types, supertype, subtype, hp, retreatCost, convertedRetreatCost, number, artist, rarity, series
        case cardSet = "set"
        case setCode, text, attacks, weaknesses, ability, evolvesFrom, resistances, ancientTrait
    }

}

//// MARK: - Cost
//enum Cost: String, Codable {
//    case colorless = "Colorless"
//    case darkness = "Darkness"
//    case dragon = "Dragon"
//    case fairy = "Fairy"
//    case fighting = "Fighting"
//    case fire = "Fire"
//    case grass = "Grass"
//    case lightning = "Lightning"
//    case metal = "Metal"
//    case psychic = "Psychic"
//    case water = "Water"
//}
//
//// MARK: - Supertype
//enum Supertype: String, Codable {
//    case pokemon = "Pokémon"
//}
//
//// MARK: - Subtype
//enum Subtype: String, Codable {
//    case basic = "Basic"
//    case ex = "EX"
//    case levelUp = "Level Up"
//    case mega = "MEGA"
//    case stage1 = "Stage 1"
//    case stage2 = "Stage 2"
//    case v = "V"
//    case vmax = "VMAX"
//}
