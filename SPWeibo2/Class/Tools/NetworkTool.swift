//
//  NetworkTool.swift
//  SPWeibo2
//
//  Created by 侯亮宏 on 17/3/1.
//  Copyright © 2017年 侯亮宏. All rights reserved.
//

/// 网络请求方法枚举
enum SPRequestMethod:String {
    case GET = "GET"
    case POST = "POST"
    case HEAD = "HEAD"
    case DELETE = "DELETE"
    case PUT = "PUT"
}
/// 网络请求类型枚举（上传，下载）
enum SPTaskType:String {
    case UPLOAD = "UPLOAD"
    case DOWNLOAD = "DOWNLOAD"
}

import UIKit
import AFNetworking

class NetworkTool: AFHTTPSessionManager {
    
    static let sharedManager:NetworkTool = {
        let manager = NetworkTool(baseURL: nil)
        manager.responseSerializer.acceptableContentTypes?.insert("text/plain")
        manager.responseSerializer.acceptableContentTypes?.insert("text/html")
        return manager
    }()
    

    /// 封装AFNetworking的HTTPSessionManager下的一些网络方法，适合小数据量网络请求使用
    func request(method:SPRequestMethod,URLString:String,parameters:Any?,completion:@escaping (Any?,Error?)->()){
        switch method {
        case .GET:
            NetworkTool.sharedManager.get(URLString, parameters: parameters, progress: nil, success: { (_, responseObject) in
                if let responseObject = responseObject{
                completion(responseObject,nil)
                }
            }, failure: { (_, error) in
                print(error)
                completion(nil, error)
            })
        case .POST:
            NetworkTool.sharedManager.post(URLString, parameters: parameters, progress: nil, success: { (_, responseObject) in
                if let responseObject = responseObject{
                    completion(responseObject,nil)
                }
            }, failure: { (_, error) in
                print(error)
                completion(nil, error)
            })
        case .HEAD:
            NetworkTool.sharedManager.head(URLString, parameters: parameters, success: { (dataTask) in
                completion(dataTask, nil)
            }, failure: { (_, error) in
                print(error)
                completion(nil, error)
            })
        case .PUT:
            NetworkTool.sharedManager.put(URLString, parameters: parameters, success: { (_, responseObject) in
                if let responseObject = responseObject{
                    completion(responseObject,nil)
                }
            }, failure: { (_, error) in
                print(error)
                completion(nil, error)
            })
        case .DELETE:
            NetworkTool.sharedManager.delete(URLString, parameters: parameters, success: { (_, responseObject) in
                if let responseObject = responseObject{
                    completion(responseObject,nil)
                }
            }, failure: { (_, error) in
                print(error)
                completion(nil, error)
            })
        }
    }
    
    
    /// 封装AFNetworking的HTTPSessionManager下的一些网络方法，适合大数据量网络请求使用
    func task(taskType:SPTaskType,URLString:String,parameters:Any?,progressBlock:@escaping (Progress)->(),constructingBodyWith:@escaping (AFMultipartFormData)->(),completion:@escaping (Any?,URLSessionDataTask?,Error?)->()){
        switch taskType {
        case .DOWNLOAD:
            NetworkTool.sharedManager.get(URLString,
                                          parameters: parameters, // parameters
                                          progress: {(progress) in // progress Block
                progressBlock(progress)},
                                          success: { (task, responseObject) in // 成功Block
                completion(responseObject, task, nil)},
                                          failure: { (task, error) in // 失败block
                completion(nil, task, error)
            })
        case .UPLOAD:
            NetworkTool.sharedManager.post(URLString,
                                           parameters: parameters, // parameters
                                           constructingBodyWith: { (formData) in // 数据拼接Block
            constructingBodyWith(formData)
            },
                                           progress: {progress in // progress Block
            progressBlock(progress)
            },
                                           success: { (uploadTask, responseObject) in // 成功Block
            completion(responseObject, uploadTask, nil)
            },
                                           failure: { (uploadTask, error) in // 失败Block
            completion(nil, uploadTask, error)
            })
        }
        
        
        
    }
    
}
