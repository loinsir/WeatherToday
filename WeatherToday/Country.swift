//
//  Countries.swift
//  WeatherToday
//
//  Created by 김인환 on 2021/08/10.
//

import Foundation

/*
 {"korean_name":"한국",
  "asset_name":"kr"}
*/
class Country: Codable {
    let koreanName: String
    let assetName: String
    
    enum CodingKeys: String, CodingKey {
        case koreanName = "korean_name"
        case assetName = "asset_name"
    }
    
    var flagName: String {
        return "flag_\(self.assetName)"
    }
}
