//
//  PostHeader.swift
//  SwiftUIGram (iOS)
//
//  Created by Flávio Silvério on 09/10/2021.
//

import SwiftUI

struct PostHeader: View {
    var viewModel: PostViewModel
    
    init(with viewModel: PostViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            Spacer()
                .frame(width: 8)
            ProfileImage(with: viewModel)
                .frame(width: 35, height: 35)
                .cornerRadius(17.5)
            Text(viewModel.item.author.username)
            Spacer()
        }
    }
}
