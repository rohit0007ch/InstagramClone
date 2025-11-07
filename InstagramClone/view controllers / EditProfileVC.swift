//
//  EditProfileVCViewController.swift
//  InstagramClone
//
//  Created by ROHIT on 11/09/25.
//

import UIKit
import CoreData

class EditProfileVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    // MARK: - Properties
        var user: UserAccountEntity?
    
    // Holds the picked profile image
    var selectedProfileImage: UIImage?
    
    // MARK: - Outlets
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var bioField: UITextField!
    @IBOutlet weak var webField: UITextField!
    @IBOutlet weak var NameField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var EditProfileImg: UIImageView!
    
    // MARK: - Lifecycle
        override func viewDidLoad() {
            super.viewDidLoad()
            self.navigationItem.hidesBackButton = true 
            EditProfileImg.layer.cornerRadius = 47.5
            EditProfileImg.layer.masksToBounds = true
            loadUserDetails()
        }

        // MARK: - Load User Details
        private func loadUserDetails() {
            guard let user = user else { return }
            NameField.text = user.fullname
            usernameField.text = user.username
            webField.text = user.website
            bioField.text = user.bio
            emailField.text = user.email
            phoneField.text = String(user.phonenumber)
            if let imageData = user.editprofilephoto {
                EditProfileImg.image = UIImage(data: imageData)
            }

        }
    @IBAction func changeProfilePhoto(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
        
    }
    // Called after picking image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true)
        
        // Get edited image if available, else original
        if let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
            selectedProfileImage = image
            EditProfileImg.image = image  // show it immediately in the UIImageView
        }
    }

    // Called if the user cancels
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

        // MARK: - Save Changes
        @IBAction func doneBtn(_ sender: Any) {
            guard let user = user else { return }
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            // Update user info
            user.fullname = NameField.text
            user.username = usernameField.text
            user.website = webField.text
            user.bio = bioField.text
            // Update profile image
                  if let selectedImage = selectedProfileImage {
                      user.editprofilephoto = selectedImage.jpegData(compressionQuality: 0.8)
                  }
            
            do {
                try context.save()
                print("✅ Profile updated successfully")
                // Navigate back to ProfileVC
                       navigationController?.popViewController(animated: true)
            } catch {
                print("❌ Failed to save updated profile: \(error)")
            }
        }
    @IBAction func cancelBtn(_ sender: Any) {
        if let nav = navigationController {
               nav.popViewController(animated: true)
           } else {
               dismiss(animated: true)
           }
    }
}
