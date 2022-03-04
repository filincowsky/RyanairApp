//
//  PaxSettingViewModel.swift
//  RyanairApp
//
//  Created by Vitor Ribeiro on 03/03/22.
//  Copyright © 2022 Vitor Filincowsky. All rights reserved.
//

import Foundation

class PaxSettingViewModel: NSObject {
    
    var min: Int = 0
    var max: Int = 0
    private(set) var value: Int = 0 {
        didSet { self.invokeBind() }
    }
    
    var bind : ((Int) -> ())? {
        didSet { self.invokeBind() }
    }

    init(min: Int, max: Int) {
        super.init()
        self.min = min
        self.max = max
        self.value = min
    }
    
    fileprivate func invokeBind() {
        if let _ = self.bind {
            self.bind!(value)
        }
    }
    
    func onIncrement() {
        if self.value < self.max {
            self.value += 1
        }
    }
    
    func onDecrement() {
        if self.value > self.min {
            self.value -= 1
        }
    }

}
