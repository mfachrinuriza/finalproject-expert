//
//  BaseResponse.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 03/08/23.
//

import Foundation

struct BaseResponse<T: Codable> {
    var results: T?
}

extension BaseResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            results = try container.decode(T.self, forKey: .results)
        } catch {
            Logger.printLog("=== DECODE ERROR ===")
            Logger.printLog(error)
        }
    }
}

struct Nil: Codable {}
