//
//  ARVideoNode.swift
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


class ARVideoNode {
    let videoFileName:String
    let videoNode:SKVideoNode
    let skScene:SKScene
    let tvPlane:SCNPlane
    let tvPlaneNode:SCNNode
    let planeShape:SCNPhysicsShape
    
    let playButton:ARPlaneUINode
    var playImage:UIImage
    var playNow:Bool
    
    init(_ videoFileName:String, _ video_width:CGFloat=1.0, _ video_height:CGFloat=0.75, _ tvPlane_simdTransform:simd_float4x4, _ tvPlane_eulerAngles:SCNVector3, _ name: String = "ARVideoNode"){
        self.videoFileName = videoFileName
        self.videoNode = SKVideoNode(fileNamed: self.videoFileName)
        
        self.skScene = SKScene(size: CGSize(width: 1920, height: 1080))
        self.skScene.addChild(self.videoNode)
        
        self.videoNode.position = CGPoint(x: skScene.size.width/2, y: skScene.size.height/2)
        self.videoNode.size = skScene.size
        
        self.tvPlane = SCNPlane(width: video_width, height:video_height)
        self.tvPlane.firstMaterial?.diffuse.contents = skScene
        self.tvPlane.firstMaterial?.isDoubleSided = true
        
        self.tvPlaneNode =  SCNNode(geometry: tvPlane)
        self.tvPlaneNode.simdTransform = tvPlane_simdTransform
        self.tvPlaneNode.eulerAngles = tvPlane_eulerAngles
        
        self.playNow = false
        self.playImage = UIImage(named: "pause.png")!
        self.playButton = ARPlaneUINode(image: self.playImage, width:0.1, height:0.1, name:"videoPlayButtonNode")
        //playButtonはtvPlaneNodeに追従する
        
        
        //let playButtonPosition = SCNVector3(-0.1, -video_height-0.2, -0.4)
        //self.playButton.position = self.tvPlaneNode.convertPosition(playButtonPosition, to: nil)
        //self.tvPlaneNode.addChildNode(self.playButton)
        
        
        
        
        self.planeShape = SCNPhysicsShape(geometry: SCNBox(width: video_width, height: video_height, length: 0.20, chamferRadius: 0), options: nil)
        
        //衝突判定に使うのはtvPlaneNodeであってARVideoNodeではない
        self.tvPlaneNode.name = name
        self.tvPlaneNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: self.planeShape)
        self.tvPlaneNode.physicsBody?.categoryBitMask = 0b1000
        self.tvPlaneNode.physicsBody?.collisionBitMask = 0b0100
        self.tvPlaneNode.physicsBody?.contactTestBitMask = 0b0010 //handやfingerと接触するように
        self.tvPlaneNode.physicsBody?.isAffectedByGravity = false
    }
    
    func play(){
        self.videoNode.play()
        self.playNow = true
        self.playImage = UIImage(named: "pause.png")!
        self.playButton.changeImage(image:self.playImage)
    }
    
    func pause(){
        self.videoNode.pause()
        self.playNow = false
        self.playImage = UIImage(named: "play.png")!
        self.playButton.changeImage(image:self.playImage)
    }
    
    func pop() {
        //self.scale = SCNVector3(0.0, 0.0, 0.0)
        let pop0 = SCNAction.scale(to: 0.0, duration: 0.0)
        let pop1 = SCNAction.scale(to: 1.2, duration: 0.20)
        let pop2 = SCNAction.scale(to: 0.9, duration: 0.18)
        let pop3 = SCNAction.scale(to: 1.05, duration: 0.12)
        let pop4 = SCNAction.scale(to: 1.0, duration: 0.10)
        
        self.tvPlaneNode.runAction(SCNAction.sequence([
            pop0,
            pop1,
            pop2,
            pop3,
            pop4
            ]))
    }
    
}
