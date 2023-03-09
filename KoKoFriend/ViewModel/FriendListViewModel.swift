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
    var filterFriend = [FriendViewModel]()

    
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
    

    
    func getMergeFriend(success: @escaping () -> Void, fail: @escaping (String) -> Void) {
        let params = ["":""]
        var friends = [FriendViewModel]()

        ListResponse<Friend>.request(api: .friendOne, params: params) { res1 in
            ListResponse<Friend>.request(api: .friendTwo, params: params) { res2 in
                guard res1.isSuccess, res2.isSuccess, let v1 = res1.value, let v2 = res2.value else {
                    fail("Failed to get friend list")
                    return
                }
                friends = v1.response.map { FriendViewModel(friend: $0) } + v2.response.map { FriendViewModel(friend: $0) }
                let fidToResponse = Dictionary(grouping: friends, by: { $0.fid as! String })
                let mergedResponse = fidToResponse.values.compactMap {
                    $0.max { ($0.updateDate as! String) < ($1.updateDate as! String) }
                }
                self.friends = mergedResponse
                success()
            }
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
