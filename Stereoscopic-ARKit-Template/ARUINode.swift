//
//  ARUINode.swift
//  Stereoscopic-ARKit-Template
//
//  Created by Daisuke Kasuga on 2019/01/04.
//  Copyright © 2019年 CompanyName. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import SwiftyJSON
import Foundation
import Starscream

class ARPlaneUINode: SCNNode {
    
    var planeShape:SCNPhysicsShape
    var image:UIImage
    var width:CGFloat
    var height:CGFloat
    var planeGeometry:SCNBox
    var panelNode:SCNNode
    var material_front = SCNMaterial()
    
    init(image:UIImage, width: CGFloat, height: CGFloat, name: String = "ARPlaneUINode") {
        
        self.image = image
        self.width = width
        self.height = height
        self.planeGeometry = SCNBox(width: self.width, height: self.height, length: 0, chamferRadius: 0)
        
        self.planeShape = SCNPhysicsShape(geometry: planeGeometry, options: nil)
        
        self.panelNode = SCNNode(geometry: planeGeometry)
        //let material_other = SCNMaterial()
        //material_other.diffuse.contents = panelColor
        self.material_front.diffuse.contents = image
        self.panelNode.geometry?.materials = [self.material_front]
        //panelNode.geometry?.materials = [material_front, material_other, material_other, material_other, material_other, material_other]
        
        super.init()
        //以下，当たり判定
        //init内でどうやってnameを初期化すればいいかわからないのでとりあえずその後に書く
        self.name = name
        self.physicsBody = SCNPhysicsBody(type: .dynamic, shape: self.planeShape)
        self.physicsBody?.categoryBitMask = 0b0001 
        self.physicsBody?.collisionBitMask = 0b0100
        self.physicsBody?.contactTestBitMask = 0b0010 //handやfingerと接触するように
        self.physicsBody?.isAffectedByGravity = false
        
        addChildNode(panelNode)
    }
    
    func changeImage(image: UIImage) {
        self.material_front.diffuse.contents = image
        self.panelNode.geometry?.materials = [self.material_front]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func pop() {
        //self.scale = SCNVector3(0.0, 0.0, 0.0)
        let pop0 = SCNAction.scale(to: 0.0, duration: 0.0)
        let pop1 = SCNAction.scale(to: 1.2, duration: 0.20)
        let pop2 = SCNAction.scale(to: 0.9, duration: 0.18)
        let pop3 = SCNAction.scale(to: 1.05, duration: 0.12)
        let pop4 = SCNAction.scale(to: 1.0, duration: 0.10)
        
        self.runAction(SCNAction.sequence([
            pop0,
            pop1,
            pop2,
            pop3,
            pop4
            ]))
    }
    // ・・・略・・・
}
