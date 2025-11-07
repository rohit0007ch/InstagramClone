//
//  postTableViewCell.swift
//  InstagramClone
//
//  Created by ROHIT on 03/09/25.
//

import UIKit

class postTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var likeCountLbl: UILabel!
    @IBOutlet weak var usernamelabel: UILabel!
    @IBOutlet weak var CityLabel: UILabel!
    
    @IBOutlet weak var StateLabel: UILabel!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
  
   // let images = ["img1", "img2", "img3"]
    
    var users : [User] = []
  
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostCell
        let user = users[indexPath.item]
        
       if  let url = URL(string: user.image) {
            URLSession.shared.dataTask(with: url) { data ,response ,error in
                if let data = data, let img = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.postImg.image = img
                    }
                }
            }.resume()
        }
        
                return cell
    }
    // MARK: - Page Control
      func scrollViewDidScroll(_ scrollView: UIScrollView) {
          pageControl.numberOfPages = users.count
          let page = Int(scrollView.contentOffset.x / scrollView.frame.width)
         
          pageControl.currentPage = page

          counterLabel.text = "\(page + 1)/\(users.count) "

      }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

    
    @IBOutlet weak var LikedImage: UIImageView!
    
    @IBOutlet weak var PostCollectionView: UICollectionView!
    @IBOutlet weak var userImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        userImage.layer.cornerRadius = 18
        userImage.layer.masksToBounds = true
        LikedImage.layer.cornerRadius = 8.5
        LikedImage.layer.masksToBounds = true
        counterLabel.layer.cornerRadius = 13
        counterLabel.layer.masksToBounds = true
        // Initialization code
        let nib = UINib(nibName: "PostCell", bundle: nil)
        PostCollectionView.register(nib, forCellWithReuseIdentifier: "PostCell")

        PostCollectionView.delegate = self
        PostCollectionView.dataSource = self
        if let layout = PostCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                   //layout.minimumInteritemSpacing = 0
               }
               PostCollectionView.isPagingEnabled = true
        PostCollectionView.showsHorizontalScrollIndicator = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
