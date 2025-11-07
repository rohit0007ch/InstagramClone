//
//  LoginVC.swift
//  InstagramClone
//
//  Created by ROHIT on 29/08/25.
//

import UIKit
import CoreData

class LoginVC: UIViewController {
    // MARK: - Properties
    var loggedInUser: UserAccountEntity?
    
    // MARK: - Outlets
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    /* @IBOutlet weak var logolbl: UILabel!*/
    
    override func viewDidLoad() {
            super.viewDidLoad()
            loginBtn.layer.cornerRadius = 5
            loginBtn.layer.masksToBounds = true
        }
        
        // MARK: - Alert Helper
        func showAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
        
        // MARK: - Login Button Action
        @IBAction func loginTapped(_ sender: Any) {
            
            // Step 1: Validate input
            guard let username = usernameField.text, !username.isEmpty,
                  let password = passField.text, !password.isEmpty else {
                showAlert(title: "Missing Information", message: "Please enter both username and password.")
                return
            }
            
            // Step 2: Fetch matching user from Core Data
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<UserAccountEntity> = UserAccountEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "username == %@ AND password == %@", username, password)
            fetchRequest.fetchLimit = 1
            
            do {
                if let loggedInUser = try context.fetch(fetchRequest).first {
                    print("✅ Login successful for: \(loggedInUser.username ?? "")")
                    
                    // 1. Get the TabBarVC from storyboard
                    guard let tabBarVC = storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as? UITabBarController else {
                        print("❌ TabBarVC not found")
                        return
                    }

                    // 2. Find ProfileVC inside TabBarVC (even if it’s inside a NavigationController)
                    if let viewControllers = tabBarVC.viewControllers {
                        for vc in viewControllers {
                            if let nav = vc as? UINavigationController {
                                for child in nav.viewControllers {
                                    if let profileVC = child as? ProfileVC {
                                        profileVC.user = loggedInUser
                                        print("➡️ Passed user \(loggedInUser.username ?? "") to ProfileVC")
                                    }
                                }
                            } else if let profileVC = vc as? ProfileVC {
                                profileVC.user = loggedInUser
                                print("➡️ Passed user \(loggedInUser.username ?? "") to ProfileVC (no nav)")
                            }
                        }
                    }

                    // 3. Set TabBarVC as root (not push)
                    if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
                       let window = sceneDelegate.window {
                        window.rootViewController = tabBarVC
                        window.makeKeyAndVisible()
                        UIView.transition(with: window,
                                          duration: 0.4,
                                          options: .transitionCrossDissolve,
                                          animations: nil,
                                          completion: nil)
                    } else {
                        UIApplication.shared.keyWindow?.rootViewController = tabBarVC
                    }

                } else {
                    showAlert(title: "Login Failed", message: "Invalid username or password")
                }

                    } catch {
                        print("❌ Core Data fetch error: \(error)")
                    }
                }
        
        @IBAction func signUpTapped(_ sender: Any) {
            self.navigationController?.popViewController(animated: true)
        }
    }

