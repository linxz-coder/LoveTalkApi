import SwiftUI

struct UploadView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ViewModel
    
    @State private var title = "" // 标题输入
    @State private var content = "" // 内容输入
    
    var body: some View {
        
        Form {
            Section(header: Text("输入数据")) {
                TextField("标题", text: $title)
                TextEditor(text: $content)
                    .frame(height: 100)
            }
        }
        .navigationTitle("数据上传")
        .navigationBarItems(
            trailing: Button("提交") {
                viewModel.postData(title: title, content: content)
                dismiss()
                // 清空输入
                title = ""
                content = ""
            }
        )
    }
}


#Preview {
    UploadView(viewModel: ViewModel())
}
