//
//  OKViewController.swift
//  KoKoFriend
//
//  Created by 江柏毅 on 2023/3/10.
//

import Foundation
import UIKit
import SnapKit

class OKViewController: UIViewController, FriendListDelegate, UISearchBarDelegate {
    
    
    
    func didFriendChange(friends: [FriendViewModel]) {
        if friends.count > 0 {
            searchView.isHidden = false
            tableView.isHidden = false
            placeholderView.isHidden = true
            tableView.reloadData()
        } else {
            searchView.isHidden = true
            tableView.isHidden = true
            placeholderView.isHidden = false
        }
    
    }
   
    var viewModel = FriendListViewModel()
    
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        addUI()
        addConstraints()
        setView()
        viewModel.delegate = self
        self.searchBar.delegate = self
        
        
//        viewModel.getMergeFriend(success: { [self] in
//            viewModel.filterFriend = viewModel.friends
//            self.tableView.reloadData()
//            self.inviteTableView.reloadData()
//            self.inviteTableView.snp.makeConstraints { make in
//                make.height.equalTo(self.inviteTableView.contentSize.height)
//            }
//
//            self.segmentView.snp.makeConstraints { make in
//                make.top.equalTo(self.inviteTableView.snp.bottom).offset(0)
//                make.bottom.equalTo(self.topView.snp.bottom).offset(-1)
//            }
//
//            }, fail: {_ in
//        })
        
        
//        // MARK: 有好友無邀請資料時為畫⾯1-(2)呈現
//        viewModel.getFriend(success: { [self] in
//            viewModel.filterFriend = viewModel.friends
//            self.tableView.reloadData()
//            self.inviteTableView.reloadData()
//            self.inviteTableView.snp.makeConstraints { make in
//                make.height.equalTo(self.inviteTableView.contentSize.height)
//            }
//
//            self.segmentView.snp.makeConstraints { make in
//                make.top.equalTo(self.inviteTableView.snp.bottom).offset(0)
//                make.bottom.equalTo(self.topView.snp.bottom).offset(-1)
//            }
//
//            }, fail: {_ in
//        })
        
        // MARK:  同時有好友與邀請時畫1-(3)

        viewModel.getFriendInvite(success: { [self] in
            self.tableView.reloadData()
            self.inviteTableView.reloadData()
            self.inviteTableView.snp.makeConstraints { make in
                make.height.equalTo(self.inviteTableView.contentSize.height)
            }

            self.segmentView.snp.makeConstraints { make in
                make.top.equalTo(self.inviteTableView.snp.bottom).offset(0)
                make.bottom.equalTo(self.topView.snp.bottom).offset(-1)
            }

            }, fail: {_ in
        })
        
        viewModel.getUserInfo(success: { [self] in
            self.nameLabel.text = viewModel.userInfo.first?.name
            self.idContentButton.setTitle("\(viewModel.userInfo.first?.kokoid ?? "g")", for: .normal)
            self.kokoIdLabel.text = "KOKO ID : "
        }, fail: {_ in})
    }
    

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            viewModel.filterFriend = viewModel.friends
            tableView.reloadData()
        } else {
            viewModel.filterFriend = viewModel.friends.filter {$0.name == searchText }
            tableView.reloadData()
        }
    }
    
    func setView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.register(FriendTableViewCell.self, forCellReuseIdentifier: "FriendTableViewCell")
