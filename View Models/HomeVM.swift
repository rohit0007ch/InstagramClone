//
//  HomeVM.swift
//  InstagramClone
//
//  Created by ROHIT on 18/09/25.
//

import Foundation
class HomeVM {
    static let shared = HomeVM()
    
    func fetchUsers( completion:@escaping (([User]) -> Void)) {
        let urlString = "https://dummyjson.com/users"
        guard let url = URL(string: urlString)
        else { return }
        
        let task = URLSession.shared.dataTask(with: url) { Data , URLResponse, Error in
            if let error = Error {
                print("Error : \(error.localizedDescription)")
                return
            }
            guard let data = Data else {
                print("no data found")
                return
            }
            do {
                let decode = try JSONDecoder().decode(UserResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(decode.users)
                }
            }
            catch {
                print("Error Parsing Json\(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
