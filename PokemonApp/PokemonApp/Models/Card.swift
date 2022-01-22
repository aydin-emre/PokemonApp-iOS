//
//  Card.swift
//  PokemonApp
//
//  Created by Emre on 18.01.2022.
//

import Foundation
import RealmSwift

class Card: Object, Decodable {

    @objc dynamic var id: String?
    @objc dynamic var name: String?
    dynamic var nationalPokedexNumber: Int?
    @objc dynamic var imageURL: String?
    @objc dynamic var imageURLHiRes: String?
    var types = List<String>()
    @objc dynamic var supertype: String?
    @objc dynamic var subtype: String?
    @objc dynamic var hp: String?
    dynamic var retreatCost: List<String>?
    dynamic var convertedRetreatCost: Int?
    @objc dynamic var number: String?
    @objc dynamic var artist: String?
    @objc dynamic var rarity: String?
    @objc dynamic var series: String?
    @objc dynamic var cardSet: String?
    @objc dynamic var setCode: String?
    dynamic var text: List<String>?
    dynamic var attacks: List<Attack>?
    dynamic var weaknesses: List<Resistance>?
    dynamic var ability: Ability?
    @objc dynamic var evolvesFrom: String?
    dynamic var resistances: List<Resistance>?
    dynamic var ancientTrait: AncientTrait?

    enum CodingKeys: String, CodingKey {
        case id, name, nationalPokedexNumber
        case imageURL = "imageUrl"
        case imageURLHiRes = "imageUrlHiRes"
        case types, supertype, subtype, hp, retreatCost, convertedRetreatCost, number, artist, rarity, series
        case cardSet = "set"
        case setCode, text, attacks, weaknesses, ability, evolvesFrom, resistances, ancientTrait
    }

    override class func primaryKey() -> String? {
        return "id"
    }

    override class func ignoredProperties() -> [String] {
        return ["attacks", "weaknesses", "resistances"]
    }

}
