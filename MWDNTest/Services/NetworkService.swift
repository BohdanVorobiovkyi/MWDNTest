//
//  NetworkService.swift
//  MWDNTest
//
//  Created by Богдан Воробйовський on 28.10.2019.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation

struct NetworkEndpoint {
    
    static let baseURL = "http://www.ifsac.pw/mc/in?name="
    
}

class NetworkService {
    
    static let shared = NetworkService()
    
    private init() {  }
    
    public func request(_ date: String, _ nameAttribute: String, completion: @escaping(ResponseModel) -> Void, timeIntervalCompletion: @escaping(TimeInterval) -> Void) {
        
        guard let requestURL = URL(string: NetworkEndpoint.baseURL + nameAttribute) else {return}
        let requestDate = Date()
        let requestPostJSON: [String: String] = ["date": date]
        let session = URLSession.shared
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestPostJSON, options: .prettyPrinted).base64EncodedData()
        }
        catch {
            print("RequestJSON serializtion error")
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request) { (data, response, err) in
            if let err = err {
                print("URLSession data task err: \(err.localizedDescription)")
            } else {
                if let data = data {
                    guard let base64Data = Data(base64Encoded: data) else {return}
                    do {
                        let decodedData = try JSONDecoder().decode(ResponseModel.self, from: base64Data)
                        completion(decodedData)
                    } catch let err {
                        print("Responsed data decoding err: \(err.localizedDescription)")
                    }
                }
                if let _ = response as? HTTPURLResponse {
                    timeIntervalCompletion(Date().timeIntervalSince(requestDate))
                    print("Response")
                }
            }
        }
        task.resume()
    }
}
