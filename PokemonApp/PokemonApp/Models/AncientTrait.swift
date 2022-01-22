//
//  AncientTrait.swift
//  PokemonApp
//
//  Created by Emre on 18.01.2022.
//

import Foundation
import RealmSwift

class AncientTrait: Object, Decodable {

    @objc dynamic var name: String?
    @objc dynamic var text: String?

}
