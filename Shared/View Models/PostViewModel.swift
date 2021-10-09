//
//  PostViewModel.swift
//  SwiftUIGram (iOS)
//
//  Created by Flávio Silvério on 09/10/2021.
//


/// There should be more View Models for the components, however since the goal of this project is to explore SwiftUI, this will be used mostly everywhere.
import SwiftUI

class PostViewModel: ObservableObject {
    @Published var item: FeedItem
    @Published var image: UIImage?
    @Published var profileImage: UIImage?
    
    let imageFetcher = ImageFetcher()
    
    init(with item: FeedItem) {
        self.item = item
    }
    
    func fetchImage() {
        imageFetcher.fetchImage(for: item.image.imageURL) { [weak self] image in
            guard let image = image else {
                return
            }
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
    
    func fetchProfileImage() {
        imageFetcher.fetchProfileImage(for: item.author.profileImgURL) { [weak self] image in
            guard let image = image else {
                return
            }
            DispatchQueue.main.async {
                self?.profileImage = image
            }
        }
    }
    
}
