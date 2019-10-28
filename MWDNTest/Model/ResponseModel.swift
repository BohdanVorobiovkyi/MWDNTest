//
//  ResponseModel.swift
//  MWDNTest
//
//  Created by Богдан Воробйовський on 28.10.2019.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation

class ResponseModel: Codable {
    
    let sh: String?
    let num: Int?
    let html: String?
    let ans: String?
    
    enum CodingKeys: String, CodingKey {
        case sh, num, html = "HTML", ans
    }
    
    func encode(to encoder: Encoder) throws{
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(sh, forKey: .sh)
        try container.encode(num, forKey: .num)
        try container.encode(html, forKey: .html)
        try container.encode(ans, forKey: .ans)
    }
    
    required init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        sh = try container.decodeIfPresent(String.self, forKey: .sh) ?? ""
        num = try container.decodeIfPresent(Int.self, forKey: .num) ?? 0
        html = try container.decodeIfPresent(String.self, forKey: .html) ?? ""
        ans = try container.decodeIfPresent(String.self, forKey: .ans) ?? ""
        
    }
}
