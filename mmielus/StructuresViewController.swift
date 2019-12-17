//
//  StructuresViewController.swift
//  mmielus
//
//  Created by user on 17/12/2019.
//  Copyright © 2019 Guest User. All rights reserved.
//
import UIKit
import Foundation
import SVProgressHUD
import Alamofire

class StructuresViewController : UIViewController, UITableViewDelegate, UITableViewDataSource{
    var structures: [Structure]? = []{
         didSet {
               
            }
     }
    var refreshControl = UIRefreshControl()
    let cellReuseIdentifier = "cell"
    
    @IBOutlet weak var structuresListView: UITableView!
    /*
     
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.structures!.count
    }
    /*
     
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.structuresListView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)!
        getAllStructures(){(data) in
          self.structures = data
          cell.textLabel?.text = self.structures![indexPath.row].name
        }
        return cell
    }
    /*
     
     */
    @objc func refresh(refreshControl: UIRefreshControl) {
        self.structuresListView.reloadData()
        refreshControl.endRefreshing()
      }
    
    /*
     
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        structuresListView.addSubview(refreshControl)
        structuresListView.delegate = self
        structuresListView.dataSource = self
        self.structuresListView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        getAllStructures(){(data) in
          self.structures = data
          self.structuresListView.reloadData()
          }
    }

    /*
     
     */
    func  getAllStructures(completion: @escaping ([Structure]?) -> Void){
        guard let url = URL(string: "https://age-of-empires-2-api.herokuapp.com/api/v1/structures")else{
            completion(nil)
            return
        }
    
        let req = Alamofire.request(url).validate().responseData{response in
            guard response.result.isSuccess, let value = response.data else{
                    completion(nil)
                    return
            }
            do{
              let decoder = JSONDecoder()
                       print(value)
              let root = try decoder.decode(StructureRoot.self, from: value)
                       print(root)
              completion(root.structures)
                       }catch let err{
                           print(err)
                       }
        }
        req.downloadProgress { (progress) in

            DispatchQueue.main.async() {
                           let percentage = Float(progress.fractionCompleted)
                            let test = percentage / Float(1.0)
                           let x = Int(test*100)

                             print(x)
                           if(x == 100){

                            SVProgressHUD.dismiss()

                           }else{
                         SVProgressHUD.setFadeInAnimationDuration(0.0)
                            SVProgressHUD.setFadeOutAnimationDuration(0.0)
                            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.clear)
                        SVProgressHUD.show()

                           }
        }
        }
       
        
  
                
   }
    
    /*
     
     */
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      self.performSegue(withIdentifier: "Structure", sender: self)
     }
    /*
     
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let structureViewController = segue.destination as? StructureViewController,
            let index = structuresListView.indexPathForSelectedRow?.row
            else {
            return
        }
         structureViewController.structureId = String(index+1)
    }
}
