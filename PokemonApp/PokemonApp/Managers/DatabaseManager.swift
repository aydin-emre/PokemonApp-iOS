//
//  DatabaseManager.swift
//  PokemonApp
//
//  Created by Emre on 22.01.2022.
//

import Foundation
import RealmSwift
import RxSwift
import RxCocoa

public class DatabaseManager {

    // MARK: - Shared Manager

    static var shared = DatabaseManager()
    private let global = DispatchQueue.global(qos: .background)

    func addToFavorites(card: Card?, completion: @escaping (Bool) -> Void = { _ in }) {
        global.sync {
            autoreleasepool {
                do {
                    if let realm = try? Realm(),
                       let card = card {
                        try? realm.write {
                            realm.add(card.detached())
                        }
                        DispatchQueue.main.async {
                            self.updateFavoritesInViewModel()
                            completion(true)
                        }
                    } else {
                        DispatchQueue.main.async {
                            completion(false)
                        }
                    }
                }
            }
        }
    }

    func removeFromFavorites(card: Card?, completion: @escaping (Bool) -> Void = { _ in }) {
        global.sync {
            autoreleasepool {
                do {
                    if let realm = try? Realm(),
                       let card = card {
                        if let delete = realm.objects(Card.self).filter({ $0.id == card.id }).first {
                            try? realm.write {
                                realm.delete(delete)
                            }
                            DispatchQueue.main.async {
                                self.updateFavoritesInViewModel()
                                completion(true)
                            }
                        } else {
                            DispatchQueue.main.async {
                                completion(false)
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            completion(false)
                        }
                    }
                }
            }
        }
    }

    func getFavorites(completion: @escaping ([Card]) -> Void = { _ in }) {
        global.sync {
            autoreleasepool {
                do {
                    if let realm = try? Realm() {
                        let cards = realm.objects(Card.self)
                        DispatchQueue.main.async {
                            completion(Array(cards))
                        }
                    } else {
                        DispatchQueue.main.async {
                            completion([])
                        }
                    }
                }
            }
        }
    }

    func checkFavorites(card: Card?, completion: @escaping (Bool) -> Void = { _ in }) {
        global.sync {
            autoreleasepool {
                do {
                    if let realm = try? Realm(),
                       let card = card {
                        let contains = !realm.objects(Card.self).filter({ $0.id == card.id }).isEmpty
                        DispatchQueue.main.async {
                            completion(contains)
                        }
                    } else {
                        DispatchQueue.main.async {
                            completion(false)
                        }
                    }
                }
            }
        }
    }

    func updateFavoritesInViewModel() {
        getFavorites { cards in
            FavoriteCardsViewModel
                .shared
                .cards
                .onNext(cards)
        }
    }

}
