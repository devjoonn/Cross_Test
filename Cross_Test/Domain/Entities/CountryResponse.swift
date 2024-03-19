//
//  Country.swift
//  Cross_Test
//
//  Created by 박현준 on 3/19/24.
//

import Foundation

// MARK: - CountryResponse
struct CountryListResponse: Codable {
    let result, error: String
    let errorCode: Int
    let data: CountryConfigureResponse

    enum CodingKeys: String, CodingKey {
        case result, error
        case errorCode = "error_code"
        case data
    }
}

// MARK: - CountryConfigureResponse
struct CountryConfigureResponse: Codable {
    let countryConfigure: [CountryConfigure]

    enum CodingKeys: String, CodingKey {
        case countryConfigure = "country_configure"
    }
}

// MARK: - CountryConfigure
struct CountryConfigure: Codable {
    let id: Int
    let country, rateKey: String
    let additionalPercent: Double
    let name, rateCurrency, currency, rateUnit: String
    let unit: String
    let multiply, phoneCode, minRemit, maxRemit: Int
    let isoCode: String
    let platformID, baseFee: Int
    let feeFormula: String
    let inverseFormula: String
    let status, howtouseBoundary, priority, defaultAmount: Int
    let defaultAmountType: String
    let rmExists: Bool
    let localLanguage: String?
    let availRemitPlatforms: [Int]
    let remitTypes: [RemitTypeElement]
    let feeVisibility: Bool
    let feeApplyType: String
    let webStatus, iosStatus, androidStatus: Int

    enum CodingKeys: String, CodingKey {
        case id, country
        case rateKey = "rate_key"
        case additionalPercent = "additional_percent"
        case name
        case rateCurrency = "rate_currency"
        case currency
        case rateUnit = "rate_unit"
        case unit, multiply
        case phoneCode = "phone_code"
        case minRemit = "min_remit"
        case maxRemit = "max_remit"
        case isoCode = "iso_code"
        case platformID = "platform_id"
        case baseFee = "base_fee"
        case feeFormula = "fee_formula"
        case inverseFormula = "inverse_formula"
        case status
        case howtouseBoundary = "howtouse_boundary"
        case priority
        case defaultAmount = "default_amount"
        case defaultAmountType = "default_amount_type"
        case rmExists = "rm_exists"
        case localLanguage = "local_language"
        case availRemitPlatforms = "avail_remit_platforms"
        case remitTypes = "remit_types"
        case feeVisibility = "fee_visibility"
        case feeApplyType = "fee_apply_type"
        case webStatus = "web_status"
        case iosStatus = "ios_status"
        case androidStatus = "android_status"
    }
}

// MARK: - RemitTypeElement
struct RemitTypeElement: Codable {
    let remitType: String
    let remitTypeToName: String
    let defaultPlatformID, priority: Int

    enum CodingKeys: String, CodingKey {
        case remitType = "remit_type"
        case remitTypeToName = "remit_type_to_name"
        case defaultPlatformID = "default_platform_id"
        case priority
    }
}
