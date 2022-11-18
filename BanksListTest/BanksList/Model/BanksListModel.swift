//
//  BanksListModel.swift
//  BanksListTest
//
//  Created by Victor De la Torre on 17/11/22.
//

import Foundation

struct BankListResponse: Codable {
    let url: String
    let age: Int
    let description: String
    let bankName: String
}

struct BankListError: Codable {
    let message: String
}
