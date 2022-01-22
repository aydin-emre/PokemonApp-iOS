//
//  CardDetailViewController.swift
//  PokemonApp
//
//  Created by Emre on 22.01.2022.
//

import UIKit
import SDWebImage

class CardDetailViewController: BaseViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    private lazy var favoriteBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(favoriteButtonClicked))
    }()

    var card: Card?
    public var isFavorite: Bool = false {
        didSet {
            favoriteBarButtonItem.image = isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Card Details"
        // Do any additional setup after loading the view.
        setupViews()
    }

    func setupViews() {
        guard let card = card else { return }

        self.navigationItem.rightBarButtonItem  = favoriteBarButtonItem
        DatabaseManager.shared.checkFavorites(card: card) { isFavorite in
            self.isFavorite = isFavorite
        }

        if let imageURLHiRes = card.imageURLHiRes,
           let url = URL(string: imageURLHiRes) {
            imageView.sd_setImage(with: url, placeholderImage: nil, options: .continueInBackground) { _, _, _ in
                DispatchQueue.main.async {
                    self.activityIndicator.startAnimating()
                }
            } completed: { _, _, _, _ in
                self.activityIndicator.stopAnimating()
            }
        }
        if let artist = card.artist {
            artistLabel.text = "Artist: \(artist)"
        }
        if let name = card.name {
            nameLabel.text = "Name: \(name)"
        }
    }

    @objc func favoriteButtonClicked() {
        isFavorite ? DatabaseManager.shared.removeFromFavorites(card: card) : DatabaseManager.shared.addToFavorites(card: card)
        isFavorite = !isFavorite
    }

}
