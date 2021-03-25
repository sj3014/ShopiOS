//
//  ProductDetailViewController.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/23.
//

import UIKit
import RxSwift

class ProductDetailViewController: ReactiveViewController, ErrorDisplayable {
    var errorMessage: Observable<String>? {
        return viewModel.errorMessage.asObservable()
    }
    
    var authError: Observable<Void>? {
        return viewModel.authError.asObservable()
    }
    
    
    @IBOutlet weak var productImageCollectionView: UICollectionView!
    @IBOutlet weak var suggestedCollectionView: UICollectionView!
    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productOption: UITextField!
    @IBOutlet weak var orderQuantity: UITextField!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var shippingFee: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    
    let viewModel = ProductDetailViewModel(apiClient: ProductAPI(provider: nil))
    
    var productID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productImageCollectionView.delegate = self
        productImageCollectionView.dataSource = self
        productImageCollectionView.register(ProductDetailImageCollectionViewCell.nib(), forCellWithReuseIdentifier: ProductDetailImageCollectionViewCell.identifier)
        
        suggestedCollectionView.delegate = self
        suggestedCollectionView.dataSource = self
        suggestedCollectionView.register(ProductDetailSuggestedCollectionViewCell.nib(), forCellWithReuseIdentifier: ProductDetailSuggestedCollectionViewCell.identifier)
        
        viewModel.fetchProductDetail(productID: productID ?? 1)
        
        bind()
    }
    
    func bind() {
        bindAuthError()
        bindErrorMessageDisplay()
        
        viewModel
            .fetchedProductDetail
            .subscribe(onNext: { [weak self] _ in
                guard let productDetail = self?.viewModel.productDetail else {
                    return
                }
                self?.setupUI(productDetail: productDetail)
                self?.productImageCollectionView.reloadData()
                self?.suggestedCollectionView.reloadData()
            })
            .disposed(by: disposeBag)
        
    }
    
    func setupUI(productDetail: Product) {
        if productDetail.name != "" {
            productName.text = productDetail.name
            price.text = "Product $ \(productDetail.productOptions?[0].price ?? "0.00")"
            shippingFee.text = "Shipping $ \(productDetail.deliveryFee ?? "0.00")"
        }
    }
}

extension ProductDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.productImageCollectionView {
            return viewModel.productDetail.productImages?.count ?? 0
        } else {
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.productImageCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductDetailImageCollectionViewCell", for: indexPath) as! ProductDetailImageCollectionViewCell
            
            let detail = viewModel.productDetail
            let width = collectionView.frame.width
            let height = collectionView.frame.height
            
            cell.configure(imageLocation: detail.productImages?[indexPath.item].location ?? "", width: width, height: height)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductDetailSuggestedCollectionViewCell", for: indexPath) as! ProductDetailSuggestedCollectionViewCell
            
            return cell
        }
    }
}

extension ProductDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.productImageCollectionView {
            let width = collectionView.frame.width
            let height = collectionView.frame.height
        
            return CGSize(width: width, height: height)
        } else {
            let width = collectionView.frame.width
            let height = collectionView.frame.height
        
            return CGSize(width: width, height: height - 10)
        }
    }
}
