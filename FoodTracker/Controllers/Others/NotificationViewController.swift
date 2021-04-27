//
//  NotificationViewController.swift
//  FoodTracker
//
//  Created by 張晨鈺 on 2021/4/27.
//

import UIKit

enum UserNotificationType{
    case like(post: UserPost)
    case follow(state: FollowState)
}

struct UserNotification {
    let type: UserNotificationType
    let text: String
    let user: User
}

final class NotificationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = false
        tableView.register(NotificationLikeEventTableViewCell.self, forCellReuseIdentifier: NotificationLikeEventTableViewCell.identifier)
        tableView.register(NotificationFollowEventTableViewCell.self, forCellReuseIdentifier: NotificationFollowEventTableViewCell.identifier)
        return tableView
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.tintColor = .label
        return spinner
    }()
    
    private lazy var noNotificationsView = NoNotificationsView()
    
    private var models = [UserNotification]()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNotifications()
        navigationItem.title = "Notifications"
        view.backgroundColor = .systemBackground
        view.addSubview(spinner)
        //spinner.startAnimating()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        spinner.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        spinner.center = view.center
    }
    
    private func fetchNotifications(){
        for x in 0...100{
            let post = UserPost(identifier: "",postType: .photo, thumbnailImage: URL(string: "https://www.google.com")!, postURL: URL(string: "https://www.google.com")!, caption: nil, likeCount: [], comments: [], createdDate: Date(), taggedUsers: [])
            let model = UserNotification(type: x%2 == 0 ? .like(post: post) : .follow(state: .not_following), text: "Hello World", user: User(username: "joe", bio: "", name: (first: "", last: ""), profilePhoto: URL(string: "https://www.google.com")!, birthDate: Date(), gender: .male, counts: UserCount(followings: 1, followers: 1, posts: 1), joinDate: Date()))
            models.append(model)
        }
    }
    
    private func addNoNotificationsView(){
        tableView.isHidden = true
        view.addSubview(tableView)
        noNotificationsView.frame = CGRect(x: 0, y: 0, width: view.width/2, height: view.width/4)
        noNotificationsView.center = view.center
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        switch model.type{
        case .like(_):
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationLikeEventTableViewCell.identifier, for: indexPath) as! NotificationLikeEventTableViewCell
            cell.configure(with: model)
            cell.delegate = self
            return cell
        case .follow:
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationFollowEventTableViewCell.identifier, for: indexPath) as! NotificationFollowEventTableViewCell
            //cell.configure(with: model)
            cell.delegate = self
            return cell
        }
    }
    
    
}

extension NotificationViewController: NotificationLikeEventTableViewCellDelegate{
    func didTapRelatedPostButton(model: UserNotification) {
        print("Tapped post")
    }
}

extension NotificationViewController: NotificationFollowEventTableViewCellDelegate{
    func didTapFollowUnfollowButton(model: UserNotification) {
        print("Tapped follow")
    }
}
