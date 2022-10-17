//
//  Bonus.swift
//  MobileDev
//
//  Created by Sakolrat on 9/29/22.
//

import UIKit

class Bonus: NSObject {
    func fibonacciSequence (n: Int,completion : @escaping ([Int]) -> Void)  {
        var fibonacciArray = [Int]()
        for n in 0 ... n {
            if n == 0 {
                fibonacciArray.append(0)
            }
            else if n == 1 {
                fibonacciArray.append(1)
            }
            else {
                fibonacciArray.append (fibonacciArray[n-1] + fibonacciArray[n-2] )
            }
        }
        completion(fibonacciArray)
        print("fibonanci : ",fibonacciArray)
    }
    
    func primes(rangeEnd: Int,completion : @escaping ([Int]) -> Void){
        let firstPrime = 2
        guard rangeEnd >= firstPrime else {
            fatalError("End of range has to be greater than or equal to \(firstPrime)!")
        }
        var numbers = Array(firstPrime...rangeEnd)
        
        var currentPrimeIndex = 0

        while currentPrimeIndex < numbers.count {
            let currentPrime = numbers[currentPrimeIndex]
            var numbersAfterPrime = numbers.suffix(from: currentPrimeIndex + 1)
            numbersAfterPrime.removeAll(where: { $0 % currentPrime == 0 })
            numbers = numbers.prefix(currentPrimeIndex + 1) + Array(numbersAfterPrime)
            currentPrimeIndex += 1
        }
        completion(numbers)
        print("prime : ",numbers)
    }
    
    func filterArray(arrOne:[Int],arrTwo:[Int]) {
        var number1 = [Int]()
        for i in 0...arrOne.count-1 {
            let a = arrOne[i]
            for j in 0...arrTwo.count-1 {
                let b = arrTwo[j]
                if a == b {
                    number1.append(a)
                }
            }
        }
       
        print("result : ",number1)
       
    }
}
