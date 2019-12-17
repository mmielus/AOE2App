//
//  UnitViewController.swift
//  mmielus
//
//  Created by user on 17/12/2019.
//  Copyright © 2019 Guest User. All rights reserved.
//
import Foundation
import Alamofire
import SVProgressHUD

class UnitViewController : UIViewController{

    var unitId : String!

    @IBOutlet weak var unitName: UILabel!
    @IBOutlet weak var unitDescription: UILabel!
    @IBOutlet weak var expansion: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var buildTime: UILabel!
    @IBOutlet weak var reloadTime: UILabel!
    @IBOutlet weak var attackDelay: UILabel!
    @IBOutlet weak var movementRate: UILabel!
    @IBOutlet weak var lineOfSight: UILabel!
    @IBOutlet weak var hitPoints: UILabel!
    @IBOutlet weak var range: UILabel!
    @IBOutlet weak var attack: UILabel!
    @IBOutlet weak var armor: UILabel!
    @IBOutlet weak var accuracy: UILabel!
    
    override func viewDidLoad() {
         super.viewDidLoad()
     
        self.getUnitById(){(data) in
                self.unitName.text = "Unit: " + (data?.name ?? "")
                self.unitDescription.text = "Description: " + (data?.description ?? "")
                self.expansion.text = "Expansion: " + (data?.expansion ?? "")
                self.age.text = "Age: " + (data?.age ?? "")
                self.cost.text = "Cost:";
                self.cost.text! += "F:" + String(data?.cost?.food ?? 0)+" ";
                self.cost.text! += "G:" + String(data?.cost?.gold ?? 0)+" ";
                self.cost.text! += "S:" + String(data?.cost?.stone ?? 0)+" ";
                self.cost.text! += "W:" + String(data?.cost?.wood ?? 0)+" ";
                self.buildTime.text = "Build time: " + String(data?.build_time ?? 0)
                self.reloadTime.text = "Reload time: " + String(data?.reload_time ?? 0)
                self.attackDelay.text = "Attack delay: " + String(data?.attack_delay ?? 0)
                self.movementRate.text = "Movement rate: " + String(data?.movement_rate ?? 0)
                self.lineOfSight.text = "Line of sight: " + String(data?.line_of_sight ?? 0 )
                self.hitPoints.text = "Hit points: " + String(data?.hit_points ?? 0)
                self.range.text = "Range: " + (data?.range ?? "")
                self.attack.text = "Attack: " + String(data?.attack ?? 0)
                self.armor.text = "Armor: " + (data?.armor ?? "")
                self.accuracy.text = "Accuracy: " + (data?.accuracy ?? "")
        }
    
     }
     /*
     
     */
     func  getUnitById(completion: @escaping (Unit?) -> Void){
        let baseUrl = "https://age-of-empires-2-api.herokuapp.com/api/v1/unit/";
        let url = URL(string: baseUrl+unitId)
        
           Alamofire.request(url!).validate().responseData{ response in
                guard response.result.isSuccess,
                    let value = response.data else{
                        completion(nil)
                        return
                }
                
             do{
                let decoder = JSONDecoder()
                let root = try decoder.decode(Unit.self, from: value)
                           
                completion(root)
                           }catch let err{
                               print(err)
                           }
            }
//                req.downloadProgress { (progress) in
//
//                    DispatchQueue.main.async() {
//                                   let percentage = Float(progress.fractionCompleted)
//                                    let test = percentage / Float(1.0)
//                                   let x = Int(test*100)
//
//                                     print(x)
//                                   if(x == 100){
//
//                                    SVProgressHUD.dismiss()
//
//                                   }else{
//
//                                SVProgressHUD.show()
//
//                                   }
//                }
//                }
                    
    }
}

