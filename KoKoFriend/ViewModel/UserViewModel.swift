//
//  UserViewModel.swift
//  KoKoFriend
//
//  Created by 江柏毅 on 2023/3/9.
//

import Foundation


class UserViewModel {
    var user: User
    
    var name: String {
        return user.name ?? ""
    }
    
    var kokoid: String {
        return user.kokoid ?? ""
    }
    
    init(user: User)
    {
        self.user = user
    }
}
