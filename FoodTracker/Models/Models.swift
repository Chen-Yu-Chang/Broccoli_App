//
//  Models.swift
//  FoodTracker
//
//  Created by 張晨鈺 on 2021/4/27.
//

import Foundation

enum Gender{
    case male, female, other
}

struct User{
    let username: String
    let name: (first: String, last: String)
    let birthDate: Date
    let gender: Gender
    let counts: UserCount
    let joinDate: Date
}

struct UserCount{
    let followings: Int
    let followers: Int
    let posts: Int
}

public enum UserPostType{
    case photo, video
}

public struct UserPost{
    let postType: UserPostType
    let thumbnailImage: URL
    let postURL: URL
    let caption: String?
    let likeCount: [PostLike]
    let comments: [PostComment]
    let createdDate: Date
    let taggedUsers: [String]
}

struct PostLike{
    let username: String
    let postIdentifier: String
}

struct CommentLike{
    let username: String
    let commentIdentifier: String
}

struct PostComment{
    let identifier: String
    let username: String
    let text: String
    let createdDate: Date
    let likes: [CommentLike]
}
