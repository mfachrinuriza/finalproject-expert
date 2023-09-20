//
//  BaseService.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 03/08/23.
//

import Alamofire

class BaseService: NSObject {
    lazy var HOST_URL: String = {
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
            let dictionary = NSDictionary(contentsOfFile: path)
            return dictionary!["HOST_URL"] as! String
        } else {
            return ""
        }
    }()
    
    lazy var API_KEY: String = {
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
            let dictionary = NSDictionary(contentsOfFile: path)
            return dictionary!["API_KEY"] as! String
        } else {
            return ""
        }
    }()
    
    func showRequestData(data: Data) {
        let stringRequest = String(data: data, encoding: String.Encoding.utf8)
        Logger.printLog("stringRequest :: \(stringRequest!)")
    }
    
    func showResponseData(data: Data?) {
        if data != nil {
            let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any]
            Logger.printLog(json)
            
            if json == nil {
                let string = String(data: data!, encoding: .utf8)
                Logger.printLog("Failed Show Response Data")
                Logger.printLog(string)
            }
        }
    }
    
    func getHeaders() -> HTTPHeaders {
        var request = URLRequest(url: URL(string: self.HOST_URL)!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        return request.headers
    }
}
