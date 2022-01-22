//
//  FavoriteCardsViewModel.swift
//  PokemonApp
//
//  Created by Emre on 22.01.2022.
//

import Foundation
import RxSwift
import RxCocoa

class FavoriteCardsViewModel {

    public static var shared = FavoriteCardsViewModel()
    public let cards: PublishSubject<[Card]> = PublishSubject()

}
