//
//  CurrencyResponse.swift
//  Cross_Test
//
//  Created by 박현준 on 3/19/24.
//

// MARK: - Country
struct CurrencyResponse: Codable {
    let result, error: String
    let errorCode: Int
    let data: CurrencyConfigure

    enum CodingKeys: String, CodingKey {
        case result, error
        case errorCode = "error_code"
        case data
    }
}

// MARK: - CurrencyConfigure
struct CurrencyConfigure: Codable {
    let quoteType: String
    let sendingAmount, receivingAmount: Int
    let serviceRate: Double
    let rateKey: String
    let fee, platformID: Int
    let limit: Limit
    let feeApplyType: String
    let payAmount, topupAmount: Int
    let currency, unavailableReason: String
    let isAvailTransfer: Bool
    let quoteID: String
    let topupMessage: String

    enum CodingKeys: String, CodingKey {
        case quoteType = "quote_type"
        case sendingAmount = "sending_amount"
        case receivingAmount = "receiving_amount"
        case serviceRate = "service_rate"
        case rateKey = "rate_key"
        case fee
        case platformID = "platform_id"
        case limit
        case feeApplyType = "fee_apply_type"
        case payAmount = "pay_amount"
        case topupAmount = "topup_amount"
        case currency
        case unavailableReason = "unavailable_reason"
        case isAvailTransfer = "is_avail_transfer"
        case quoteID = "quote_id"
        case topupMessage = "topup_message"
    }
}

// MARK: - Limit
struct Limit: Codable {
    let unit: String
    let avail, maxAmount, minAmount, minReceiving: Int
    let maxReceiving, availReceive: Int

    enum CodingKeys: String, CodingKey {
        case unit, avail
        case maxAmount = "max_amount"
        case minAmount = "min_amount"
        case minReceiving = "min_receiving"
        case maxReceiving = "max_receiving"
        case availReceive = "avail_receive"
    }
}
