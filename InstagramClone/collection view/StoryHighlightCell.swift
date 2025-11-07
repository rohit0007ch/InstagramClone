//
//  StoryHighlightCell.swift
//  InstagramClone
//
//  Created by ROHIT on 02/09/25.
//

import UIKit

class StoryHighlightCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 35
        imageView.layer.masksToBounds = true 
    }

}
