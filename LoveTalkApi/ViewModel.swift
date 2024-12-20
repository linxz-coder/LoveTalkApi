import SwiftUI

class ViewModel: ObservableObject {
    @Published var responseText = ""
    
    //MARK: - GET请求
    func fetchData(){
        //创建url
        guard let url = URL(string: "https://api.apiopen.top/api/sentences") else { return }
        
        //创建session
        let session = URLSession(configuration: .default)
        
        //创建task
        let task = session.dataTask(with: url) { data, response, error in
            // 错误处理
            guard error == nil else {
                print("Error: \(error!.localizedDescription)")
                return
            }
            
            // 检查响应状态
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                print("Invalid response")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            // 解析 JSON 数据
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                  let result = json["result"] as? [String: Any],
                  let content = result["name"] as? String else {
                print("JSON Parsing Error or unexpected structure")
                return
            }
            
            //测试返回值
            print(json)
            
            DispatchQueue.main.async {
                self.responseText = content  // 更新界面上的文字内容
            }
        }
        
        task.resume()
    }
    
    
    //MARK: - POST请求
    func postData(title:String, content:String) {
            //创建url
            guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
            
            //创建请求
            //1.url
            var request = URLRequest(url: url)
            //2.method
            request.httpMethod = "POST"
            //3.header
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            //4.content(data)
            let postData: [String: Any] = [
                "title": title,
                "content": content,
                "userId": 1
            ]
            
            //将数据转换为JSON格式
            guard let jsonData = try? JSONSerialization.data(withJSONObject: postData) else {
                print("Failed to convert data to JSON")
                return
            }
            
            request.httpBody = jsonData
            
            //创建session
            let session = URLSession(configuration: .default)
            
            //创建task
            let task = session.dataTask(with: request) { data, response, error in
                // 错误处理
                guard error == nil else {
                    print("Error: \(error!.localizedDescription)")
                    return
                }
                
                // 检查响应状态
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 201 else {  // POST成功通常返回201
                    print("Invalid response")
                    return
                }
                
                guard let data = data else {
                    print("No data received")
                    return
                }
                
                // 解析返回的 JSON 数据
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                      let title = json["title"] as? String else {
                    print("JSON Parsing Error or unexpected structure")
                    return
                }
                
                //测试返回值
                print(json)
                
                DispatchQueue.main.async {
                    self.responseText = "发布成功：\(title)"  // 更新界面上的文字内容
                }
            }
            
            task.resume()
        }
}
