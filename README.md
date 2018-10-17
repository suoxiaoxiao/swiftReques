##摘要
这是一个对Swift网络请求数据并转换成Model的demo
##使用的三方库:

- 网络请求 --->  **Alamofire**
- 封装Alamofire ---> **Moya**
- JSON数据格式访问 --->**SwiftyJSON**
- JSON转Model --->**ObjectMapper**

------
## 最终结果可以使用 
##Alamofire + SwiftyJSON + ObjectMapper

## AlamofireObjectMapper

##Moya + ObjectMapper

##1.  Alamofire
- 使用方法(简单使用)

```
 Alamofire.request("https://httpbin.org/post", method: .post).responseJSON { (response) in
            
            print(response)
            
        }
```
##2. Moya
- 使用

```
enum RequestType {
    case testRequest
}

extension RequestType:TargetType{
    var baseURL: URL {
        return URL(string: "https://httpbin.org")!
    }
    
    var path: String {
        return "post"
    }
    
    var method: Moya.Method {
        switch self {
        case .testRequest:
            return .post
        }
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return ["" : ""]
    }
}

let target = RequestType.testRequest
        
let test = MoyaProvider<RequestType>()
        
test.request(target) { (result) in
       switch result {
            case let .success(response):
                do{
                    let jsonValue = try JSONSerialization.jsonObject(with: response.data, options: JSONSerialization.ReadingOptions.mutableContainers)
                    print(jsonValue)
                }catch{
                 }
                break
            case let .failure(error):
                print(error)
                break
            }
        }
```

##3. SwiftyJSON
- 使用

```
//针对于上面网络请求返回的数据进行处理
test.request(target) { (result) in
            
            switch result {
            case let .success(response):
                do{
                    
                    //不使用SwiftyJSON进行json解析
//                    let jsonValue = try? JSONSerialization.jsonObject(with: response.data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : Any]
                    
//                    let head = jsonValue?!["headers"] as? [String: Any]
//                    let host = head?["Host"] as? String
                    
//                    print(host ?? "")

                    //使用SwiftyJSON
                    let jsonValue =  try JSON(data: response.data)
                    print(jsonValue)
                    if let Host = jsonValue["headers"]["Host"].string {
                        print(Host)
                    }
                    
                }catch{
                }
                break
            case let .failure(error):
                print(error)
                break
            }
            
        }
```

##4.ObjectMapper
- 使用

```
test.request(target) { (result) in
            
            switch result {
            case let .success(response):
                do{
                    
                    //不使用SwiftyJSON进行json解析
                    //let jsonValue = try? JSONSerialization.jsonObject(with: response.data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : Any]
                    
                    //let head = jsonValue?!["headers"] as? [String: Any]
                    //let host = head?["Host"] as? String
                    
                    //print(host ?? "")
                    
                    //使用SwiftyJSON
                    let jsonValue =  try JSON(data: response.data)
                    print(jsonValue)
                    
                    if let Host = jsonValue["headers"]["Host"].string {
                        print(Host)
                    }
                    
                    //使用ObjectMapper转换模型
                    let jsonstring = jsonValue.rawString(String.Encoding.utf8, options: JSONSerialization.WritingOptions.prettyPrinted)
                    let obj = Mapper<SX>().map(JSONString:  jsonstring!)
                    print(obj!.headers.host!)
                    
                }catch{
                }
                break
            case let .failure(error):
                print(error)
                print("网络连接失败")
                break
            }
            
        }

```
##5. AlamofireObjectMapper

使用
```

Alamofire.request("https://httpbin.org/post",
                          method: .post,
                          parameters: param).responseObject { (response: DataResponse<SX>) in
            
            let result = response.result.value
            
            print(result!.headers.host)
            
        }

```

##6:Moya ObjectMapper
- 使用

```
let target = RequestType.testRequest
        
        let test = MoyaProvider<RequestType>()
        
        test.request(target) { (result) in
            
            switch result {
            case let .success(response):
                
                do{
                    
                    let jsonValue = try JSON(data: response.data)
                    let jsonstring = jsonValue.rawString(String.Encoding.utf8, options: JSONSerialization.WritingOptions.prettyPrinted)
                    let obj = Mapper<SX>().map(JSONString:  jsonstring!)
                    print(obj!.headers.host!)
                    
                }catch{
                }
                
                break
            case let .failure(error):
                print(error)
                print("网络连接失败")
                break
            }
            
        }
```




