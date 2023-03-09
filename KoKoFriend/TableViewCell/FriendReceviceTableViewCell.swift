//
//  FriendReceviceTableViewCell.swift
//  KoKoFriend
//
//  Created by 江柏毅 on 2023/3/9.
//

import Foundation
import UIKit

class FriendReceviceTableViewCell: UITableViewCell {

override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addUI()
        addConstraints()
        contentView.backgroundColor = UIColor.white
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



func addUI() {
    [idLabel, inviteLabel].forEach { (view) in
        idStackView.addArrangedSubview(view)
    }
    
    [profileImage, idStackView, agreeButton, disagreeButton].forEach { (view) in
        baseView.addSubview(view)
    }
    
    contentView.addSubview(baseView)
    
}

func addConstraints() {
    baseView.snp.makeConstraints { make in
        make.top.equalTo(contentView.snp.top).offset(0)
        make.bottom.equalTo(contentView.snp.bottom).offset(0)
        make.left.equalTo(contentView.snp.left).offset(30)
        make.right.equalTo(contentView.snp.right).offset(-30)
    }
    
    profileImage.snp.makeConstraints { make in
        make.centerY.equalTo(baseView)
        make.left.equalTo(baseView.snp.left).offset(15)
    }
    
    idStackView.snp.makeConstraints { make in
        make.centerY.equalTo(profileImage)
        make.left.equalTo(profileImage.snp.right).offset(15)
    }
    
    agreeButton.snp.makeConstraints { make in
        make.centerY.equalTo(idStackView)
        make.right.equalTo(disagreeButton.snp.left).offset(-15)
    }
    
    disagreeButton.snp.makeConstraints { make in
        make.centerY.equalTo(agreeButton)
        make.right.equalTo(baseView.snp.right).offset(-15)
    }
   
}


    private var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.brown
        view.layer.shadowOffset = CGSize(width: 1.5, height: 3)
        view.layer.shadowOpacity = 0.7
        view.layer.shadowRadius = 5
        return view
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
    
    private var inviteLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(hexString: "#999999")
        label.text = "邀請你成為好友 : )"
        return label
    }()
    
    private var idStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.alignment = .fill
        return stackView
    }()

    private var agreeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "btn_friends_agree"), for: .normal)
        return button
    }()

    private var disagreeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "btn_friends_delet"), for: .normal)
        return button
    }()
    
}
