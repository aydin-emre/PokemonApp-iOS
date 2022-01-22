//
//  FavoritesViewController.swift
//  PokemonApp
//
//  Created by Emre on 22.01.2022.
//

import UIKit
import RxSwift
import RxCocoa

class FavoritesViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupBindings()
    }

    func setupBindings() {
        DatabaseManager.shared.updateFavoritesInViewModel()

        // Cards CollectionView
        FavoriteCardsViewModel
            .shared
            .cards
            .observe(on: MainScheduler.instance)
            .bind(to: collectionView
                    .rx
                    .items(cellIdentifier: "CardsCollectionViewCell", cellType: CardsCollectionViewCell.self)) { _, element, cell in
                cell.configure(with: element)
            }
            .disposed(by: disposeBag)

        let flowLayout = UICollectionViewFlowLayout()
        let width = (view.frame.size.width/2) - 28
        let height = width*1.4 + 40
        flowLayout.itemSize = CGSize(width: width, height: height)
        collectionView.setCollectionViewLayout(flowLayout, animated: true)

        // CollectionView Selections
        collectionView
            .rx
            .modelSelected(Card.self)
            .subscribe(onNext: { [unowned self] model in
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                if let headlinesViewController = storyBoard.instantiateViewController(withIdentifier: "CardDetailViewController")
                    as? CardDetailViewController {
                    headlinesViewController.card = model
                    self.navigationController?.pushViewController(headlinesViewController, animated: true)
                }
            }).disposed(by: disposeBag)
    }

}
