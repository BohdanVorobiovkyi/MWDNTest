//
//  Extension+DateFormatter.swift
//  MWDNTest
//
//  Created by Богдан Воробйовський on 28.10.2019.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation

public extension Date {
    
    func convertDateToString() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyy HH:mm:ss"
        
        return formatter.string(from: self)
    }
    
}
