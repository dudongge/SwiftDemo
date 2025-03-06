//
//  TabbarController.swift
//  TianWen
//
//  Created by 卡卡 on 2025/3/5.
//
import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置选中时的颜色
        tabBar.tintColor = .red  // 选中时的颜色
        tabBar.unselectedItemTintColor = .gray  // 未选中时的颜色
        
        // 设置选中时的图片和文字
        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(
            title: "首页",
            image: UIImage(named: "home_normal")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: "home_selected")?.withRenderingMode(.alwaysOriginal)
        )
        
        // 设置选中时文字属性
        let normalAttrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor.gray
        ]
        
        let selectedAttrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor.red
        ]
        
        UITabBarItem.appearance().setTitleTextAttributes(normalAttrs, for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(selectedAttrs, for: .selected)
        
        // 设置背景颜色（iOS 15及以上）
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.backgroundColor = .white
            tabBar.scrollEdgeAppearance = appearance
            tabBar.standardAppearance = appearance
        }
        
        delegate = self
    }
}

// 扩展处理选中状态变化
extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        // 根据选中的索引动态改变文字
        let titles = ["首页精选", "发现更多", "我的收藏", "个人中心"]
        if let item = viewController.tabBarItem {
            item.title = titles[selectedIndex]
        }
    }
}
