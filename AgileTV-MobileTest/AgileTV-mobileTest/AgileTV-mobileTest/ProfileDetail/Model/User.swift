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
    
    
    
    enum CodingKeys: String, CodingKey {
        case name = "login"
    }
}
