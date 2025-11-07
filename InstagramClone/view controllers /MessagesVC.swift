//
//  MessagesVC.swift
//  InstagramClone
//
//  Created by ROHIT on 10/09/25.
//

import UIKit

class MessagesVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var msgTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        // Remove separator line
           searchBar.backgroundImage = UIImage()
        let nib = UINib(nibName: "MessagesTableViewCell", bundle: nil)
        msgTblView.register(nib, forCellReuseIdentifier: "msgCell")
        msgTblView.delegate = self
        msgTblView.dataSource = self

        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = msgTblView.dequeueReusableCell(withIdentifier: "msgCell", for: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }

   /* func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let spacer = UIView()
        spacer.backgroundColor = .clear // transparent space
        return spacer
    }*/
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
