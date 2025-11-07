//
//  MessagesTableViewCell.swift
//  InstagramClone
//
//  Created by ROHIT on 10/09/25.
//

import UIKit

class MessagesTableViewCell: UITableViewCell {

    @IBOutlet weak var messageImgView: UIImageView!
    @IBOutlet weak var messageView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        messageImgView.layer.cornerRadius = 32
        messageImgView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
