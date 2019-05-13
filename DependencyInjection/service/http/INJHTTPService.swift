//
//  HttpService.swift
//  Shopping
//
//  Created by Alexey Oleksandrovich on 3/23/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import UIKit

open class INJHTTPService: INJService {
    
    // PUBLIC
    public func request(with: INJHTTPRequest, completionHandler: @escaping (Any?, Error?) -> Void) {
        requestRoute(with, completionHandler)
    }
    
    // PRIVATE
    private func requestRoute(_ with: INJHTTPRequest, _ completionHandler: @escaping (_ json: Any?, _ error:Error?) -> Void) {
        let session = URLSession.shared;
        
        guard let request = getRequest(with) else { return }
        
        session.dataTask(with: request) { (data, response, error) in
            guard   let data = data,
                    let response = response as? HTTPURLResponse,
                    (200..<300) ~= response.statusCode,
                    error == nil else { return }
            do {

                
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                
                print("GET data as json: \(String(describing: json))")
                
                completionHandler(json, nil)
            }catch{
                print("Get parse data error: \(error)")
                
                completionHandler(nil, error)
            }
            }.resume()
    }
    
    private func getRequest(_ httpReguest: INJHTTPRequest) -> URLRequest? {
        var result:URLRequest;
        
        guard let url = URL(string: httpReguest.route.path) else { return nil}
        
        result = URLRequest(url: url,
                            cachePolicy: .useProtocolCachePolicy,
                            timeoutInterval: 5.0);
        
        result.httpMethod = httpReguest.route.method.rawValue;
        
        if let params = httpReguest.parameters {
            switch httpReguest.route.method {
                case .POST:
                        do {
                            result.addValue("application/json", forHTTPHeaderField: "Content-Type")
                            result.addValue("*/*", forHTTPHeaderField: "Accept")
                            result.addValue("no-cache", forHTTPHeaderField: "cache-control")

                            result.httpBody = try JSONSerialization.data(withJSONObject: params, options: []);
                            
                        }catch let error {
                            print("ERROR: HttpService::getRequest \(error)");
                        }
                case .GET:
                        var components = URLComponents(string: httpReguest.route.path)!;
                    
                        if let params = httpReguest.parameters {
                            components.queryItems = params.map { (key, value) in
                                URLQueryItem(name: key, value: value)
                            }
                        }
                    
                        result.url = components.url;
            }
        }
        
        guard (httpReguest.headerValues != nil) else { return result; }
        
        for (key, value) in httpReguest.headerValues! {
            result.addValue(value, forHTTPHeaderField: key)
        }
        
        return result;
    }
}
