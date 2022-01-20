//
//  Ability.swift
//  PokemonApp
//
//  Created by Emre on 18.01.2022.
//

import Foundation

struct Ability: Codable {

    let name, text: String?
    let type: TypeEnum?

}

// MARK: - TypeEnum
enum TypeEnum: String, Codable {
    case ability = "Ability"
    case pokeBody = "Poké-Body"
    case pokePower = "Poké-Power"
}
