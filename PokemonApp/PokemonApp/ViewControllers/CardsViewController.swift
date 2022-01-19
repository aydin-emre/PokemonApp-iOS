//
//  CardsViewController.swift
//  PokemonApp
//
//  Created by Emre on 18.01.2022.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift

class CardsViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    let cardsViewModel = CardsViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupBindings()
        cardsViewModel.requestData()
    }

    func setupBindings() {
        // Error Handling
        cardsViewModel
            .error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { error in
                self.alert.setMessage(error)
                self.alert.show()
            })
            .disposed(by: disposeBag)

        // Cards CollectionView
        cardsViewModel
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
    }
}
