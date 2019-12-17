//
//  Structure.swift
//  mmielus
//
//  Created by user on 17/12/2019.
//  Copyright © 2019 Guest User. All rights reserved.
//

import Foundation

struct StructureRoot : Decodable {
    
    private enum  CodingKeys: String, CodingKey { case structures}
    
    let structures : [Structure]
}
struct Structure : Codable {

    
    var id : Int?
    var name: String?
    var description : String?
    var expansion : String?
    var age : String?
    var cost : Cost?
    var build_time : Int?
    var hit_points : Int?
    var line_of_sight : Int?
    var armor : String?
//    var range : String?
    var reload_time : Int?
    var special : [String]?
    
  
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case expansion
        case age
        case cost
        case build_time
        case hit_points
        case line_of_sight
        case armor
//        case range
        case reload_time
        case special
    }
}
