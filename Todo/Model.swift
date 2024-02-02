//
//  Model.swift
//  Todo
//
//  Created by 영현 on 1/9/24.
//

import Foundation

//MARK: Todo -> Codable로 구성 후 UserDefault에 JSON 형식으로 저장하는 것 고려
// JSON으로 Encode하려면 Key-Value 쌍으로 정의하면 됨...
// Key-Value 쌍으로 데이터를 정의하려면, Hashable, Equatable 에 대해서 공부해보면 좋음! -> 비교를 할 수 있도로 만들어 주는...
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

struct User {
    var id: UUID
    var name: String
    var age: Int
}
