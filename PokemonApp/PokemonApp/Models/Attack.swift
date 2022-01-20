//
//  Attack.swift
//  PokemonApp
//
//  Created by Emre on 18.01.2022.
//

import Foundation

struct Attack: Codable {

    let cost: [String]?
    let name, text, damage: String?
    let convertedEnergyCost: Int?

}
