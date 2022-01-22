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

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!

    let cardsViewModel = CardsViewModel()
    let disposeBag = DisposeBag()
    var cards = [Card]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pokemon App"
        // Do any additional setup after loading the view.
        setupBindings()
        cardsViewModel.requestData(with: 99)

        DatabaseManager.shared.getFavorites { cards in
            
        }
    }

    func setupBindings() {
        // Search TextField
        searchTextField
            .rx
            .text
            .asObservable()
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(onNext: { value in
                if let value = value,
                    value.count > 1 && value.count < 400 && value != self.cardsViewModel.searchText.value {
                    self.cardsViewModel.searchText.accept(value)
                }
            })
            .disposed(by: disposeBag)

        cardsViewModel
            .searchText
            .asObservable()
            .subscribe(onNext: { value in
                if let health = Int(value) {
                    self.cardsViewModel.requestData(with: health)
                }
            })
            .disposed(by: disposeBag)

        cardsViewModel
            .cards
            .subscribe { cards in
                self.cards = cards
            }
            .disposed(by: disposeBag)

        // Error Handling
        cardsViewModel
            .error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { error in
                self.searchTextField.text = nil
                let alert = UIAlertController(title: "Alert", message: error, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
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

        // CollectionView Long Pressed
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(collectionViewItemLongPressed))
        longPressGesture.minimumPressDuration = 0.5
        longPressGesture.delaysTouchesBegan = true
        collectionView.addGestureRecognizer(longPressGesture)
    }

    @objc func collectionViewItemLongPressed(gesture: UILongPressGestureRecognizer!) {
        guard gesture.state == .ended else { return }

        if let indexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) {
            DatabaseManager.shared.addToFavorites(card: cards[indexPath.row])
        }
    }

}
