//
//  MainViewModel.swift
//  UseCasesLocalRealm
//
//  Created by Ethan Kisiel on 7/7/22.
//

import Foundation

func getUserId() -> String
{
    // checks for a userId in UserDefaults. if it does not exist, a new UUID
    // string will be set as the current userId in UserDefaults.
    guard let userId = UserDefaults.standard.string(forKey: USER_ID_STRING)
    else
    {
        let userId = UUID().uuidString
        UserDefaults.standard.set(userId, forKey: USER_ID_STRING)
        return userId
    }

    return userId
}
