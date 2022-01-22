//
//  Attack.swift
//  PokemonApp
//
//  Created by Emre on 18.01.2022.
//

import Foundation
import RealmSwift

class Attack: Object, Decodable {

    let cost = List<String>()
    @objc dynamic var name: String?
    @objc dynamic var text: String?
    @objc dynamic var damage: String?
    dynamic var convertedEnergyCost: Int?

}
