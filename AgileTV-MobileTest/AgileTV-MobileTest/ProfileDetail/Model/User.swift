//
//  User.swift
//  AgileTV-MobileTest
//
//  Created by Enrique Carvalho on 08/02/25.
//

import Foundation
import UIKit

class User: Codable {
    var name: String
    var image: Data?
    var repositories: [Repository]?
    
    init(name: String, image: Data? = nil, repositories: [Repository]) {
        self.name = name
        self.image = image
        self.repositories = repositories
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "login"
    }
}
