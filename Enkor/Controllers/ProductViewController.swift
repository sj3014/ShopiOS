//
//  ProductViewController.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/20.
//

import UIKit
import RxSwift

enum CategoryItems: String, CaseIterable {
    case FoodDelivery
    case MealBox
    case Necessity
    case Cosmetic
    case Snack
    case Beverage
    
    func title() -> String {
        return self.rawValue
    }
}

class ProductViewController: ReactiveViewController, ErrorDisplayable {
    var errorMessage: Observable<String>? {
        return productViewModel.errorMessage.asObservable()
    }
    var authError: Observable<Void>? {
        return productViewModel.authError.asObservable()
    }

    @IBOutlet weak var categoryItemCollectionView: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    let productViewModel = ProductViewModel(apiClient: ProductAPI(provider: nil))
    var categories = ["FoodDelivery", "MealBox", "Necessity", "Cosmetic"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryItemCollectionView.register(CategoryItemCollectionViewCell.nib(), forCellWithReuseIdentifier: CategoryItemCollectionViewCell.identifier)
        categoryItemCollectionView.delegate = self
        categoryItemCollectionView.dataSource = self
        let indexPath = IndexPath(item: 0, section: 0)
        categoryItemCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .init())
        
        categoryCollectionView.register(CategoryCollectionViewCell.nib(), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        self.navigationItem.title = "Enkor Market"
        
        bind()
    }
    
    func bind() {
        bindAuthError()
        bindErrorMessageDisplay()
    }
    
    func scrollToCategoryItemIndex(itemIndex: Int) {
        let indexPath = IndexPath(item: itemIndex, section: 0)
        categoryCollectionView.scrollToItem(at: indexPath, at: .init(), animated: false)
        categoryLabel.text = categories[itemIndex]
    }
}

extension ProductViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.categoryItemCollectionView {
            self.scrollToCategoryItemIndex(itemIndex: indexPath.item)
        } else {
            
        }
    }
}

extension ProductViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.categoryItemCollectionView {
            return categories.count
        } else {
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.categoryItemCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryItemCollectionViewCell", for: indexPath) as! CategoryItemCollectionViewCell
            cell.configure(categoryName: categories[indexPath.item])
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
            cell.configure(with: categories[indexPath.item])
            
            cell.delegate = self
            return cell
        }
    }
}

extension ProductViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.categoryItemCollectionView {
            let width = view.frame.width / 4
            return CGSize(width: width, height: categoryItemCollectionView.frame.height)
        } else {
            let width = view.frame.width
            return CGSize(width: width, height: categoryCollectionView.frame.height)
        }
    }
}

extension ProductViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        self.categoryItemCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .init())
        self.categoryLabel.text = categories[Int(index)]
    }
}

extension ProductViewController: CategoryCollectionViewCellDelegate {
    
    func didSelectProduct(productID: Int) {
        let vc = Storyboard.Market.create(withIdentifier: "ProductDetail") as! ProductDetailViewController
        vc.productID = productID
        navigationController?.pushViewController(vc, animated: true)
    }
}
