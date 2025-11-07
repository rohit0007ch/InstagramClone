//
//  CollectionViewCell.swift
//  InstagramClone
//
//  Created by ROHIT on 03/09/25.
//

import UIKit

class StoryCell: UICollectionViewCell {

    @IBOutlet weak var storyLbl: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 35
        imageView.layer.masksToBounds = true
    }

}
