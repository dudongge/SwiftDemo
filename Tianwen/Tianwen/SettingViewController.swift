//
//  File.swift
//  TianWen
//
//  Created by 卡卡 on 2025/3/2.
//

import UIKit

class SettingViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "设置" // 导航栏标题
        view.backgroundColor = .white
        
        // 添加导航栏按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "下一步",
            style: .plain,
            target: self,
            action: #selector(goToNext))
    }
    
    @objc func goToNext() {
        let nextVC = ViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

