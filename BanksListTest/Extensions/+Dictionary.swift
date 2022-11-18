//
//  +Dictionary.swift
//  BanksListTest
//
//  Created by Victor De la Torre on 17/11/22.
//

import UIKit

extension Dictionary {
    var prettyPrintedJSON: String? {
        do {
            let data: Data = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(data: data, encoding: .utf8)
        } catch _ {
            return nil
        }
    }
}
