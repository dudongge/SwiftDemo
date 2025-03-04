//
//  NetWork.swift
//  TianWen
//
//  Created by 卡卡 on 2025/3/3.
//

import Foundation
import Alamofire
import SwiftyJSON


enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(String)
    case networkError(Error)
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    // 基础 URL
    private let baseURL = "https://v2.alapi.cn/api"
    
    // 默认请求头
    private var defaultHeaders: HTTPHeaders {
        HTTPHeaders([
            "Content-Type": "application/json",
            "Accept": "application/json"
        ])
    }
    
//    // 通用请求方法
    func request<T>(
            endpoint: String,
            method: HTTPMethod = .get,
            parameters: Parameters? = nil,
            headers: HTTPHeaders? = nil,
            completion: @escaping (Result<BaseResponse<T>, NetworkError>) -> Void
        ) where T: Codable {
            let url = baseURL + endpoint
            
            var finalHeaders = defaultHeaders
            if let additionalHeaders = headers {
                for header in additionalHeaders {
                    finalHeaders.add(name: header.name, value: header.value)
                }
            }
            
            let alamofireMethod = Alamofire.HTTPMethod(rawValue: method.rawValue)
            
            AF.request(
                url,
                method: alamofireMethod,
                parameters: parameters,
                encoding: method == .get ? URLEncoding.default : JSONEncoding.default,
                headers: finalHeaders
            ).responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(BaseResponse<T>.self, from: data)
                        completion(.success(result))
                    } catch {
                        print("Parsing Error: \(error)")
                        if let jsonString = String(data: data, encoding: .utf8) {
                            print("Raw Data: \(jsonString)")
                        }
                        completion(.failure(.decodingError))
                    }
                case .failure(let error):
                    completion(.failure(.networkError(error)))
                }
            }
        }

    // JSON 响应处理
    func requestJSON(
        endpoint: String,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil,
        completion: @escaping (Result<JSON, NetworkError>) -> Void
    ) {
        let url = baseURL + endpoint
        
        var finalHeaders = defaultHeaders
        if let additionalHeaders = headers {
            for header in additionalHeaders {
                finalHeaders.add(name: header.name, value: header.value)
            }
        }
        
        let alamofireMethod = Alamofire.HTTPMethod(rawValue: method.rawValue)
        
        AF.request(
            url,
            method: alamofireMethod,
            parameters: parameters,
            encoding: method == .get ? URLEncoding.default : JSONEncoding.default,
            headers: finalHeaders
        ).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    // 使用 SwiftyJSON 直接解析
                    let json = try JSON(data: data)
                    completion(.success(json))
                } catch {
                    print("解析错误: \(error)")
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("原始数据: \(jsonString)")
                    }
                    completion(.failure(.decodingError))
                }
            case .failure(let error):
                completion(.failure(.networkError(error)))
            }
        }
    }
}
extension NetworkManager {
    // 将 JSON 转换为模型的便捷方法
    func convertToModel<T: Codable>(json: JSON) -> T? {
        do {
            let jsonData = try json.rawData()
            let decoder = JSONDecoder()
            let model = try decoder.decode(T.self, from: jsonData)
            return model
        } catch {
            print("模型转换错误: \(error)")
            return nil
        }
    }
}