//        self.tableView.estimatedRowHeight =
        
        self.inviteTableView.delegate = self
        self.inviteTableView.dataSource = self
        self.inviteTableView.separatorStyle = .none
        self.inviteTableView.register(FriendReceviceTableViewCell.self, forCellReuseIdentifier: "FriendReceviceTableViewCell")
        self.inviteTableView.estimatedRowHeight = 90
        
        if #available(iOS 11.0, *) {
            self.tableView.contentInsetAdjustmentBehavior = .never
        }
        if self.tableView.contentSize.height != 0 {
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView.cellForRow(at: indexPath)
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
        if #available(iOS 11.0, *) {
            self.inviteTableView.contentInsetAdjustmentBehavior = .never
        }
        if self.inviteTableView.contentSize.height != 0 {
            let indexPath = IndexPath(row: 0, section: 0)
            self.inviteTableView.cellForRow(at: indexPath)
            self.inviteTableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    
    
    
    
    
    
   private func addUI() {
       [kokoIdLabel, idContentButton].forEach { (view) in
           idStackView.addArrangedSubview(view)
       }
       
       [nameLabel, idStackView].forEach { (view) in
           nameIdStackView.addArrangedSubview(view)
       }
       
       
       [atmButton, moneyButton, scanButton, nameIdStackView, profileImage, segmentView].forEach { (view) in
           topView.addSubview(view)
       }
       
       searchView.addSubview(searchBar)
       searchView.addSubview(addFriendButton)
       baseView.addSubview(topView)
       baseView.addSubview(placeholderView)
       baseView.addSubview(searchView)
       baseView.addSubview(tableView)
       baseView.addSubview(inviteTableView)
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
        
        searchView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(0)
            make.left.equalTo(baseView.snp.left).offset(0)
            make.right.equalTo(baseView.snp.right).offset(0)
            make.height.equalTo(61)
        }
        
        searchBar.snp.makeConstraints { make in
            make.left.equalTo(baseView.snp.left).offset(30)
            make.right.equalTo(baseView.snp.right).offset(-61)
            make.top.equalTo(searchView.snp.top).offset(15)
            make.bottom.equalTo(searchView.snp.bottom).offset(-10)
        }
        
        addFriendButton.snp.makeConstraints { make in
            make.centerY.equalTo(searchBar)
            make.left.equalTo(searchBar.snp.right).offset(15)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchView.snp.bottom).offset(0)
            make.left.equalTo(baseView.snp.left).offset(0)
            make.right.equalTo(baseView.snp.right).offset(0)
            make.bottom.equalTo(baseView.snp.bottom).offset(0)
        }
        
        inviteTableView.snp.makeConstraints { make in
            make.top.equalTo(nameIdStackView.snp.bottom).offset(10)
            make.left.equalTo(topView.snp.left).offset(0)
            make.right.equalTo(topView.snp.right).offset(0)
           // make.bottom.equalTo(segmentView.snp.top).offset(-10)
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
    
    private var idContentButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ic_info_back_deep gray"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13)
        button.setTitle("olylinhuang", for: .normal)
        button.setTitleColor(UIColor(hexString: "#474747"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
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
       // segmentView.setWidth(30, forSegmentAt: .bitWidth)
        segmentView.selectedSegmentTintColor = UIColor.white
        segmentView.backgroundColor = UIColor.white
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
    
    private var inviteTableView: UITableView = {
            let tableView = UITableView()
            return tableView
    }()
    
    private var searchView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    private var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "想轉一筆給誰呢?"
        searchBar.layer.borderColor = UIColor.clear.cgColor
        searchBar.layer.borderWidth = 0
        return searchBar
    }()
    
    private var addFriendButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ic_btn_add_friends"), for: .normal)
        return button
    }()
   
}



extension OKViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        
    if tableView == self.tableView {
        return viewModel.friends.filter {$0.status != 2}.count
      
    } else if tableView == self.inviteTableView {
        return viewModel.friends.filter {$0.status == 2}.count
                }
    return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.tableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendTableViewCell", for: indexPath) as! FriendTableViewCell
            cell.bind(friends: viewModel.friends.filter {$0.status != 2}[indexPath.row])
            
            return cell
            
        } else if tableView == self.inviteTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendReceviceTableViewCell", for: indexPath) as! FriendReceviceTableViewCell
            cell.bind(friends: viewModel.friends.filter {$0.status == 2}[indexPath.row])

            return cell
            
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.inviteTableView{
            return self.inviteTableView.estimatedRowHeight
        } else {
            return self.tableView.estimatedRowHeight
        }
    }
}

