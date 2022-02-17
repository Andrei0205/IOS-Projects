//
//  WeatherManager.swift
//  Clima
//
//  Created by Andrei Marinescu on 21.03.2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(_ error: Error)
}

struct WeatherManager {
     
    var weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=5873403d9f895e8ed4fe7afbf53c7115&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees,longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    self.delegate?.didFailWithError(error!)
                    return
                }
                if let safeString = data {
                    if let weather = parseJSON(safeString){
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            
            task.resume()
            
        }
        
        func parseJSON(_ weatherData: Data) -> WeatherModel?{
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
                let decodedId = decodedData.weather[0].id
                let decodedTemperature = decodedData.main.temp
                let decodedCityName = decodedData.name
                
                let weatherModel = WeatherModel(conditionID: decodedId, cityName: decodedCityName, temperature: decodedTemperature)
                return weatherModel
                //print(weatherModel.conditionName)
                
            } catch {
                delegate?.didFailWithError(error)
                return nil
            }
        }
    }
    
    
}
