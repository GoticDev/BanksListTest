//
//  NetworkManager.swift
//  BanksListTest
//
//  Created by Victor De la Torre on 17/11/22.
//

import Alamofire
import SwiftyJSON

class NetworkManager {
    static let shared = NetworkManager()
    let session = Session()
    
    func request(url: String, httpMethod: HTTPMethod, parameters: Parameters?, completion: @escaping (Result<JSON,Error>) -> Void) {
        session.request(url, method: httpMethod, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success:
                if let data = response.data, let json = try? JSON.init(data: data) {
                    self.showRequestAndResponse(url, nil, parameters, json)
                    if let unwarappedResponse = response.response {
                        let statusCode = unwarappedResponse.statusCode
                        if statusCode == 200 {
                            completion(.success(json))
                        } else {
                            print("fail with status code: ", statusCode)
                        }
                    }
                }
            case .failure(let error):
                print("error: ", error.localizedDescription)
                if let unwarappedResponse = response.response {
                    let statusCode = unwarappedResponse.statusCode
                    print("fail with status code:", statusCode)
                }
            }
        }
        
    }
    
    func showRequestAndResponse(_ url: String, _ headerss: [String: Any]?, _ params: [String: Any]?, _ json: JSON?) {
        print("URL: \(url)")
        if let request = params?.prettyPrintedJSON {
            print("REQUEST: \(request)")
        }
        if let headers = headerss?.prettyPrintedJSON {
            print("HEADERS: \(headers)")
        }
        if let response = json {
            print("RESPONSE: \(response)")
        }
    }
    
}





