//
//  TestSevice.swift
//  TianWen
//
//  Created by 卡卡 on 2025/3/3.
//

import Foundation
import Alamofire
import SwiftyJSON

class TestSeviceAPI {
    static let shared = TestSeviceAPI()
    private init() {}
    
    // 基础 URL
    private let baseURL = "https://v2.alapi.cn/api"
    
    // 公共参数
    private var commonParameters: Parameters {
        [
            "appkey": "da44a5d9227fa9ef",
            "mobi_app": "iphone_comic",
            "version": "6.8.1",
            "build": "2171",
            "channel": "AppStore",
            "platform": "ios",
            "device": "phone",
            "machine": "iPhone 13 Pro",
            "access_key": "fe30ac3bc653966d50eed14b47718412CjClfmnXa2YCHSt-5fyOJ70WXXlKf2aEeP2c8gC1opw37zvKvoU6QfNglfAsu0XBZAYSVmYyOURXSkxxa0JOcllnOVpvcV94R0paWWtsT0NqZ1pYdkk3VXNkUFEteklzSkhrOUVSWlF5WWVGaHhHRnhYaE5icVRmcUY5dEV1RU5wZHh4czV0MTdBIIEC",
            "is_teenager": "0",
            "no_recommend": "0",
            "network": "wifi",
            "ts": String(Int(Date().timeIntervalSince1970))
        ]
    }
    // 请求诗词列表
    func shiciList(completion: @escaping (Result<BaseResponse<PoetryResponse>, NetworkError>) -> Void) {
        let endpoint = "/shici"
        let parameters: Parameters = [
            "type": "shuqing",
            "token": "LwExDtUWhF3rH5ib"
        ]
        
        NetworkManager.shared.request(
            endpoint: endpoint,
            method: .post,
            parameters: parameters,
            completion: completion
        )
    }
}

// 通用响应模型
struct BaseResponse<T: Codable>: Codable {
    let message: String
    let time: Int
    let usage: Int
    let success: Bool
    let code: Int
    let requestId: String
    let data: T
    
    enum CodingKeys: String, CodingKey {
        case message
        case time
        case usage
        case success
        case code
        case requestId = "request_id"
        case data
    }
}


struct PoetryResponse: Codable {
    let c2: String
    let origin: String
    let content: String
    let author: String
    let c1: String
    let c3: String
    let category: String
}
