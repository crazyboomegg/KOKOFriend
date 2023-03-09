//
//  FriendListViewModel.swift
//  KoKoFriend
//
//  Created by 江柏毅 on 2023/3/8.
//

import Foundation

protocol FriendListDelegate {
    func didFriendChange(friends: [FriendViewModel])
}

class FriendListViewModel {
    
    var friends = [FriendViewModel]() {
        didSet {
            delegate?.didFriendChange(friends: friends)
        }
    }
    var delegate: FriendListDelegate?
    
    var userInfo = [UserViewModel]()
    
//    func getInviteFriendList() {
//        friends.filter {$0.stataus == 2}
//    }
    
    func getFriend(success: @escaping () -> Void, fail: @escaping (String) -> Void) {
        let params = ["":""]
        
        ListResponse<Friend>.request(api: .friendOne, params: params) { res in
        guard res.isSuccess else { return }
        guard let v = res.value else { return }
        guard v.response.count != 0 else { return }
            
            var friends = [FriendViewModel]()
            
            for friend in v.response {
                friends.append(FriendViewModel(friend: friend))
            }
            self.friends = friends
            return success()
        }
    }
    
    func getFriendInvite(success: @escaping () -> Void, fail: @escaping (String) -> Void) {
        let params = ["":""]
        
        ListResponse<Friend>.request(api: .friendInvite, params: params) { res in
        guard res.isSuccess else { return }
        guard let v = res.value else { return }
        guard v.response.count != 0 else { return }
            
            var friends = [FriendViewModel]()
            
            for friend in v.response {
                friends.append(FriendViewModel(friend: friend))
            }
            self.friends = friends
            return success()
        }
    }
    
    
    
    func getUserInfo(success: @escaping () -> Void, fail: @escaping (String) -> Void) {
        let params = ["":""]
        
        ListResponse<User>.request(api: .userInfo, params: params) { res in
        guard res.isSuccess else { return }
        guard let v = res.value else { return }
        guard v.response.count != 0 else { return }
            
            var userInfo = [UserViewModel]()
            
            for user in v.response {
                userInfo.append(UserViewModel(user: user))
            }
            self.userInfo = userInfo
            return success()
        }
    }
}
