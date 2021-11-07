//
//  Post.swift
//  SwiftUIGram (iOS)
//
//  Created by Flávio Silvério on 09/10/2021.
//

import SwiftUI

struct Post: View {
    var viewModel: PostViewModel

    var body: some View {
        VStack {
            PostHeader(viewModel: viewModel)
            PostContent(viewModel: viewModel)
            InteractionBar(viewModel: viewModel)
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            alignment: .leading)
    }
}
