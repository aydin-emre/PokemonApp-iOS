//
//  CardView.swift
//  NewsApp
//
//  Created by Emre on 26.12.2021.
//

import UIKit
import SDWebImage

class CardView: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var heartImageView: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

    func heartEffect(_ isFavorite: Bool) {
        heartImageView.isHidden = false
        heartImageView.layer.opacity = isFavorite ? 1 : 0
        UIView.animate(withDuration: 1.3, delay: 0, options: .curveEaseOut) {
            self.heartImageView.layer.opacity = isFavorite ? 0 : 1
        } completion: { _ in
            self.heartImageView.isHidden = true
        }
    }

}
