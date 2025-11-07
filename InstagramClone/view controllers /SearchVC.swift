//
//  SearchVC.swift
//  InstagramClone
//
//  Created by ROHIT on 11/09/25.
//

import UIKit

class SearchVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
  

    @IBOutlet weak var ExpCollectView: UICollectionView!
    @IBOutlet weak var idSearchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "ExploreCell", bundle: nil)
        ExpCollectView.register(nib, forCellWithReuseIdentifier: "FeedCell")
        ExpCollectView.delegate = self
        ExpCollectView.dataSource = self
        idSearchBar.backgroundImage = UIImage()
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 200
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCell", for: indexPath)
                
                  return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        let numberOfColumns: CGFloat = 3 // Number of columns = 3
        let spacing: CGFloat = 1// The spacing between cells
        let totalSpacing = (2 * spacing) // since there are three columns, there will be two spaces
        let cellWidth = (collectionView.frame.width - totalSpacing) / 3
        return CGSize(width: cellWidth, height: cellWidth)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0 // spacing between columns
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1 // 👈 row spacing
    }


}
