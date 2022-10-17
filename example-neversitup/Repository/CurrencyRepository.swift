//
//  CurrencyRepository.swift
//  MobileDev
//
//  Created by Sakolrat on 10/9/22.
//

import UIKit
import RxSwift
import RealmSwift

class CurrencyRepository: NSObject {
    lazy var dataBaseManager: RealmManager = {
        let realm = RealmManager()
        return realm
    }()
    
    func getCurrentPrice() -> Observable<CurrencyPrice> {
        return Observable.create( { observer in
            ApiManager.callService(urlString:"https://api.coindesk.com/v1/bpi/currentprice.json", method: "GET",parameter:nil) { result in
                switch result {
                case .success(let datax) :
                    let decoder = JSONDecoder()
                    let jsonData = Data(datax.data(using: .utf8)!)
                    do {
                        let data = try decoder.decode(CurrencyPrice.self, from: jsonData)
                        observer.onNext(data)
                        self.insertDataBase(data: data)
                        observer.onCompleted()
                    }catch {
                        observer.onError(error)
                    }
                case .failure(let error) :
                    observer.onError(error)
                }
            }
            return Disposables.create()
        })
    }
    
    //MARK: - database
    func insertDataBase(data : CurrencyPrice) {
        self.dataBaseManager.addCurrency(data: data, completion: { () in
            print("complete add database")
        })
    }
    
    func getHistoryData() -> Observable<Results<Currency>>{
        return Observable.create({ observer in
            observer.onNext(self.dataBaseManager.getCurrency())
            observer.onCompleted()
            return Disposables.create()
        })
    }
    
   
}
