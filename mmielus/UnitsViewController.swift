//
//  UnitsViewController.swift
//  mmielus
//
//  Created by user on 17/12/2019.
//  Copyright © 2019 Guest User. All rights reserved.
//
import UIKit
import Foundation
import Alamofire
import SVProgressHUD

class UnitsViewController : UIViewController, UITableViewDelegate, UITableViewDataSource{
    var units: [Unit]? = []{
         didSet {
               
            }
     }
    var refreshControl = UIRefreshControl()
    let cellReuseIdentifier = "cell"
    
    @IBOutlet weak var unitsListView: UITableView!
    
    /*
     
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.units!.count
    }
    /*
     
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.unitsListView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)!
        SVProgressHUD.show()
        getAllUnits(){(data) in
          self.units = data
          cell.textLabel?.text = self.units![indexPath.row].name
        }
        SVProgressHUD.dismiss(withDelay: 1)
        return cell
    }
    /*
     
     */
    @objc func refresh(refreshControl: UIRefreshControl) {
        self.unitsListView.reloadData()
        refreshControl.endRefreshing()
      }
    
    /*
     
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        unitsListView.addSubview(refreshControl)
        unitsListView.delegate = self
        unitsListView.dataSource = self
        self.unitsListView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        getAllUnits(){(data) in
          self.units = data
          self.unitsListView.reloadData()
          }
    }

    /*
     
     */
    func  getAllUnits(completion: @escaping ([Unit]?) -> Void){
        guard let url = URL(string: "https://age-of-empires-2-api.herokuapp.com/api/v1/units")else{
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
                       print(value)
              let root = try decoder.decode(UnitRoot.self, from: value)
                       print(root)
              completion(root.units)
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
      self.performSegue(withIdentifier: "Unit", sender: self)
     }
    /*
     
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let unitViewController = segue.destination as? UnitViewController,
            let index = unitsListView.indexPathForSelectedRow?.row
            else {
            return
        }
        unitViewController.unitId = String(index+1)
    }
}
