//
//  OnboardingViewController.swift
//  Test-feribase
//
//  Created by Baxtiyor on 15/09/22.
//

import UIKit

protocol OnboardingDelegate: class {
     func showMainTabController()
}

class OnboardingViewController: UIViewController{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var discriptionLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!


    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupPageControl()
        setupCollectionView()
        showCaption(atIndex: 0)
    }
    
    private func setupViews(){
        view.backgroundColor = .systemGroupedBackground
    }
    
    private func setupCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.collectionViewLayout = layout
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    private func setupPageControl(){
        pageControl.numberOfPages = Slide.collection.count
    }
    
    @IBAction func gettingStartedButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: K.Segue.showLoginSignup, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segue.showLoginSignup {
            if let destination = segue.destination as? LoginViewController {
                destination.delegate = self
            }
        }
    }
    
    private func showCaption(atIndex index: Int){
        
        let slide = Slide.collection[index]
        titleLabel.text = slide.title
        discriptionLabel.text = slide.discription
    }
}

extension OnboardingViewController: UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Slide.collection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.ReuseIdentifire.onboardingCollectionViewCell , for: indexPath) as? OnboardingCollectionViewCell else{ return UICollectionViewCell() }
        let imageName = Slide.collection[indexPath.item].imageName
        let image = UIImage(named: imageName) ?? UIImage()
        cell.configure(image: image)
        return cell
    }
 
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        showCaption(atIndex: index)
        pageControl.currentPage = index
    }
}


extension OnboardingViewController: OnboardingDelegate {
    
    func showMainTabController() {
        if let loginViewController = self.presentedViewController as? LoginViewController{
            loginViewController.dismiss(animated: true){
                PresenterManager.shared.show(vc: .mainTabBarController)
            }

        }
        
    }
}
