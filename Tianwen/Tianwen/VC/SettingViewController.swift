//
//  File.swift
//  TianWen
//
//  Created by 卡卡 on 2025/3/2.
//

import UIKit
import SceneKit

class SettingViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "设置" // 导航栏标题
        view.backgroundColor = .white
        
        // 创建 SceneKit 视图
        let sceneView = SCNView(frame: view.frame)
        view.addSubview(sceneView)
        
        // 创建场景
        let scene = SCNScene()
        sceneView.scene = scene
        
        // 创建相机
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 5)
        scene.rootNode.addChildNode(cameraNode)
        
        // 添加环境光
        let ambientLight = SCNNode()
        ambientLight.light = SCNLight()
        ambientLight.light?.type = .ambient
        ambientLight.light?.intensity = 1000
        scene.rootNode.addChildNode(ambientLight)
        
        // 创建立方体
        let boxGeometry = SCNBox(width: 2.0, height: 2.0, length: 2.0, chamferRadius: 0.0)
        let boxNode = SCNNode(geometry: boxGeometry)
        
        // 定义每个面的文字和颜色
        let faceData: [(text: String, color: UIColor)] = [
            ("前面", .systemRed),
            ("后面", .systemBlue),
            ("左面", .systemGreen),
            ("右面", .systemPurple),
            ("上面", .systemOrange),
            ("下面", .systemBrown)
        ]
        
        // 创建材质
        var materials: [SCNMaterial] = []
        
        for (text, color) in faceData {
            let material = SCNMaterial()
            let textImage = createTextImage(
                text: text,
                backgroundColor: color,
                size: CGSize(width: 512, height: 512)
            )
            material.diffuse.contents = textImage
            material.isDoubleSided = true
            material.diffuse.wrapS = .clamp
            material.diffuse.wrapT = .clamp
            material.diffuse.minificationFilter = .linear
            material.diffuse.magnificationFilter = .linear
            materials.append(material)
        }
        
        boxGeometry.materials = materials
        
        // 添加立方体到场景
        scene.rootNode.addChildNode(boxNode)
        
        // 设置场景显示选项
        sceneView.allowsCameraControl = true
        sceneView.showsStatistics = true
        sceneView.backgroundColor = .white
        
        // 设置默认灯光
        sceneView.autoenablesDefaultLighting = true
        
        // 添加调试视图（可选，用于验证贴图是否正确生成）
        addDebugView(with: faceData[0].text, color: faceData[0].color)
    }
    
    func createTextImage(text: String, backgroundColor: UIColor, size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        let img = renderer.image { ctx in
            // 绘制背景
            backgroundColor.setFill()
            ctx.fill(CGRect(origin: .zero, size: size))
            
            // 设置文字属性
            let fontSize = size.width * 0.3
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: fontSize, weight: .heavy),
                .foregroundColor: UIColor.white,
                .strokeWidth: -4.0,
                .strokeColor: UIColor.black
            ]
            
            // 计算文字大小并居中绘制
            let attributedString = NSAttributedString(string: text, attributes: attributes)
            let stringSize = attributedString.size()
            let origin = CGPoint(
                x: (size.width - stringSize.width) / 2,
                y: (size.height - stringSize.height) / 2
            )
            
            attributedString.draw(at: origin)
        }
        return img
    }
    
    func addDebugView(with text: String, color: UIColor) {
        let debugImageView = UIImageView(frame: CGRect(x: 20, y: 50, width: 100, height: 100))
        debugImageView.image = createTextImage(
            text: text,
            backgroundColor: color,
            size: CGSize(width: 512, height: 512)
        )
        debugImageView.layer.borderColor = UIColor.black.cgColor
        debugImageView.layer.borderWidth = 1
        view.addSubview(debugImageView)
    }
    
    @objc func goToNext() {
        let nextVC = ViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

