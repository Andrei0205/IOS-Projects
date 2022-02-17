//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol coinManagerDelegate {
    func didUpdateCurrency(coinModel: CoinModel)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    var delegate: coinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "77B35DFA-420B-4645-9D35-CBF5DE2D0D1D"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","INR","MXN","NOK","NZD","PLN","RUB","SGD","USD","ZAR"]

    func getCoinPrice(for currency: String){
        let url = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(for: url)
    }
    
    func performRequest(for urlString: String) {
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    var coin = parseJSON(safeData)
                    delegate?.didUpdateCurrency(coinModel: coin!)
                }
                
                }
                
            
            task.resume()
        }
    }
    
    func parseJSON(_ coinData: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            
            let currencyRate = decodedData.rate
            let currencyName = decodedData.asset_id_quote
            print(currencyName)
            var coinModel = CoinModel(currencyRate: currencyRate, currencyName: currencyName)
            
            return coinModel
            
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
}
