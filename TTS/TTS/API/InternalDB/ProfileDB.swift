//
//  ProfileDB.swift
//  TTS
//
//  Created by Lee Jun Young on 2022/09/08.
//

import UIKit

struct ProfileData: Codable {
    let email: String
}

class ProfileDB: InternalDB {
    typealias DataType = ProfileData
    
    var key = "Profile"
    
    static let shared = ProfileDB()
    
    private init() {}
    
    func get() -> ProfileData {
        return _get() ?? ProfileData(email: "-")
    }
    
    func save(profile: ProfileData) {
        _save(data: profile)
    }
}

