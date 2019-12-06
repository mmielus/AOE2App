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
        
        Alamofire.request(url, method: .get)
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("err")
                    return
                }

                let value = response.result.value;
             

        }
    }
    
}

