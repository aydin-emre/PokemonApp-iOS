//
//  Ability.swift
//  PokemonApp
//
//  Created by Emre on 18.01.2022.
//

import Foundation
import RealmSwift

class Ability: Object, Decodable {

    @objc dynamic var name: String?
    @objc dynamic var text: String?
    dynamic var type: TypeEnum?

}

// MARK: - TypeEnum
enum TypeEnum: String, Codable {
    case ability = "Ability"
    case pokeBody = "Poké-Body"
    case pokePower = "Poké-Power"
}
