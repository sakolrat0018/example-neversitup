//
//  MainCurrencyViewModel.swift
//  MobileDev
//
//  Created by Sakolrat on 9/30/22.
//

import UIKit
import RxSwift


class MainCurrencyViewModel: NSObject {
    
    lazy var model: CurrencyModel = {
        let model = CurrencyModel()
        return model
    }()
    
    lazy var currencyRepository : CurrencyRepository = {
        let repo = CurrencyRepository()
        return repo
    }()
     
    var publicSubject = PublishSubject<CurrencyPrice>()
    var publicResult = PublishSubject<String>()
    
    
    
    //MARK: - api get currency price
    func getCurrentPrice() {
        currencyRepository.getCurrentPrice().subscribe(onNext: { (value) in
            self.publicSubject.onNext(value)
        }, onError: { (value) in
            print("On Error [\(value)]")
        }, onCompleted: {
             print("Completed !!!!")
        })
    }
    
    //MARK: - other
    func convertCurrency(quantity : Int,typeSelect : String , priceSelect : Float){
        if typeSelect != "" {
            let result : Float = Float(quantity)/priceSelect
            publicResult.onNext(String(format: "%d %@ = %f BTC",quantity,typeSelect,result))
        }
    }
    
}
