//
//  FriendListViewController.swift
//  KoKoFriend
//
//  Created by 江柏毅 on 2023/3/5.
//

import Foundation
import UIKit
import SnapKit

class FriendListViewController: UIViewController {
    
    var viewModel = FriendListViewModel()
//    var friendList = [FriendViewModel]() {
//        didSet {
//            placeholderView.isHidden = friendList.count > 0
//            tableView.reloadData()
//        }
//    }
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        addUI()
        addConstraints()
        setView()
        viewModel.getFriend(success: {
            self.tableView.reloadData()
        }, fail: {_ in
            
        })
        viewModel.getUserInfo(success: { [self] in
            self.nameLabel.text = viewModel.userInfo.first?.name
            self.idContentLabel.setTitle("\(viewModel.userInfo.first?.kokoid)", for: .normal)
        }, fail: {_ in})
    }
    
    func setView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.register(FriendListTableViewCell.self, forCellReuseIdentifier: "FriendListTableViewCell")
        
        if #available(iOS 11.0, *) {
            self.tableView.contentInsetAdjustmentBehavior = .never
        }
        if self.tableView.contentSize.height != 0 {
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView.cellForRow(at: indexPath)
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    
    
    
    
    
    
   private func addUI() {
       [kokoIdLabel, idContentLabel].forEach { (view) in
           idStackView.addArrangedSubview(view)
       }
       
       [nameLabel, idStackView].forEach { (view) in
           nameIdStackView.addArrangedSubview(view)
       }
       
       [atmButton, moneyButton, scanButton, nameIdStackView, profileImage, segmentView].forEach { (view) in
           topView.addSubview(view)
       }
       
       baseView.addSubview(topView)
       baseView.addSubview(placeholderView)
       baseView.addSubview(tableView)
       self.view.addSubview(baseView)
    }
    
    private func addConstraints() {
        baseView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        topView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        atmButton.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.top).offset(50)
            make.left.equalTo(topView.snp.left).offset(20)
        }
        
        moneyButton.snp.makeConstraints { make in
            make.centerY.equalTo(atmButton)
            make.left.equalTo(atmButton.snp.right).offset(24)
        }
        
        scanButton.snp.makeConstraints { make in
            make.centerY.equalTo(moneyButton)
            make.right.equalTo(topView.snp.right).offset(-20)
        }
        
        nameIdStackView.snp.makeConstraints { make in
            make.top.equalTo(atmButton.snp.bottom).offset(35)
            make.left.equalTo(topView.snp.left).offset(30)
        }
        
        profileImage.snp.makeConstraints { make in
            make.centerY.equalTo(nameIdStackView)
            make.right.equalTo(topView.snp.right).offset(-30)
        }
        
        segmentView.snp.makeConstraints { make in
            make.top.equalTo(nameIdStackView.snp.bottom).offset(30)
            make.left.equalTo(topView.snp.left).offset(32)
            make.right.equalTo(topView.snp.right).offset(-255)
            make.bottom.equalTo(topView.snp.bottom).offset(-1)
        }
        
        placeholderView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(0)
            make.left.equalTo(baseView.snp.left).offset(0)
            make.right.equalTo(baseView.snp.right).offset(0)
            make.bottom.equalTo(baseView.snp.bottom).offset(0)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(0)
            make.left.equalTo(baseView.snp.left).offset(0)
            make.right.equalTo(baseView.snp.right).offset(0)
            make.bottom.equalTo(baseView.snp.bottom).offset(0)
        }
        
    }
    
    private var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    private var topView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(hexString: "#efefef").cgColor
        view.backgroundColor = UIColor(hexString: "#fcfcfc")
        return view
    }()
    
    private var atmButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icNavPinkWithdraw"), for: .normal)
        return button
    }()
    
    private var moneyButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icNavPinkTransfer"), for: .normal)
        return button
    }()
    
    private var scanButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icNavPinkScan"), for: .normal)
        return button
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = UIColor(hexString: "#474747")
        label.text = "紫霖"
        return label
    }()
    
    private var kokoIdLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(hexString: "#474747")
        label.text = "設定KOKO ID"
        return label
    }()
    
    private var idContentLabel: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ic_info_back_deep gray"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13)
        button.setTitle("olylinhuang", for: .normal)
        button.semanticContentAttribute = .forceLeftToRight
        button.centerTextAndImage(spacing: 1)
        return button
    }()
    
    private var idStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 2
        return stackView
    }()
    
    private var nameIdStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    
    private var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "img_friends_female_default")
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    private var segmentView: UISegmentedControl = {
        let segmentView = UISegmentedControl(items: ["好友","聊天"])
        segmentView.backgroundColor = UIColor.white
        segmentView.selectedSegmentTintColor = UIColor(hexString: "#ec008c")
        return segmentView
    }()
    
    
    private var placeholderView: UIView = {
        let view = UIView()
        
        let imageView = UIImageView.init(image: UIImage.init(named: "img_friends_empty"))
        imageView.backgroundColor = UIColor.clear
        view.addSubview(imageView)
        
        let firstLabel = UILabel.init()
        firstLabel.textAlignment = .center
        firstLabel.font = UIFont.boldSystemFont(ofSize: 21)
        firstLabel.textColor = UIColor(hexString: "#474747")
        firstLabel.text = "就從加好友開始吧：）"
        view.addSubview(firstLabel)
        
        let secondLabel = UILabel.init()
        secondLabel.textAlignment = .center
        secondLabel.numberOfLines = 0
        secondLabel.font = UIFont.systemFont(ofSize: 14)
        secondLabel.textColor = UIColor(hexString: "#999999")
        secondLabel.text = "與好友們一起用 KOKO 聊起來！\n 還能互相收付款、發紅包喔：）"
        view.addSubview(secondLabel)
        
        let button = UIButton.init()
        button.setTitle("加好友", for: .normal)
        button.layer.cornerRadius = 20
        button.backgroundColor = UIColor(hexString: "56b30b")
        view.addSubview(button)
        
        let firstAttributeprivacy: [NSAttributedString.Key: Any] =
        [.foregroundColor: UIColor(hexString: "#999999"),
         .font: UIFont.systemFont(ofSize: 13)]
        
        let secondAttributeprivacy: [NSAttributedString.Key: Any] =
        [.foregroundColor: UIColor(hexString: "#ec008c"),
         .font: UIFont.systemFont(ofSize: 13),
         .underlineStyle: NSUnderlineStyle.single.rawValue,
         .underlineColor: UIColor(hexString: "#ec008c")]
        
        let partOne = NSMutableAttributedString(string: "幫助好友更快找到你?", attributes: firstAttributeprivacy)
        let partTwo = NSMutableAttributedString(string: "設定 KOKO ID", attributes: secondAttributeprivacy)
        
        let combination = NSMutableAttributedString()
        combination.append(partOne)
        combination.append(partTwo)
        
        let threeLabel = UILabel.init()
        threeLabel.textAlignment = .left
        threeLabel.attributedText = combination
        view.addSubview(threeLabel)
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.snp.top).offset(30)
        }
        
        firstLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(imageView.snp.bottom).offset(41)
        }
        
        secondLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(firstLabel.snp.bottom).offset(8)
        }
        
        button.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(secondLabel.snp.bottom).offset(25)
            make.left.equalTo(view.snp.left).offset(92)
            make.right.equalTo(view.snp.right).offset(-92)
            make.height.equalTo(40)
        }
        
        threeLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(button.snp.bottom).offset(37)
        }
        
        return view
    }()
    
    private var tableView: UITableView = {
            let tableView = UITableView()
            return tableView
        }()
    
}



extension FriendListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendListTableViewCell", for: indexPath) as! FriendListTableViewCell
        
        cell.bind(friends: viewModel.friends[indexPath.row])
        return cell
    }
}