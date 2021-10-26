//
//  Post.swift
//  SwiftUIGram (iOS)
//
//  Created by Flávio Silvério on 09/10/2021.
//

import SwiftUI

struct Post: View {
    var viewModel: PostViewModel
    
    init(with viewModel: PostViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            PostHeader(viewModel: viewModel)
            PostContent(with: viewModel)
            InteractionBar(with: viewModel)
        }
        .frame(
            width: UIScreen.main.bounds.width - 16
        )
    }
}
