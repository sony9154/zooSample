//
//  GetExhibitservice.swift
//  zooSample
//
//  Created by Hsu Hua on 2023/7/21.
//

import Foundation

class GetExhibitservice {
    static var shared = GetExhibitservice()
    
    func getExhibits(completion: @escaping (Result<[Exhibit], Error>) -> Void) {
        APIService.shared.getExhibit(completion: { result in
            switch result {
            case .success(let exhibits):
                completion(.success(exhibits))
            case .failure(let error):
                print(error)
            }
        }
        )}
}
