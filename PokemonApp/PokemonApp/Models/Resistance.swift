//
//  Resistance.swift
//  PokemonApp
//
//  Created by Emre on 18.01.2022.
//

import Foundation
import RealmSwift

class Resistance: Object, Decodable {

    @objc dynamic var type: String?
    @objc dynamic var value: String?

}
