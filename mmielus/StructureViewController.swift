//
//  StructureViewController.swift
//  mmielus
//
//  Created by user on 17/12/2019.
//  Copyright © 2019 Guest User. All rights reserved.
//
import UIKit
import Foundation
import Alamofire
import SVProgressHUD

class StructureViewController : UIViewController{
    var structureId : String = ""
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var structureDescription: UILabel!
    @IBOutlet weak var expansion: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var buildTime: UILabel!
    @IBOutlet weak var hitPoints: UILabel!
    @IBOutlet weak var lineOfSight: UILabel!
    @IBOutlet weak var armor: UILabel!
    @IBOutlet weak var reloadTime: UILabel!
    @IBOutlet weak var special: UILabel!
    
    
    override func viewDidLoad() {
             super.viewDidLoad()
         
            self.getStructureById(){(data) in
                    self.name.text = "Unit: " + (data?.name ?? "")
                    self.structureDescription.text = "Description: " + (data?.description ?? "")
                    self.expansion.text = "Expansion: " + (data?.expansion ?? "")
                    self.age.text = "Age: " + (data?.age ?? "")
                    self.cost.text = "Cost:";
                    self.cost.text! += "F:" + String(data?.cost?.food ?? 0)+" ";
                    self.cost.text! += "G:" + String(data?.cost?.gold ?? 0)+" ";
                    self.cost.text! += "S:" + String(data?.cost?.stone ?? 0)+" ";
                    self.cost.text! += "W:" + String(data?.cost?.wood ?? 0)+" ";
                    self.buildTime.text = "Build time: " + String(data?.build_time ?? 0)
                    self.hitPoints.text = "Hit points: " + String(data?.hit_points ?? 0)
                    self.lineOfSight.text = "Line of sight: " + String(data?.line_of_sight ?? 0 )
                    self.armor.text = "Armor: " + (data?.armor ?? "")
                    self.reloadTime.text = "Reload time: " + String(data?.reload_time ?? 0)
                    self.special.text = "Special: ";
                    for special in (data?.special)!{
                        self.special.text! += special + " "
                     }
               
                    
            }
        
         }
         /*
         
         */
         func  getStructureById(completion: @escaping (Structure?) -> Void){
            let baseUrl = "https://age-of-empires-2-api.herokuapp.com/api/v1/structure/";
            let url = URL(string: baseUrl+structureId)
            
             let req = Alamofire.request(url!).validate().responseData{ response in
                    guard response.result.isSuccess,
                        let value = response.data else{
                            completion(nil)
                            return
                    }
                    
                 do{
                    let decoder = JSONDecoder()
                    let root = try decoder.decode(Structure.self, from: value)
                               
                    completion(root)
                               }catch let err{
                                   print(err)
                               }
                }
                    req.downloadProgress { (progress) in
    
               
                                       let percentage = Float(progress.fractionCompleted)
                                        let test = percentage / Float(1.0)
                                       let x = Int(test*100)
                                       if(x == 100){
                                        SVProgressHUD.dismiss()
                                       }else{
                                    SVProgressHUD.show()
                                       }
                    
                    }
                        
        }
    }


