//
//  Unit.swift
//  mmielus
//
//  Created by user on 17/12/2019.
//  Copyright © 2019 Guest User. All rights reserved.
//

import Foundation

struct UnitRoot : Decodable {
    
    private enum  CodingKeys: String, CodingKey { case units}
    
    let units : [Unit]
}
struct Unit : Codable {

    
    var id : Int?
    var name: String?
    var description : String?
    var expansion : String?
    var age : String?
//    var created_in : String?
    var cost : Cost?
    var build_time : Int?
    var reload_time : Float?
    var attack_delay : Float?
    var movement_rate : Float?
    var line_of_sight : Int?
    var hit_points : Int?
    var range : String?
    var attack : Int?
    var armor : String?
    var accuracy : String?
  
     init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           let ratingString = try? container.decode(String.self, forKey: .range)
           let ratingInt = try? container.decode(Int.self, forKey: .range)
           self.range = ratingString ?? (ratingInt == 0 ? String(0) : String(ratingInt ?? 0))
          self.id = try? container.decode(Int.self, forKey: .id)
          self.description = try? container.decode(String.self, forKey: .description)
          self.expansion = try? container.decode(String.self, forKey: .expansion)
          self.age = try? container.decode(String.self, forKey: .age)
          self.cost = try? container.decode(Cost.self, forKey: .cost)
          self.build_time = try? container.decode(Int.self, forKey: .build_time)
          self.reload_time = try? container.decode(Float.self, forKey: .reload_time)
          self.attack_delay = try? container.decode(Float.self, forKey: .attack_delay)
          self.movement_rate = try? container.decode(Float.self, forKey: .movement_rate)
          self.line_of_sight = try? container.decode(Int.self, forKey: .line_of_sight)
          self.hit_points = try? container.decode(Int.self, forKey: .hit_points)
          self.attack = try? container.decode(Int.self, forKey: .attack)
          self.armor = try? container.decode(String.self, forKey: .armor)
          self.accuracy = try? container.decode(String.self, forKey: .accuracy)
          self.name = try? container.decode(String.self, forKey: .name)
        
         
       }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case expansion
        case age
//        case created_in
        case cost
        case build_time
        case reload_time
        case attack_delay
        case movement_rate
        case line_of_sight
        case hit_points
        case range
        case attack
        case armor
        case accuracy
    }
}

struct Cost : Codable{
    var wood : Int?
    var food: Int?
    var stone: Int?
    var gold: Int?
    
        private enum CodingKeys: String, CodingKey {
            case wood = "Wood"
            case food = "Food"
            case stone = "Stone"
            case gold = "Gold"
      
        }
}
