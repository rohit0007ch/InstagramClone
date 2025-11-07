//
//  ProfileVC.swift
//  InstagramClone
//
//  Created by ROHIT on 06/09/25.
//

import UIKit
import CoreData

class ProfileVC: UIViewController,
                 UICollectionViewDelegate,
                 UICollectionViewDataSource,
                 UICollectionViewDelegateFlowLayout {
   
    // MARK: - User (received from LoginVC)
        var user: UserAccountEntity?
    var isDrawerOpen = false  // Track drawer state

    // MARK: - Outlets
    @IBOutlet weak var drawerTrailingConstraint: NSLayoutConstraint!
   
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var dimView: UIView!
    @IBOutlet weak var namelbl: UILabel!
    @IBOutlet weak var usernameBtn: UIButton!
    @IBOutlet weak var WebsiteLbl: UILabel!
    @IBOutlet weak var bioLbl: UILabel!
    @IBOutlet weak var storyHighlight: UICollectionView!   // Top horizontal "Story Highlights"
    @IBOutlet weak var collectionView: UICollectionView!   // Grid of profile posts
    @IBOutlet weak var profileImgView: UIImageView!        // User profile image
    
    
    
     // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        profileImgView.layer.cornerRadius = 45
        profileImgView.layer.masksToBounds = true
        guard let user = user else {
            print("⚠️ No user passed to ProfileVC. Fallback fetch is for development only.")
            // Uncomment below only if you REALLY want fallback
            // fetchCurrentUser()
            return
        }
        print("✅ ProfileVC loaded for \(user.username ?? "Unknown") (passed from previous VC)")
        loadUserData()
    }

    // ✅ Refresh user data after editing profile
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let user = user {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            if let refreshedUser = try? context.existingObject(with: user.objectID) as? UserAccountEntity {
                self.user = refreshedUser
                loadUserData()
                print("🔄 ProfileVC refreshed after edit")
            }
        }
    }

    // MARK: - Setup
    private func setupUI() {
        let postNib = UINib(nibName: "ProfilePostCell", bundle: nil)
        collectionView.register(postNib, forCellWithReuseIdentifier: "Profilepostcell")
        collectionView.delegate = self
        collectionView.dataSource = self

        let storyNib = UINib(nibName: "StoryHighlightCell", bundle: nil)
        storyHighlight.register(storyNib, forCellWithReuseIdentifier: "story")
        storyHighlight.delegate = self
        storyHighlight.dataSource = self
    }
    private func fetchCurrentUser() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request: NSFetchRequest<UserAccountEntity> = UserAccountEntity.fetchRequest()
        request.fetchLimit = 1

        do {
            let users = try context.fetch(request)
            if let user = users.first {
                self.user = user
                loadUserData()
            }
        } catch {
            print("❌ Fetch failed: \(error)")
        }
    }


    // MARK: - Load User Data
    private func loadUserData() {
        guard let user = user else {
            print("⚠️ No user passed to ProfileVC")
          return } 
        namelbl.text = user.fullname
        usernameBtn.setTitle("@\(user.username ?? "")", for: .normal)
        WebsiteLbl.text = user.website ?? ""
        bioLbl.text = user.bio ?? ""
        if let imageData = user.editprofilephoto {
                    profileImgView.image = UIImage(data: imageData)
                }
        print("✅ ProfileVC loaded for \(user.username ?? "")")
    }

    // MARK: - Edit Profile
    @IBAction func editBtn(_ sender: Any) {
        if let editVC = storyboard?.instantiateViewController(withIdentifier: "EditProfileVC") as? EditProfileVC {
            editVC.user = user // Pass user to edit screen
            navigationController?.pushViewController(editVC, animated: true)
        }
    }

    // MARK: - Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == storyHighlight ? 10 : 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == storyHighlight {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "story", for: indexPath)
        } else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "Profilepostcell", for: indexPath)
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == storyHighlight {
            return CGSize(width: 70, height: 98)
        }
        let spacing: CGFloat = 1
        let cellWidth = (collectionView.frame.width - 2 * spacing) / 3
        return CGSize(width: cellWidth, height: cellWidth)
    }
  
    @IBAction func logoutBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
}
