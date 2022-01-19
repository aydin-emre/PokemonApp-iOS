//
//  CardsViewModel.swift
//  PokemonApp
//
//  Created by Emre on 19.01.2022.
//

import Foundation
import RxSwift
import RxCocoa

class CardsViewModel {

    public let cards: PublishSubject<[Card]> = PublishSubject()
    public let error: PublishSubject<String> = PublishSubject()

    public func requestData() {
        NetworkManager.shared.cards(with: 99) { result in
            switch result {
            case .success(let response):
                if let cards = response.cards {
                    self.cards.onNext(cards)
                }
            case .failure(let error):
                self.error.onNext(error.localizedDescription)
            }
        }
    }

}
