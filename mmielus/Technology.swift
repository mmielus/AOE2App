//
//  Technology.swift
//  mmielus
//
//  Created by user on 17/12/2019.
//  Copyright © 2019 Guest User. All rights reserved.
//

import Foundation

struct TechnologyRoot : Decodable {
    
    private enum  CodingKeys: String, CodingKey { case technologies}
    
    let technologies : [Technology]
}
struct Technology : Codable {

    
    var id : Int?
    var name: String?
    var description : String?
    var expansion : String?
    var age : String?
    var develops_in : String?
    var cost : [String]?
    var build_time : Int?
    var aplies_to : [String]?

  
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case expansion
        case age
        case develops_in
        case cost
        case build_time
        case aplies_to
    }
}
