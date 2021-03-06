//
//  CardsCollectionViewCell.swift
//  PokemonApp
//
//  Created by Emre on 19.01.2022.
//

import UIKit
import SDWebImage

class CardsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cardView: CardView!

    func configure(with card: Card) {
        if let imageURL = card.imageURL,
           let url = URL(string: imageURL) {
            self.cardView.imageView.sd_setImage(with: url, completed: nil)
        }
        cardView.titleLabel.text = card.name
    }

}
