//
//  Models.swift
//  SwiftUIGram (iOS)
//
//  Created by Flávio Silvério on 09/10/2021.
//

import Foundation

struct FeedItem {
    internal init(author: Author, image: FeedImage) {
        self.author = author
        self.image = image
    }
    
    var author: Author
    var image: FeedImage
    
    static func random() -> FeedItem {
        return FeedItem(
            author: Author(
                username: "Joe Boggs",
                profileImgURL: "https://picsum.photos/50/50"),
            image: FeedImage(
                isFavourited: false,
                isLiked: false,
                imageURL: "https://picsum.photos/400/400"
            ))
    }
}

struct Author {
    internal init(username: String, profileImgURL: String) {
        self.username = username
        self.profileImgURL = profileImgURL
    }
    
    var username: String
    var profileImgURL: String
}

struct FeedImage {
    internal init(isFavourited: Bool, isLiked: Bool, imageURL: String) {
        self.isFavourited = isFavourited
        self.isLiked = isLiked
        self.imageURL = imageURL
    }
    
    var isFavourited: Bool
    var isLiked: Bool
    var imageURL: String
}
