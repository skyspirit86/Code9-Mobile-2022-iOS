//
//  Clients.swift
//  Code9-Mobile-2022-iOS
//
//  Created by Zolt Varga on 4/24/22.
//

import Foundation

// MARK: - Client
struct Client: Codable {
    let id, name: String
    let picture: String
    let gender: Gender
    let company, email, phone, address: String
    let friends: [Friend]

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, picture, gender, company, email, phone, address, friends
    }
}

// MARK: - Friend
struct Friend: Codable {
    let id: Int
    let name: String
}

enum Gender: String, Codable {
    case female = "female"
    case male = "male"
}
