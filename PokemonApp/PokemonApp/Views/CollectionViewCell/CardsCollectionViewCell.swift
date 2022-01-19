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
//    public var isFavorite: Bool = false {
//        didSet {
//            favoriteImageView.image = isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
//        }
//    }

    override func awakeFromNib() {
        super.awakeFromNib()
//        self.addBorder()
//        self.round(masksToBounds: true)
//        rateLabel.round(radius: 22, masksToBounds: true)
//        rateLabel.addBorder(color: .white, radius: 22, borderWidth: 2)
//        favoriteContainerView.round(radius: 22, masksToBounds: true)
//        favoriteContainerView.addBorder(color: .white, radius: 22, borderWidth: 2)
//        favoriteContainerView.backgroundColor = appColor
//        favoriteContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(favoriteButtonClicked)))
    }

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

//    @objc func favoriteButtonClicked() {
//        if isFavorite {
//            DatabaseManager.shared.removeFromFavorites(movie: movie, completion: { success in
//                if success {
//                    self.isFavorite = false
//                }
//            })
//        } else {
//            DatabaseManager.shared.addToFavorites(movie: movie, completion: { success in
//                if success {
//                    self.isFavorite = true
//                }
//            })
//        }
//    }

}
