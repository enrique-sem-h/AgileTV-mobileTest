//
//  Repository.swift
//  AgileTV-MobileTest
//
//  Created by Enrique Carvalho on 08/02/25.
//

import Foundation

class Repository: Codable {
    var name: String
    var language: String?
    
    init(name: String, language: String) {
        self.name = name
        self.language = language
    }
}
