//
//  CrossAPI.swift
//  Cross_Test
//
//  Created by 박현준 on 3/19/24.
//

import Foundation

public final class CrossAPI {
    public static let shared = CrossAPI()
    private init() {}
    
    public let baseURL = "https://api.crossenf.com"
}
