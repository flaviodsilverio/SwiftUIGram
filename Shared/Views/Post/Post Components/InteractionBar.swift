//
//  InteractionBar.swift
//  SwiftUIGram (iOS)
//
//  Created by Flávio Silvério on 09/10/2021.
//

import SwiftUI

fileprivate enum InteractionImageNames: String {
    case bookmark
    case bookmarkFilled
    case like
    case likeFilled
    case send
}

struct InteractionBar: View {
    @ObservedObject var viewModel: PostViewModel
    
    init(with viewModel: PostViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            Spacer()
                .frame(width: 8)
            LikeButton(viewModel: viewModel)
            Spacer()
                .frame(width: 16)
            SendButton(viewModel: viewModel)
            Spacer()
            BookmarkButton(viewModel: viewModel)
            Spacer()
                .frame(width: 16)
        }
    }
}

struct LikeButton: View {
    @ObservedObject var viewModel: PostViewModel
    
    var body: some View {
        Button(action: {
                    viewModel.item.image.isLiked = true
                        })
        {
            Image(viewModel.item.image.isLiked ? InteractionImageNames.likeFilled.rawValue : InteractionImageNames.like.rawValue)
                            .resizable()
                            .frame(width: 25, height: 25, alignment: .center)
        }.buttonStyle(PlainButtonStyle())
    }
}

struct BookmarkButton: View {
    @ObservedObject var viewModel: PostViewModel

    var body: some View {
        Button(action: {
            viewModel.item.image.isFavourited = !viewModel.item.image.isFavourited
                        })
        {
            Image(viewModel.item.image.isFavourited ? InteractionImageNames.bookmarkFilled.rawValue : InteractionImageNames.bookmark.rawValue)
                            .resizable()
                            .frame(width: 25, height: 25, alignment: .center)
        }.buttonStyle(PlainButtonStyle())
    }
}

struct SendButton: View {
    @ObservedObject var viewModel: PostViewModel

    var body: some View {
        Button(action: {
            actionSheet()
                        })
        {
            Image(InteractionImageNames.send.rawValue)
                            .resizable()
                            .frame(width: 25, height: 25, alignment: .center)
        }.buttonStyle(PlainButtonStyle())
    }
    
    
    func actionSheet() {
        guard let urlShare = URL(string: viewModel.item.image.imageURL) else { return }
        let activityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
    }
}
