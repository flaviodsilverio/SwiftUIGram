//
//  ContentView.swift
//  Shared
//
//  Created by Flávio Silvério on 08/10/2021.
//

import SwiftUI

struct Feed: View {
    
    var body: some View {
        PostList()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PostList()
    }
}

struct PostList: View {
    var body: some View {
        NavigationView {
            List {
                Post(viewModel: PostViewModel(with: FeedItem.random()))
                Post(viewModel: PostViewModel(with: FeedItem.random()))
//                Post(viewModel: PostViewModel(with: FeedItem.random()))
//                Post(viewModel: PostViewModel(with: FeedItem.random()))
//                Post(viewModel: PostViewModel(with: FeedItem.random()))
//                Post(viewModel: PostViewModel(with: FeedItem.random()))
//                Post(viewModel: PostViewModel(with: FeedItem.random()))
//                Post(viewModel: PostViewModel(with: FeedItem.random()))

            }
            .listStyle(.grouped)
            .navigationTitle("SwiftUI-Gram")
//            .font(.largeTitle)
        }
        .navigationViewStyle(StackNavigationViewStyle())

    }
}
