//
//  ProfileViewModel.swift
//  CoffeeApp
//
//  Created by Şevval Mertoğlu on 19.04.2025.
//

import Foundation

class ProfileViewModel {
    
    var userEmail: String {
        return UserDefaults.standard.string(forKey: "userEmail") ?? "Mail bulunamadı"
    }
    
    func logout() {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        UserDefaults.standard.set(nil, forKey: "userEmail")
        UserDefaults.standard.set(nil, forKey: "userPassword")
    }
}

