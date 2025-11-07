//
//  HomeVC.swift
//  InstagramClone
//
//  Created by ROHIT on 03/09/25.
//

import UIKit

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var arrUsers: [User] = []
    
    @IBOutlet weak var tblView: UITableView!
    
    @IBOutlet weak var headerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // fetchUsers()
        tblView.delegate = self
        tblView.dataSource = self
        
        // Register Stories Row Cell
        tblView.register(
            UINib(nibName: "StoriesRowCell", bundle: nil),
            forCellReuseIdentifier: "StoriesRowCell"
        )
        
        // Register Post Cell
        tblView.register(
            UINib(nibName: "postTableViewCell", bundle: nil),
            forCellReuseIdentifier: "postTableViewCell")
        
        
        //  Fetch users
        HomeVM.shared.fetchUsers { users in
            self.arrUsers = users
            self.tblView.reloadData()
        }
        
    }
   


    // MARK: - TableView DataSource
       
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return 1 + arrUsers.count  // 1 row for stories + N posts
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
           if indexPath.row == 0 {
               //  First row = Stories
               let cell = tableView.dequeueReusableCell(withIdentifier: "StoriesRowCell", for: indexPath) as! StoriesRowCell
               cell.users = arrUsers   //  Pass data to stories row
                 cell.collectionView.reloadData()  //  Reload collection view after assigning users
                 return cell
              
           }
           
           //  Other rows = Posts
           let cell = tableView.dequeueReusableCell(withIdentifier: "postTableViewCell", for: indexPath) as! postTableViewCell
           let user = arrUsers[indexPath.row - 1]
           cell.users = arrUsers
           cell.usernamelabel.text = user.firstName
           cell.StateLabel.text = user.address.state
           cell.CityLabel.text = user.address.city
           
           
           // Load profile image
           if let url = URL(string: user.image) {
               URLSession.shared.dataTask(with: url) { data, _, _ in
                   if let data = data, let img = UIImage(data: data) {
                       DispatchQueue.main.async {
                           cell.userImage.image = img
                       }
                   }
               }.resume()
           }
           
           return cell
       }
       
            // MARK: - TableView Delegate
            
            func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                if indexPath.row == 0 {
                    return 120 // height for stories
                }
                return 560 // height for posts
            }
    @IBAction func DmBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MessagesVC") as! MessagesVC
        navigationController?.pushViewController(vc, animated: true)
    }
        }
    


