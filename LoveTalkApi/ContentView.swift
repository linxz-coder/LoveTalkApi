import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
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
                
                NavigationLink {
                    UploadView(viewModel: viewModel)
                } label: {
                    Text("上传数据")
                        .font(.headline)
                        .padding()
                        .padding(.horizontal)
                        .background(.green)
                        .foregroundStyle(.white)
                        .cornerRadius(10)
                }
                
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
