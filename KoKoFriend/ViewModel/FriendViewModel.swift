//
//  FriendViewModel.swift
//  KoKoFriend
//
//  Created by 江柏毅 on 2023/3/8.
//

import Foundation


class FriendViewModel {
    
    var friend: Friend
    
    var name: String {
        return friend.name ?? ""
    }
    
    var status: Int {
        return friend.status ?? 0
    }
    
    var isTop: String {
        return friend.isTop ?? ""
    }
    
    var fid: String {
        return friend.fid ?? ""
    }
    
    var updateDate: String {
        return friend.updateDate ?? ""
    }
    
    init(friend: Friend)
    {
        self.friend = friend
    }
    
}
