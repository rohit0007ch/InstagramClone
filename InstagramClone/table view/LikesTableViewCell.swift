//
//  LikesTableViewCell.swift
//  InstagramClone
//
//  Created by ROHIT on 15/09/25.
//

import UIKit

class LikesTableViewCell: UITableViewCell {

  //  @IBOutlet weak var SeconfImgView: UIImageView!
    @IBOutlet weak var firstImgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        firstImgView.layer.cornerRadius = 22
        firstImgView.layer.masksToBounds = true
      /*  SeconfImgView.layer.cornerRadius = 73
        SeconfImgView.layer.masksToBounds = true */
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }
    
}
