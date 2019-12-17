//
//  MainController.swift
//  mmielus
//
//  Created by user on 17/12/2019.
//  Copyright © 2019 Guest User. All rights reserved.
//
import UIKit
import Foundation
import Alamofire
import SVProgressHUD
class MainController : UIViewController{


    @IBOutlet weak var civilizations: UIButton!
    @IBOutlet weak var units: UIButton!
    
    @IBAction func navigateToCivilizationsView(_ sender: UIButton) {
         self.performSegue(withIdentifier: "Civilizations", sender: self)
    }
    @IBAction func navigateToUnitsView(_ sender: UIButton) {
         self.performSegue(withIdentifier: "Units", sender: self)
    }
    @IBAction func navigateToStructuresView(_ sender: UIButton) {
             self.performSegue(withIdentifier: "Structures", sender: self)
    }
    @IBAction func navigateToTechnologiesView(_ sender: UIButton) {
             self.performSegue(withIdentifier: "Technologies", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

