//
//  Model.swift
//  Todo
//
//  Created by 영현 on 1/9/24.
//

import Foundation

struct Todo {
    var id: Int
    var title: String
    var isCompleted: Bool
    var category: String
}

struct Pet: Decodable {
    let id: String
    let url: String
    let width: Int
    let height: Int
    let breeds: [String]?
    let favourite: String?
    
    public enum Keys: String, CodingKey {
        case id
        case url
        case width
        case height
        case breeds
        case favourite
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        url = try container.decode(String.self, forKey: .url)
        id = try container.decode(String.self, forKey: .id)
        width = try container.decode(Int.self, forKey: .width)
        height = try container.decode(Int.self, forKey: .height)
        breeds = try? container.decode([String].self, forKey: .breeds)
        favourite = try? container.decode(String.self, forKey: .favourite)
    }
    
}
