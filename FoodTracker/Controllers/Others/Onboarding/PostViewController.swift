//
//  PostViewController.swift
//  FoodTracker
//
//  Created by 張晨鈺 on 2021/4/27.
//

import UIKit
//states of a rendered cell
enum PostRenderType{
    case header(provider: User)
    case primaryContent(provider: UserPost)
    case actions(provider: String) //like, comment, share
    case comments(comments:[PostComment])
}
//model of rendered post
struct PostRenderViewModel{
    let renderType: PostRenderType
}

class PostViewController: UIViewController {
    
    private let model: UserPost?
    
    private var renderModels = [PostRenderViewModel]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        //register cells
        tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        tableView.register(IGFeedHeaderTableViewCell.self, forCellReuseIdentifier: IGFeedHeaderTableViewCell.identifier)
        tableView.register(IGFeedPostActionsTableViewCell.self, forCellReuseIdentifier: IGFeedPostActionsTableViewCell.identifier)
        tableView.register(IGFeedPostGeneralTableViewCell.self, forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)
        return tableView
    }()
    
    init(model: UserPost?){
        self.model = model
        super.init(nibName: nil, bundle: nil)
        configureModels()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureModels(){
        guard let userPostModel = self.model else{
            return
        }
        //header
        renderModels.append(PostRenderViewModel(renderType: .header(provider: userPostModel.owner)))
        //post
        renderModels.append(PostRenderViewModel(renderType: .primaryContent(provider: userPostModel)))
        //actions
        renderModels.append(PostRenderViewModel(renderType: .actions(provider: "")))
        //comments
        var comments = [PostComment]()
        for x in 0..<4{
            comments.append(
                PostComment(identifier: "123_\(x)", username: "@dave", text: "Great Post!", createdDate: Date(), likes: [])
            )
        }
        renderModels.append(PostRenderViewModel(renderType: .comments(comments: comments)))
    }
    
    //header model
    //post cell model
    //action buttons cell model
    //number of general models for comments
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
}

extension PostViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return renderModels.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch renderModels[section].renderType{
        case .actions(_): return 1
        case .comments(let comments): return comments.count > 4 ? 4 : comments.count
        case .primaryContent(_): return 1
        case .header(_): return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = renderModels[indexPath.section]
        
        switch model.renderType{
            case .actions(let actions):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.identifier, for: indexPath) as! IGFeedPostActionsTableViewCell
                return cell
            case .comments(let comments):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier, for: indexPath) as! IGFeedPostGeneralTableViewCell
                return cell
            case .primaryContent(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as! IGFeedPostTableViewCell
                return cell
            case .header(let user):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedHeaderTableViewCell.identifier, for: indexPath) as! IGFeedHeaderTableViewCell
                return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = renderModels[indexPath.section]
        
        switch model.renderType{
            case .actions(_):
                return 60
            case .comments(_):
                return 50
            case .primaryContent(_):
                return view.width
            case .header(_):
                return 70
        }
    }
}
