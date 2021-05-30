//
//  HomeViewController.swift
//  Enkor
//
//  Created by Seong Moon Jo on 2021/03/20.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var carouselCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    let carousels = [UIImage(named: "banner1"),
                     UIImage(named: "banner2"),
                     UIImage(named: "banner3"),
                     UIImage(named: "banner4"),
                     UIImage(named: "banner5")]
    
    var timer = Timer()
    var counter = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCarousel()
        
        if (AppConfigure.shared.buildPhase?.rawValue == "Debug") {
            self.navigationItem.title = "Enkor Development"
        } else {
            self.navigationItem.title = "Enkor"
        }
    }
    
    func setupCarousel() {
        carouselCollectionView.delegate = self
        carouselCollectionView.dataSource = self
        carouselCollectionView.register(CarouselCollectionViewCell.nib(), forCellWithReuseIdentifier: CarouselCollectionViewCell.identifier)
        pageControl.numberOfPages = carousels.count
        pageControl.currentPage = 0
        
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(changeImage), userInfo: nil, repeats: true)
    }
    
    @objc func changeImage() {
        if counter < carousels.count {
            let index = IndexPath(item: counter, section: 0)
            carouselCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = counter
            counter += 1
        } else {
            counter = 0
            let index = IndexPath(item: counter, section: 0)
            carouselCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            pageControl.currentPage = counter
            counter = 1
        }
    }
    
    
    @IBAction func tapFoodDelivery(_ sender: Any) {
        let vc = Storyboard.Market.create(withIdentifier: "Market")
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carousels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCollectionViewCell", for: indexPath) as! CarouselCollectionViewCell
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        cell.configure(image: carousels[indexPath.item]!, width: width, height: height)
        return cell
    }
    
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        return CGSize(width: width, height: carouselCollectionView.frame.height)
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        pageControl.currentPage = Int(index)
        counter = Int(index) + 1
    }
}
