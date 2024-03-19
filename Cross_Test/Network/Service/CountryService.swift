//
//  CountryService.swift
//  Cross_Test
//
//  Created by 박현준 on 3/19/24.
//

import Foundation
import Moya

public enum CountryService {
    case getCountries
    case getCurrency(platformId: Int)
}

extension CountryService: TargetType {
    public var baseURL: URL { return URL(string: CrossAPI.shared.baseURL)! }
    
    public var path: String {
        switch self {
        case .getCountries:
            return "/v1/outbound/countries/"
        case .getCurrency:
            return "/v2/outbound/quote/"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getCountries, .getCurrency:
            return .get
        }
    }
    
    public var task: Task {
        switch self {
        case .getCountries:
            return .requestPlain
        case .getCurrency(let platformId):
            let param: [String: Any] = [
                "platform_id": platformId,
                "sending_amount": 1000000,
                "quote_type": "send"
            ]
            
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        }
    }
    
    public var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
