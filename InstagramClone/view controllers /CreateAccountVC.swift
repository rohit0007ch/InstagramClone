//
//  CreateAccountVC.swift
//  InstagramClone
//
//  Created by ROHIT on 29/09/25.
//

import UIKit
import CoreData

class CreateAccountVC: UIViewController {
    
   // var user: UserAccountEntity?   // set before presenting/pushing
    
    // MARK: - Outlets
    @IBOutlet weak var PasswordField: UITextField!
    @IBOutlet weak var PhoneNumberField: UITextField!
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var UsernameField: UITextField!
    @IBOutlet weak var FullNameField: UITextField!
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Navigation
    @IBAction func AlreadyAccountBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func CreateAccountBtn(_ sender: Any) {
        // Local alert helper
               func showAlert(title: String, message: String) {
                   let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "OK", style: .default))
                   present(alert, animated: true)
               }

               // Input validation
               guard let username = UsernameField.text, !username.isEmpty,
                     let fullname = FullNameField.text, !fullname.isEmpty,
                     let email = EmailField.text, !email.isEmpty,
                     let password = PasswordField.text, !password.isEmpty else {
                   showAlert(title: "Missing Information", message: "Please fill out all required fields.")
                   return
               }
        
        // Check if username already exists
               if isUsernameTaken(username) {
                   showAlert(title: "Username Taken", message: "This username already exists. Please choose another.")
                   return
               }

        
        // Get a reference to the Core Data context
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        //  Create and save the new user account
        let user = UserAccountEntity(context: context)
        user.username = UsernameField.text
        user.fullname = FullNameField.text
        user.email = EmailField.text
        user.phonenumber = Int64(PhoneNumberField.text ?? "0") ?? 0
        user.password = PasswordField.text
        user.bio = ""
        user.website = ""

        do {
                  try context.save()
                  print("✅ Account created successfully for \(username)")
                  
                  // Go to login screen with pre-filled user info
                  let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                  loginVC.loggedInUser = user
                  navigationController?.pushViewController(loginVC, animated: true)
              } catch {
                  print("❌ Failed to save account: \(error)")
              }
          }
    
    
    // MARK: - Username check
       private func isUsernameTaken(_ username: String) -> Bool {
           let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
           let request: NSFetchRequest<UserAccountEntity> = UserAccountEntity.fetchRequest()
           request.predicate = NSPredicate(format: "username == %@", username)
           request.fetchLimit = 1
           do {
               return try !context.fetch(request).isEmpty
           } catch {
               print("❌ Username check failed: \(error)")
               return false
           }
       }
   }
