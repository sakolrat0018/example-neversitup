//
//  ViewController.swift
//  MobileDev
//
//  Created by Sakolrat on 9/29/22.
//

import UIKit
import DropDown


class ViewController: UIViewController {
    
    var bonus : Bonus!
    
    let dropDownx = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            bonus = Bonus()
            bonus.filterArray(arrOne: [4,4,2,5,6,10,9,6,5,4,31,23,1432,345,35,23,1], arrTwo: [1,3,4,9])
    }

    @IBAction func fibonanciAction(_ sender: Any) {
        bonus.fibonacciSequence(n: 10) { result in
            print(result)
        }
    }
    
    @IBAction func primeAction(_ sender: Any) {
        bonus.primes(rangeEnd: 100) { result in
            print(result)
        }
    }
    
    
}

