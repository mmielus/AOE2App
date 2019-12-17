//
//  ViewController.swift
//  mmielus
//
//  Created by Guest User on 06.12.2019.
//  Copyright © 2019 Guest User. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class CivilizationsController : UIViewController, UITableViewDelegate, UITableViewDataSource{
    var heroes: [Civilization]? = []{
         didSet {
               
            }
     }
    var refreshControl = UIRefreshControl()
    let cellReuseIdentifier = "cell"
    
    @IBOutlet weak var civilizationsListView: UITableView!
    
    /*
     
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.heroes!.count
    }
    /*
     
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.civilizationsListView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)!
        SVProgressHUD.show()
        getAllCivilizations(){(data) in
          self.heroes = data
          cell.textLabel?.text = self.heroes![indexPath.row].name
        }
        SVProgressHUD.dismiss(withDelay: 1)
        return cell
    }
    /*
     
     */
    @objc func refresh(refreshControl: UIRefreshControl) {
        self.civilizationsListView.reloadData()
        refreshControl.endRefreshing()
      }
    
    /*
     
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        civilizationsListView.addSubview(refreshControl)
        civilizationsListView.delegate = self
        civilizationsListView.dataSource = self
        self.civilizationsListView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        getAllCivilizations(){(data) in
          self.heroes = data
          self.civilizationsListView.reloadData()
          }
    }

    /*
     
     */
    func  getAllCivilizations(completion: @escaping ([Civilization]?) -> Void){
        guard let url = URL(string: "https://age-of-empires-2-api.herokuapp.com/api/v1/civilizations")else{
            completion(nil)
            return
        }
    
        _ = Alamofire.request(url).validate().responseData{response in
            guard response.result.isSuccess, let value = response.data else{
                    completion(nil)
                    return
            }
            do{
              let decoder = JSONDecoder()
              let root = try decoder.decode(CivilizationRoot.self, from: value)
              completion(root.civilizations)
                       }catch let err{
                           print(err)
                       }
        }
//        req.downloadProgress { (progress) in
//
//            DispatchQueue.main.async() {
//                           let percentage = Float(progress.fractionCompleted)
//                            let test = percentage / Float(1.0)
//                           let x = Int(test*100)
//
//                             print(x)
//                           if(x == 100){
//
//                            SVProgressHUD.dismiss()
//
//                           }else{
//                         SVProgressHUD.setFadeInAnimationDuration(0.0)
//                            SVProgressHUD.setFadeOutAnimationDuration(0.0)
//                            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.clear)
//                        SVProgressHUD.show()
//
//                           }
//        }
//        }
       
        
  
                
   }
    
    /*
     
     */
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      self.performSegue(withIdentifier: "Civilization", sender: self)
     }
    /*
     
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let civilizationViewController = segue.destination as? CivilizationController,
            let index = civilizationsListView.indexPathForSelectedRow?.row
            else {
            return
        }
        civilizationViewController.civilizationId = String(index+1)
    }
}
