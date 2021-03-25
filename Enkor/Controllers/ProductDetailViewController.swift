//
//  ProductDetailViewController.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/23.
//

import UIKit
import RxSwift
import DropDown

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
    @IBOutlet weak var productOption: UIButton!
    @IBOutlet weak var orderQuantity: UIButton!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var shippingFee: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    
    let viewModel = ProductDetailViewModel(apiClient: ProductAPI(provider: nil))
    
    var productID: Int?
    var selectedProductOptionDropDownIndex = -1
    var selectedQuantity = 0
    var selectedPrice = 0.00
    var selectedProductName = ""
    var productOptionDict: [Int: Int] = [:]
    
    let productOptions = DropDown()
    
    let quantityOptions: DropDown = {
        let quantityOptions = DropDown()
        quantityOptions.dataSource = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return quantityOptions
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Product Detail"
        
        productImageCollectionView.delegate = self
        productImageCollectionView.dataSource = self
        productImageCollectionView.register(ProductDetailImageCollectionViewCell.nib(), forCellWithReuseIdentifier: ProductDetailImageCollectionViewCell.identifier)
        
        suggestedCollectionView.delegate = self
        suggestedCollectionView.dataSource = self
        suggestedCollectionView.register(ProductDetailSuggestedCollectionViewCell.nib(), forCellWithReuseIdentifier: ProductDetailSuggestedCollectionViewCell.identifier)
        
        guard let productID = self.productID else { return }
        viewModel.fetchProductDetail(productID: productID)
        bind()
        setupDropDowns()
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
    
    func setupDropDowns() {
        setupChooseProductOptions()
        setupChooseQuantityOptions()
    }
    
    func setupChooseProductOptions() {
        productOptions.anchorView = productOption
        productOptions.bottomOffset = CGPoint(x: 0, y:(productOptions.anchorView?.plainView.bounds.height)!)
        productOptions.selectionAction = { [unowned self] (index: Int, item: String) in
            let optionWithPrice = item.split(separator: "$")
            productOption.setTitle(item, for: .normal)
            productOption.setTitleColor(UIColor.black, for: .normal)
            selectedProductOptionDropDownIndex = index
            selectedPrice = Double(optionWithPrice[1].dropFirst()) ?? 0.0
            selectedProductName = String(optionWithPrice[0])
            changeTotalPrice()
        }
    }
    
    func setupChooseQuantityOptions() {
        quantityOptions.anchorView = orderQuantity
        quantityOptions.bottomOffset = CGPoint(x: 0, y:(quantityOptions.anchorView?.plainView.bounds.height)!)
        quantityOptions.selectionAction = { [unowned self] (index: Int, item: String) in
            let quantity = "Quantity: \(item)"
            orderQuantity.setTitle(quantity, for: .normal)
            orderQuantity.setTitleColor(UIColor.black, for: .normal)
            selectedQuantity = index + 1
            changeTotalPrice()
        }
    }
    
    func changeTotalPrice() {
        if selectedQuantity != 0 && selectedPrice != 0.0 {
            let totalPrice = selectedPrice * Double(selectedQuantity)
            price.text = "Product $ \(totalPrice)"
        }
    }
    
    func formatPrice(price: Double) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal

        // minimum decimal digit, eg: to display 2 as 2.00
        formatter.minimumFractionDigits = 2

        // maximum decimal digit, eg: to display 2.5021 as 2.50
        formatter.maximumFractionDigits = 2

        // round up 21.586 to 21.59. But doesn't round up 21.582, making it 21.58
        formatter.roundingMode = .halfUp

        let roundedPriceString = formatter.string(for: price)

        // output "rounded price is 21.58"
        print("rounded price is \(roundedPriceString!)")
    }
    
    func setupUI(productDetail: Product) {
        if productDetail.name != "" {
            productName.text = productDetail.name
            price.text = "Product $ \(productDetail.productOptions?[0].price ?? "0.00")"
            shippingFee.text = "Shipping $ \(productDetail.deliveryFee ?? "0.00")"
            
            guard let options = productDetail.productOptions else {
                return
            }
            var optionList: [String] = []
            for i in 0..<options.count {
                guard let name = options[i].name, let price = options[i].price else {
                    continue
                }
                let nameWithPrice = "\(name) $ \(price)"
                optionList.append(nameWithPrice)
                productOptionDict[i] = options[i].id
            }
            productOptions.dataSource = optionList
        }
    }
    
    func presentAlertIfOptionNotSelected() -> Bool {
        if productOption.titleLabel?.text == "Select option" {
            let alertController = UIAlertController(title: nil,
                                                    message: "Please select option",
                                                    preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return true
        } else {
            return false
        }
    }
    
    func presentAlertIfQuantityNotSelected() -> Bool {
        if orderQuantity.titleLabel?.text == "Quantity" {
            let alertController = UIAlertController(title: nil,
                                                    message: "Please select quantity",
                                                    preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return true
        } else {
            return false
        }
    }
    
    @IBAction func tapSelectOption(_ sender: Any) {
        productOptions.show()
    }
    
    @IBAction func tapSelectQuantity(_ sender: Any) {
        quantityOptions.show()
    }
    
    @IBAction func tapAddToCart(_ sender: Any) {
        guard !presentAlertIfOptionNotSelected() else { return }
        guard !presentAlertIfQuantityNotSelected() else { return }
    }
    
    @IBAction func tapBuyNow(_ sender: Any) {
        guard !presentAlertIfOptionNotSelected() else { return }
        guard !presentAlertIfQuantityNotSelected() else { return }
        guard let productID = self.productID else { return }
        guard let productOptionID = productOptionDict[selectedProductOptionDropDownIndex] else { return }
        guard let productImages = viewModel.productDetail.productImages else { return }
        guard let productImageURL = productImages[0].location else { return }
        
        let productOptionTotalPrice = selectedPrice * Double(selectedQuantity)
        let shippingFee = Double(viewModel.productDetail.deliveryFee ?? "0.00") ?? 0.00
        let totalPrice = productOptionTotalPrice + shippingFee
        let orderDetail = OrderDetail(productID: productID, productOptionID: productOptionID, productOptionName: selectedProductName, productQuantity: selectedQuantity, productOptionTotalPrice: productOptionTotalPrice, shippingFee: shippingFee, totalPrice: totalPrice, productImageURL: productImageURL)
        let vc = Storyboard.Order.create(withIdentifier: "CommerceOrder") as! CommerceOrderViewController
        
        vc.orderDetail = orderDetail
        navigationController?.pushViewController(vc, animated: true)
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
