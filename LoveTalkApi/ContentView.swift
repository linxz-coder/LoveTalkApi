//
//  ContentView.swift
//  LoveTalkApi
//
//  Created by 林晓中 on 2024/12/19.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            
            Text(viewModel.responseText)
                .font(.largeTitle)
            
            Button {
                viewModel.fetchData()
            } label: {
                Text("获取一句名言")
                    .font(.headline)
                    .padding()
                    .padding(.horizontal)
                    .background(.blue)
                    .foregroundStyle(.white)
                    .cornerRadius(10)
            }

        }
        .padding()
    }
}

#Preview {
    ContentView()
}
