//
//  MainViewModel.swift
//  UseCasesLocalRealm
//
//  Created by Ethan Kisiel on 7/7/22.
//

import Foundation

func getUserId() -> String
{
    // if a value for the UserId key does not exist, create a string UUID and set to UserId key
    guard let userId = UserDefaults.standard.string(forKey: USER_ID_STRING) else
    {
        let userId = UUID().uuidString
        UserDefaults.standard.set(userId, forKey: USER_ID_STRING)
        return userId
    }
    
    return userId
}
