//
//  ApiManager.swift
//  MobileDev
//
//  Created by Sakolrat on 9/30/22.
//

import UIKit

protocol delegateApi {
    func requestFinish(strJson:String)
    func requestFailer(statusCode : Int)
    func requestError(error:String)
}

class ApiManager: NSObject {
    var delegate: delegateApi!
    
    static func callService(urlString : String,method : String,parameter:Any?,completion : @escaping (Result<String, Error>) -> Void) {
        let url : URL = URL(string:urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if parameter != nil {
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameter!, options: []) else { return }
            request.httpBody = httpBody
        }
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            DispatchQueue.main.async {
                guard let data = data,
                    let _ = response as? HTTPURLResponse,
                    error == nil else {
                    completion(.failure(error!))
                    return
                }
                let responseString = String(data: data, encoding: .utf8)
                completion(.success(responseString!))
            }
        }
        task.resume()
    }
    
//    func requestApi(url: String,method : String,parameter:Any) {
//        let url : URL = URL(string:url)!
//        var request = URLRequest(url: url)
//        request.httpMethod = method
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: []) else { return }
//        request.httpBody = httpBody
//        let task = URLSession.shared.dataTask(with: request) { [self] data, response, error in
//            DispatchQueue.main.async {
//                guard let data = data,
//                    let response = response as? HTTPURLResponse,
//                    error == nil else {
//                    self.delegate.requestError(error: error!.localizedDescription)
//                    return
//                }
//
//                if response.statusCode == 200 {
//                    let responseString = String(data: data, encoding: .utf8)
//                    self.delegate.requestFinish(strJson: responseString!)
//                }else {
//                    let responseString = String(data: data, encoding: .utf8)
//                    self.delegate.requestFailer(statusCode: response.statusCode)
//                }
//            }
//        }
//
//        task.resume()
//    }
}
