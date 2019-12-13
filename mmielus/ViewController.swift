//
//  ViewController.swift
//  mmielus
//
//  Created by Guest User on 06.12.2019.
//  Copyright © 2019 Guest User. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getAllCivilizations();
    }

    @IBOutlet weak var civilizationsListView: UITableView!
    
    
    func getAllCivilizations() {
        guard let url = URL(string: "https://age-of-empires-2-api.herokuapp.com/api/v1/civilizations") else {
            return
        }
        
//
//        Alamofire.request(url).responseJSON { response in
//
//                if let json = response.result.value as? [String:Any], // <- Swift Dictionary
//                    let results = json["civilizations"] as? [[String:Any]]  { // <- Swift Array
//
//                    for result in results {
//                        print(result["name"] as! String)
//
//                    }
//                    }
//
//                }
        
        
        
        
            Alamofire.request(url).responseData { response in
                let json = response.data
                var heroes = [Civilization]()
                do{
                    let decoder = JSONDecoder()
                    //using the array to put values
                    let root = try decoder.decode(Root.self, from: json!)
                    print(root.civilizations)
                }catch let err{
                    print(err)
                }
        }
        }

}

