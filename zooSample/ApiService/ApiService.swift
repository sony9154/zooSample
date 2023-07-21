//
//  ApiService.swift
//  zooSample
//
//  Created by Hsu Hua on 2023/7/21.
//

import Foundation
import Alamofire

class APIService {
    static var shared = APIService()
    
    var accessToken: String?
    var idToken: String?
    var refreshToken: String?
    
    var baseURL: URL = URL(string:"https://data.taipei/api/v1/dataset/5a0e5fbb-72f8-41c6-908e-2fb25eff9b8a?scope=resourceAquire")!
    
    var defaultHeaders: HTTPHeaders = [
        "Accept" : "application/vnd.github.v3+json",
        "Content-Type" : "application/json; charset=utf-8"
    ]
    
    func getExhibit(
                 completion: @escaping(Result<[Exhibit], Error>) -> Void) {
        
//        var params: [String: Any] = [:]
//        params["q"] = q
//        params["page"] = page
//        params["per_page"] = per_page
        
        let url = baseURL//.appendingPathComponent("/search/users")
        let request = AF.request(url, method: .get,
                                 headers: defaultHeaders)
                        .validate(statusCode: 200..<300)
        request.response { response in
            switch response.result {
            case .success(let data):
                guard let data = data,
                      let dictionary = try? JSONSerialization.jsonObject(with: data, options: [])
                                            as? [String: Any] else  {
                    completion(.failure(APIError.error(with: response.data)))
                    return
                }
                
                guard let result = dictionary["result"] as? [String: Any] else {
                    completion(.failure(APIError.error(with: response.data)))
                    return
                }
                
                guard let exhibitsArray = result["results"] as? [[String: Any]] else {
                    completion(.failure(APIError.error(with: response.data)))
                    return
                }
                
                var exhibits: [Exhibit] = []
                
                for exhibitData in exhibitsArray {
                    guard let exhibitsID = exhibitData["_id"] as? Int64 else {
                        continue
                    }
                    var exhibit = Exhibit(id: exhibitsID)
                    exhibit.eInfo = exhibitData["e_info"] as? String
                    exhibit.eCategory = exhibitData["e_category"] as? String
                    exhibit.eName = exhibitData["e_name"] as? String
                    exhibit.ePicURL = exhibitData["e_pic_url"] as? String
                    exhibits.append(exhibit)
                }
                
                completion(.success(exhibits))
                
            case .failure(let error):
                completion(.failure(APIError.error(with: response.data,
                                                   fallback: error)))
            }
        }
    }
    

}


// MARK: - Type Definitio
enum APIError: String, Error {
    case accessTokenIsNil
    case dataNotFound = "100001"    // 查無資料
    case userNotFound = "200001"    // 用戶不存在
    case undefined
    
    // MARK: - Helpers
    static func apiError(with responseData: Data?) -> APIError? {
        if let data = responseData,
           let dictionary = try? JSONSerialization.jsonObject(with: data, options: [])
                                    as? [String: Any],
           let code = dictionary["code"] as? String,
           let apiError = APIError(rawValue: code) {
            return apiError
        } else {
            return nil
        }
    }
    
    static func error(with responseData: Data?, fallback: Error? = nil) -> Error {
        if let data = responseData,
           let dictionary = try? JSONSerialization.jsonObject(with: data, options: [])
                                    as? [String: Any],
           let code = dictionary["code"] as? String,
           let apiError = APIError(rawValue: code) {
            return apiError
        } else {
            return fallback ?? DummyError()
        }
    }
}

struct DummyError: Error {
}
