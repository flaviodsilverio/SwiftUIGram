//
//  PostViewModel.swift
//  SwiftUIGram (iOS)
//
//  Created by Flávio Silvério on 09/10/2021.
//


/// There should be more View Models for the components, however since the goal of this project is to explore SwiftUI, this will be used mostly everywhere.
import SwiftUI
import Parse

final class PostViewModel: ObservableObject {
    @Published var item: FeedItem
    @Published var image: UIImage?
    @Published var profileImage: UIImage?
    
    private let imageFetcher: ImageFetcher

    init(with item: FeedItem, _ imageFetcher: ImageFetcher = ImageFetcher()) {
        self.item = item
        self.imageFetcher = imageFetcher
    }
    
    func fetchImage() {
        imageFetcher.fetchImage(for: item.image.imageURL) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.image = image
                }
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    func fetchProfileImage() {
        imageFetcher.fetchImage(for: item.author.profileImgURL) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.profileImage = image
                }
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
}
