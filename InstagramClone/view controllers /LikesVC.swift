//
//  LikesVC.swift
//  InstagramClone
//
//  Created by ROHIT on 15/09/25.
//

import UIKit

class LikesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "likescell", for: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    @IBOutlet weak var likesTblview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "LikesTableViewCell", bundle: nil)
        likesTblview.register(nib, forCellReuseIdentifier: "likescell")
        likesTblview.delegate = self
        likesTblview.dataSource = self

    }
    

 

}
