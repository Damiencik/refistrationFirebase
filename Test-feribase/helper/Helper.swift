//
//  Helper.swift
//  Test-feribase
//
//  Created by Baxtiyor on 15/09/22.
//

import Foundation

func delay(durationInSeconds: Double , completion: @escaping () -> Void){
    DispatchQueue.main.asyncAfter(deadline: .now() + durationInSeconds , execute: completion)
}


//DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
//    self.showInitialView()
