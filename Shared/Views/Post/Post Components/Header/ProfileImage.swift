//
//  ProfileImage.swift
//  SwiftUIGram (iOS)
//
//  Created by Flávio Silvério on 09/10/2021.
//

import SwiftUI

struct ProfileImage: View {
    @ObservedObject var viewModel: PostViewModel
    
    init(with viewModel: PostViewModel) {
        self.viewModel = viewModel
        
        viewModel.fetchProfileImage()
    }
    
    var body: some View {
        if let image = viewModel.profileImage {
            return AnyView(Image(uiImage: image))
        } else {
            return AnyView(Text(""))
        }
    }
}
