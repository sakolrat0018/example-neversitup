//
//  HistoryViewModel.swift
//  MobileDev
//
//  Created by Sakolrat on 10/1/22.
//

import UIKit
import RxSwift
import RealmSwift

class HistoryViewModel: NSObject {
    
    lazy var currencyRepository : CurrencyRepository = {
        let repo = CurrencyRepository()
        return repo
    }()
    
    var publicHistoryData = PublishSubject<Results<Currency>>()
    
    func getHistoryCurrency() {
        currencyRepository.getHistoryData().subscribe(onNext: { (value) in
            print("Data ViewModel : ",value)
            self.publicHistoryData.onNext(value)
        }, onError: { (value) in
            print("On Error [\(value)]")
        }, onCompleted: {
             print("Completed !!!!")
        })
    }
}
