//
//  StorageService.swift
//  MWDNTest
//
//  Created by Богдан Воробйовський on 28.10.2019.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation

class StorageService {
    
    static let shared = StorageService()
    
    private init() {  }
    
    func writeData(data: String) {
        let destinationURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
        let fileName = destinationURL.appendingPathComponent("ans.txt")
        
        do {
            try data.write(to: fileName, atomically: true, encoding: .utf8)
        }
        catch let err {
            print("err: \(err.localizedDescription)")
        }
        print(destinationURL)
    }
}
