//
//  calc-logic.swift
//  simple-calc
//
//  Created by Chris Ross on 10/24/16.
//  Copyright © 2016 Chris Ross. All rights reserved.
//

import Foundation

class Calc {
    var currentNum: Float
    var results: Float
    var currentOperator: String
    var count: Float
    var decimal: Bool
    var decimalCount: Int
    var rpnOn: Bool
    var rpnArray: [Float]
    
    init () {
        self.currentNum = 0.0
        self.results = 0.0
        self.currentOperator = "="
        self.count = 1
        self.decimal = false
        self.decimalCount = 0
        self.rpnOn = false
        self.rpnArray = []
    }
    
    func nextDigit(input: Int) {
        if (self.decimal) {
            print("decimal count \(pow(10, self.decimalCount))")
            var power = 10
            var count = 1
            while (count < self.decimalCount) {
                power = power * 10
                count += 1
            }
            self.currentNum = self.currentNum + (Float.init(input) / Float.init(power))
            print("currentNum \(self.currentNum)")
            print("decimal count new\(power)")
            self.decimalCount += 1
        } else {
            self.currentNum = self.currentNum * 10 + Float.init(input)
        }
    }
    
    func operate() {
        switch currentOperator {
        case "=" :
            self.results = self.currentNum
        case "+" :
            self.results += self.currentNum
        case "-" :
            self.results -= self.currentNum
        case "*" :
            self.results = self.results * self.currentNum
        case "/" :
            self.results = self.results / self.currentNum
        case "count":
            self.results = count
        case "avg":
            if (self.count > 2) {
                self.count = 2
            }
            self.results += self.currentNum
            print("First results \(self.results)")
            self.results = self.results / self.count
            print("Second results\(results)")
        case "fact":
            let top = Int.init(self.results)
            var counter = 1
            while(counter <= top) {
                self.results += Float.init(counter)
                counter += 1
            }
        default :
            print("error")
        }
        self.currentNum = 0
        self.decimalCount = 0
        self.decimal = false
    }
    
    func setOper(operation: String?) {
        operate()
        if (operation != nil) {
            self.currentOperator = operation!
            self.count += 1
        }
    }
    
    func clearAll() {
        self.currentNum = 0
        self.results = 0
        self.count = 1
        self.currentOperator = "="
        self.decimalCount = 0
        self.decimal = false
        self.rpnArray = []
    }
    
    func retCurrentNum() -> String{
        if (self.rpnOn) {
            var ret = ""
            for num in self.rpnArray {
                ret += " \(num)"
            }
            ret += " \(String.init(self.currentNum))"
            if (self.currentOperator != "=") {
                ret += self.currentOperator
            }
            return ret
        } else {
            return String.init(self.currentNum)
        }
    }
    
    func setDecimal() {
        self.decimal = true
        self.decimalCount = 1
        print(self.decimalCount)
    }
    
    func rpnSetOn() {
        self.rpnOn = true
    }
    
    func rpnSetOff() {
        self.rpnOn = false
    }
    
    func rpnStoreNums(next: Float) {
        self.rpnArray.append(next)
    }
    
    func rpnCalculate() {
        print(self.currentOperator)
        switch currentOperator {
        case "=" :
            self.results = self.currentNum
        case "+" :
            for num in self.rpnArray {
                print("num in array \(num)")
                self.results += num
            }
        case "-" :
            for num in self.rpnArray {
                self.results -= num
            }
        case "*" :
            for num in self.rpnArray {
                self.results = self.results * num
            }
        case "/" :
            for num in self.rpnArray {
                self.results = self.results / num
            }
        case "count":
            for num in self.rpnArray {
                self.results = self.results * num
            }
        case "avg":
            self.results = (self.results + self.currentNum) / self.count
        case "fact":
            let top = Int.init(self.rpnArray[0])
            var counter = 1
            while(counter <= top) {
                self.results += Float.init(counter)
                counter += 1
            }
        default:
            print("There was an error")
        }
    }

}

