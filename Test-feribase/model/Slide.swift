//
//  Slide.swift
//  Test-feribase
//
//  Created by Baxtiyor on 15/09/22.
//

import Foundation

struct Slide {
    let imageName: String
    let title: String
    let discription: String
    
    static let collection: [Slide] = [
        Slide(imageName: "imSlide1" , title: "Welcome to the Bsuir!", discription: "BsuirNav help tou to travel around university"),
        Slide(imageName: "imSlide2" , title: "Connect Socially", discription: "Connect across"),
        Slide(imageName: "imSlide3" , title: "Safe and Source", discription: "Each trip is planned according to the strictest safitystandarts"),
    ]
}
