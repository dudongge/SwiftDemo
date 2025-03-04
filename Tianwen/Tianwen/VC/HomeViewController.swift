//
//  HomeViewControler.swift
//  TianWen
//
//  Created by 卡卡 on 2025/3/2.
//
import UIKit
import Alamofire
import SwiftyJSON


struct Product: Codable {
    let id: Int
    let name: String
    let price: Double
}

class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "首页" // 导航栏标题
        view.backgroundColor = .white
        
        
        // 获取闪屏列表
//        TestSeviceAPI.shared.listFlash { result in
//            switch result {
//            case .success(let json):
//                let 
//                print("获取闪屏列表成功：\(json)")
//            case .failure(let error):
//                print("获取闪屏列表失败：\(error)")
//            }
//        }
        
        
//        TestSeviceAPI.shared.listFlash { result in
//            switch result {
//            case .success(let json):
//                let
//                print("获取闪屏列表成功：\(json)")
//            case .failure(let error):
//                print("获取闪屏列表失败：\(error)")
//            }
//        }
        
        // 在视图控制器中使用
        TestSeviceAPI.shared.listFlash { result in
            switch result {
            case .success(let response):
                let poetry = response.data
                print("作者：\(poetry.author)")
                print("内容：\(poetry.content)")
                print("出处：\(poetry.origin)")
                print("分类：\(poetry.category)")
            case .failure(let error):
                print("获取失败：\(error)")
            }
        }
       
        // 添加导航栏按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "下一步",
            style: .plain,
            target: self,
            action: #selector(goToNext))
        
    }
    
    
    @objc func goToNext() {
        let nextVC = SettingViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
