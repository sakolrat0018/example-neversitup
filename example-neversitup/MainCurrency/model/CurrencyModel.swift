//
//  CurrencyModel.swift
//  MobileDev
//
//  Created by Sakolrat on 9/30/22.
//

import Foundation

class CurrencyModel: NSObject {
    var optionList : [String] = ["USD","GBP","EUR"]
}

struct CurrencyPrice : Codable {
    var time       : timeUpdated
    var disclaimer : String
    var chartName  : String
    var bpi        : bpiModel
}

struct timeUpdated : Codable {
    var updated    : String
    var updatedISO : String
    var updateduk  : String
}

struct bpiModel : Codable {
    var USD : coin
    var GBP : coin
    var EUR : coin
}

struct coin : Codable {
    var code        : String
    var symbol      : String
    var rate        : String
    var description : String
    var rate_float  : Float
}
