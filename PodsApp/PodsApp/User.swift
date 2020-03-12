//
//  User.swift
//  PodsApp
//
//

import Foundation

class User {

    var name : String
    var age : String
    var bio : String
    var image : String

    init( name: String, age: String, bio: String, image: String) {
        self.name = name
        self.age = age
        self.bio = bio
        self.image = image
    }
}
