//
//  OnboardingCollectionViewCell.swift
//  Test-feribase
//
//  Created by Baxtiyor on 15/09/22.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var slideImageView: UIImageView!
        
        func configure(image: UIImage){
        slideImageView.image = image
    }
    
}
