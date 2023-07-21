//
//  zooViewModdel.swift
//  zooSample
//
//  Created by Hsu Hua on 2023/7/21.
//

import Foundation
import RxCocoa
import RxSwift

class ZooViewModel {
    
    var exhibits = BehaviorRelay<[Exhibit]?>(value: nil)
    
    func getExhibits(completion: @escaping (Result<[Exhibit], Error>) -> Void) {
        APIService.shared.getExhibit(completion: { [weak self] result in
            switch result {
            case .success(let exhibits):
                self?.exhibits.accept(exhibits)
                completion(.success(exhibits))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}


