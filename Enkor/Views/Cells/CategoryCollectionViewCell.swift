//
//  CategoryCollectionViewCell.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/23.
//

import UIKit
import RxSwift

protocol CategoryCollectionViewCellDelegate: NSObject {
    func didSelectProduct(productID: Int)
}

class CategoryCollectionViewCell: UICollectionViewCell, ErrorDisplayable {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var errorMessage: Observable<String>? {
        return viewModel.errorMessage.asObservable()
    }
    var authError: Observable<Void>? {
        return viewModel.authError.asObservable()
    }
    
    var type = "FoodDelivery"
    var disposeBag = DisposeBag()
    var currentPage = 0
    let viewModel = ProductViewModel(apiClient: ProductAPI(provider: nil))
    weak var delegate: CategoryCollectionViewCellDelegate?
    
    static func nib() -> UINib {
        return UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
    }
    static let identifier = "CategoryCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(ProductCollectionViewCell.nib(), forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        bind()
    }
    
    func bind() {
        //bindAuthError()
        //bindErrorMessageDisplay()
        
        viewModel
            .fetchedProducts
            .subscribe(onNext: { [weak self] _ in
                self?.collectionView.reloadData()
                self?.viewModel.isPaginating = false
            })
            .disposed(by: disposeBag)
    }
    
    func configure(with categoryName: String) {
        self.type = categoryName
        self.currentPage = 0
        self.viewModel.fetchedProducts.accept([:])
        self.viewModel.fetchProductList(pageNum: currentPage, category: type)
        currentPage += 1
    }
}

extension CategoryCollectionViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let products = viewModel.getProducts(with: type)
        if indexPath.item < products.count {
            let product = products[indexPath.item]
            delegate?.didSelectProduct(productID: product.id ?? 1)
        }
    }
    
}

extension CategoryCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let products = viewModel.getProducts(with: type)
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
        let products = viewModel.getProducts(with: type)
        if indexPath.item < products.count {
            let product = products[indexPath.item]
            cell.configure(product: product)
        }
        
        return cell
    }
}

extension CategoryCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = frame.width / 2 - 1
        return CGSize(width: width, height: width * 1.5)
    }
}

extension CategoryCollectionViewCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (collectionView.contentSize.height - 200 - scrollView.frame.size.height) {
            guard !viewModel.isPaginating else {
                return
            }
            viewModel.fetchProductList(pageNum: currentPage, category: type)
            currentPage += 1
        }
    }
}

