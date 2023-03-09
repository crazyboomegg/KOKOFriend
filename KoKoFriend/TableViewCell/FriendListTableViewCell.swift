//
//  FriendListTableViewCell.swift
//  KoKoFriend
//
//  Created by 江柏毅 on 2023/3/8.
//

import Foundation
import UIKit

class FriendListTableViewCell: UITableViewCell {
    
    var friend: FriendViewModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            addUI()
            addConstraints()
            contentView.backgroundColor = UIColor.white
            
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    
    func bind(friends: FriendViewModel) {
        self.idLabel.text = friends.name
        if friends.isTop == "0" {
            self.starImage.isHidden = true
        } else {
            self.starImage.isHidden = false
        }
       
        switch friends.status {
            
        case 0:
            inviteButton.isHidden = false
            nonImage.isHidden = true
            break
        case 1:
            inviteButton.isHidden = true
            nonImage.isHidden = false
            break
        case 2:
            inviteButton.isHidden = false
            nonImage.isHidden = true
            break
        default:
            break
        }
    }
    
    
    
    func addUI() {
        [starImage, profileImage, idLabel, transferButton, inviteButton, nonImage, lineView].forEach { (view) in
            contentView.addSubview(view)
        }
    }
    
    func addConstraints() {
        starImage.snp.makeConstraints { make in
            make.height.equalTo(14)
            make.width.equalTo(14)
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView.snp.left).offset(30)
        }
        
        profileImage.snp.makeConstraints { make in
            make.centerY.equalTo(starImage)
            make.left.equalTo(starImage.snp.right).offset(6)
            make.top.equalTo(contentView.snp.top).offset(10)
        }
        
        idLabel.snp.makeConstraints { make in
            make.centerY.equalTo(profileImage)
            make.left.equalTo(profileImage.snp.right).offset(15)
        }
        
        transferButton.snp.makeConstraints { make in
            make.centerY.equalTo(idLabel)
            make.right.equalTo(inviteButton.snp.left).offset(-10)
            make.width.equalTo(47)
            make.height.equalTo(24)
        }
        
        inviteButton.snp.makeConstraints { make in
            make.centerY.equalTo(transferButton)
            make.right.equalTo(contentView.snp.right).offset(-20)
            make.width.equalTo(60)
            make.height.equalTo(24)
        }
        
        nonImage.snp.makeConstraints { make in
            make.centerY.equalTo(transferButton)
            make.right.equalTo(contentView.snp.right).offset(-30)
        }
        
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(idLabel.snp.bottom).offset(19)
            make.left.equalTo(idLabel.snp.left).offset(0)
            make.right.equalTo(contentView.snp.right).offset(-30)
        }
        
    }
    
    private var starImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_friends_star")
        imageView.layer.cornerRadius = 15
        return imageView
    }()
   
    private var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "img_friends_female_default")
        imageView.layer.cornerRadius = 30
        return imageView
    }()
    
    private var idLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(hexString: "#474747")
        label.text = "江博弈"
        return label
    }()
    
    private var transferButton: UIButton = {
        let button = UIButton()
        button.setTitle("轉帳", for: .normal)
        button.setTitleColor(UIColor(hexString: "#ec008c"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(hexString: "#ec008c").cgColor
        return button
    }()
    
    private var inviteButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(hexString: "#999999").cgColor
        button.setTitleColor(UIColor(hexString: "#999999"), for: .normal)
        button.setTitle("邀請中", for: .normal)
        return button
    }()
    
    private var nonImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_friends_more")
        return imageView
    }()
    
    private var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#999999")
        return view
    }()
}
