//
//  PostContent.swift
//  SwiftUIGram (iOS)
//
//  Created by Flávio Silvério on 09/10/2021.
//

import SwiftUI

struct PostContent: View {
    @ObservedObject var viewModel: PostViewModel
    @State private var likeOpacity: Double = 0.0
    
    var animatableLikeView: Image = Image(systemName: ImageNames.Interactions.likeFilled.rawValue)
    
    init(viewModel: PostViewModel) {
        self.viewModel = viewModel
        
        viewModel.fetchImage()
    }
    
    var body: some View {
        if let image = viewModel.image {
            return
                AnyView(
                    ZStack {
                        Image(uiImage: image)
                            .resizable()
                            .frame(
                                minWidth: 0,
                                maxWidth: .infinity,
                                minHeight: 0,
                                maxHeight: 400,
                                alignment: .center)
                            .aspectRatio(contentMode: .fill)
                        animatableLikeView
                            .resizable()
                            .frame(width: 200, height: 200, alignment: .center)
                            .opacity(likeOpacity)
                            .animation(.easeInOut(duration: 0.7))

                    }.gesture(
                        TapGesture(count: 2)
                            .onEnded { _ in
                                viewModel.item.image.isLiked = true
                                
                                likeOpacity = 1
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    likeOpacity = 0
                                }
                            })
                )
        } else {
            return AnyView(Text("Loading image...")
                            .frame(width: 400, height: 400, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            )
        }
    }
}
