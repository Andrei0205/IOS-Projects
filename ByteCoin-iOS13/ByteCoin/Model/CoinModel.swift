//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Andrei Marinescu on 27.03.2021.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
    
    let currencyRate: Double
    let currencyName: String
    var currencyRateString :String {
        String(format: "%.2f",currencyRate)
    }
    
    
   
    
}
