//
//  BankListService.swift
//  BanksListTest
//
//  Created by Victor De la Torre on 17/11/22.
//

import Foundation

struct BankListService {
    
    func getPreCashOut(completion: @escaping([BankListResponse]?, BankListError?) -> Void){
        NetworkManager.shared.request(url: Constants.bankListUrl, httpMethod: .get, parameters: nil) { (response) in
            switch response{
            case .success(let json):
                do {
                    let listResponse = try JSONDecoder().decode([BankListResponse].self, from: json.rawData())
                    completion(listResponse, nil)
                } catch let error {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil, BankListError(message: error.localizedDescription))
            }
        }
    }
}
