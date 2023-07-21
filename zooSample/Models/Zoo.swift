//
//  Animal.swift
//  zooSample
//
//  Created by Hsu Hua on 2023/7/21.
//

import Foundation

struct ExhibitDataWrapper: Codable {
    let result: ExhibitData
}

struct ExhibitData: Codable {
    let limit: Int
    let offset: Int
    let count: Int
    let sort: String
    let results: [Exhibit]
}

struct Exhibit: Codable {
    var id: Int64
    var importDate: ImportDate?
    var eNo: String?
    var eCategory: String?
    var eName: String?
    var ePicURL: String?
    var eInfo: String?
    var eMemo: String?
    var eGeo: String?
    var eUrl: String?
}
    


struct ImportDate: Codable {
    let date: String
    let timezoneType: Int
    let timezone: String

    enum CodingKeys: String, CodingKey {
        case date
        case timezoneType = "timezone_type"
        case timezone
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try container.decode(String.self, forKey: .date)
        self.timezoneType = try container.decode(Int.self, forKey: .timezoneType)
        self.timezone = try container.decode(String.self, forKey: .timezone)
    }
}
