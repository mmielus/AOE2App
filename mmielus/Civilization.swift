//
//  Civilization.swift
//  mmielus
//
//  Created by Guest User on 06.12.2019.
//  Copyright © 2019 Guest User. All rights reserved.
//

import Foundation

struct CivilizationRoot : Decodable {
    
    private enum  CodingKeys: String, CodingKey { case civilizations}
    
    let civilizations : [Civilization]
}
struct Civilization : Codable {

    
   var id : Int?
    var name: String?
    var army_type : String?
    var civilization_bonus : [String]?
    var expansion : String?
    var team_bonus : String?
//    var unique_tech : String?
//    var unique_unit : String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case army_type
        case civilization_bonus
        case expansion
        case team_bonus
//        case unique_tech
//        case unique_unit
        
    }
}
