// UserResponse is now just an array of User objects (no coding required).
import Foundation
class User : Codable{
    var id: Int
    var firstName: String
    var lastName: String
    var image: String
    var address: Address

  
}

class Address : Codable{
    var address: String
    var city: String
    var state: String

}

class UserResponse : Codable {
    var users : [User]
}
