//
//  CivilizationController.swift
//  mmielus
//
//  Created by user on 16/12/2019.
//  Copyright © 2019 Guest User. All rights reserved.
//

import Foundation
import Alamofire
import SVProgressHUD

class CivilizationController : UIViewController{	
//    ,UITableViewDelegate, UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//
    
    
    @IBOutlet weak var civilizationName: UILabel!
    @IBOutlet weak var armyType: UILabel!
    @IBOutlet weak var civilizationBonus: UILabel!
    @IBOutlet weak var expansion: UILabel!
    @IBOutlet weak var teamBonus: UILabel!
    
    var civilizationId : String!

    @IBOutlet weak var civilizationDetailsView: UITableView!
    
    override func viewDidLoad() {
         super.viewDidLoad()
     
            getCivilizationById(){(data) in
                self.civilizationName.text = "Civilization: " + (data?.name ?? "")
                self.armyType.text = "Army type: " + (data?.army_type ?? "")
                self.civilizationBonus.text = "Civilization bonuses: "
                for civilizationBonus in (data?.civilization_bonus)!{
                    self.civilizationBonus.text! += " \n" + civilizationBonus
                }
            
                self.teamBonus.sizeToFit()
                self.expansion.text = "Expansion: " + (data?.expansion ?? "")
                self.teamBonus.text = "Team bonus: " + (data?.team_bonus ?? "")
        }
    
     }
     /*
     
     */
     func  getCivilizationById(completion: @escaping (Civilization?) -> Void){
        let baseUrl = "https://age-of-empires-2-api.herokuapp.com/api/v1/civilization/";
        let url = URL(string: baseUrl+civilizationId)
        
           Alamofire.request(url!).validate().responseData{ response in
                guard response.result.isSuccess,
                    let value = response.data else{
                        completion(nil)
                        return
                }
                
             do{
                let decoder = JSONDecoder()
                let root = try decoder.decode(Civilization.self, from: value)
                           
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

