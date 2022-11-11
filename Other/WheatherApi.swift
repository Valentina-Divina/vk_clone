//
//  WheatherApi.swift
//  VKontakte
//
//  Created by Valya on 17.08.2022.
//

import Foundation
import UIKit
import Alamofire

class WeatherApi {
    let url = "https://api.openweathermap.org/data/2.5/weather"
    
    func weather(){
        let param = [
            "q":"Moscow",
            "appid":"6510fbc2a5795dbe5e008c49d129fa02"
        ]
        
        Alamofire.request(url, method: .get, parameters: param).responseJSON { resp in
            if let data = resp.data {
                let json = try! JSONDecoder().decode(Wheater.self, from: data)
            }
        }
    }
}

struct Wheater: Codable {
    let main: Main
    let dt: Date
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let intermediateDt = try container.decode(Double.self, forKey: .dt)
        self.dt = Date(timeIntervalSince1970: intermediateDt)
        self.main = try container.decode(Main.self, forKey: .main)
    }
    
    enum CodingKeys: String, CodingKey {
        case main, dt
    }
}

struct Main: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let intermediateTemp = try container.decode(Double.self, forKey: .temp)
        
        self.temp = intermediateTemp - 273 // Кельвин -> Цельсий
    }
    
    let temp: Double // температура в Цельсии.
    
    enum CodingKeys: String, CodingKey {
        case temp
    }
}
