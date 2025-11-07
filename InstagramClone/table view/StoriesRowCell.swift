//
//  StoriesRowCell.swift
//  InstagramClone
//
//  Created by ROHIT on 03/09/25.
//

import UIKit

class StoriesRowCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    var users: [User] = []


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCell", for: indexPath) as! StoryCell
        
               let user = users[indexPath.item]
        cell.storyLbl.text = user.firstName
        if let url = URL(string: user.image) {
            URLSession.shared.dataTask(with: url) { data ,response,error in
                if let data = data ,
                   let img = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.imageView.image = img
                    }
                }
            }.resume()
                   
               }
                return cell
    }
        
        // Size of each story bubble
        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 70, height: 98) // smaller width reduces gap visually
        }
        
        // Horizontal spacing between bubbles
       func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 20 // reduce from default (usually 10)
        }
        
        // Left & right padding of the whole row
        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
    


    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Register StoryCell nib for collection view
            let nib = UINib(nibName: "StoryCell", bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: "StoryCell")

            collectionView.delegate = self
            collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
