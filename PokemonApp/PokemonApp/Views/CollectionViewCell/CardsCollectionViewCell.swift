//
//  CardsCollectionViewCell.swift
//  PokemonApp
//
//  Created by Emre on 19.01.2022.
//

import UIKit
import SDWebImage

class CardsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    private var card: Card?

    func configure(with card: Card) {
        self.card = card
        DispatchQueue.global(qos: .background).async {
            if let imageURL = card.imageURL,
               let url = URL(string: imageURL) {
                DispatchQueue.main.async {
                    self.imageView.sd_setImage(with: url, completed: nil)
                }
            }
        }
        titleLabel.text = card.name
    }

}
