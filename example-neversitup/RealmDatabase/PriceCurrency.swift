//
//  PriceCurrency.swift
//  MobileDev
//
//  Created by Sakolrat on 9/30/22.
//

import Foundation
import RealmSwift

class Currency : Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var timestamp    : String = ""
    @Persisted var data         = List<Detail_Currency>()
    
    convenience init(timestamp : String,data : List<Detail_Currency>) {
        self.init()
            self.timestamp = timestamp
            self.data = data
    }
}

class Detail_Currency : Object {
    @Persisted var code         : String = ""
    @Persisted var symbol       : String = ""
    @Persisted var rate         : String = ""
    @Persisted var desc         : String = ""
    @Persisted var rate_float   : Float = 0.0
    
    convenience init(code: String, symbol: String,rate : String,desc : String,rate_float : Float) {
        self.init()
            self.code = code
            self.symbol = symbol
            self.rate = rate
            self.desc = desc
            self.rate_float = rate_float
    }
}

class RealmManager : NSObject {
    func addCurrency(data :CurrencyPrice,completion : @escaping () -> Void) {
        let mirror = Mirror(reflecting: data.bpi)
        let listCoin : List<Detail_Currency> = List<Detail_Currency>()
        for child in mirror.children {
            let coinItem : coin = child.value as! coin
            let detail : Detail_Currency = Detail_Currency(code: coinItem.code, symbol: coinItem.symbol, rate: coinItem.rate, desc: coinItem.description, rate_float: coinItem.rate_float)
            listCoin.append(detail)
        }
        let currencyItem : Currency = Currency(timestamp: data.time.updated, data: listCoin)
        let realm = try! Realm()
        try! realm.write {
            realm.add(currencyItem)
        }
        completion()
    }
    
    func getCurrency()->Results<Currency>{
        let realm = try! Realm()
        let historyItem = realm.objects(Currency.self)
        print("Data DataBase : ", historyItem)
        return historyItem
    }
    
}
