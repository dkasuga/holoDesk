//
//  ARWebViewNode.swift
//  Stereoscopic-ARKit-Template
//
//  Created by Daisuke Kasuga on 2019/01/06.
//  Copyright © 2019年 CompanyName. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import SwiftyJSON
import Foundation
import Starscream
import WebKit


class ARWebViewNode {
    let webView:WKWebView!
    let webPlane:SCNPlane
    let webPlaneNode:SCNNode
    let planeShape:SCNPhysicsShape
    
    init(_ requestURL:String, _ web_width:CGFloat=0.4, _ web_height:CGFloat=0.3, _ name: String = "ARVideoNode"){
        
//        self.webView = UIWebView(frame: CGRect(x: 0, y: 0, width: 640, height: 480))
        self.webView = WKWebView(frame:CGRect(x:0, y:0, width:640, height:480))
//        // create a web view
//        self.webView.loadRequest(URLRequest(url: URL(string: requestURL)!))
        webView.load(URLRequest(url: URL(string: requestURL)!))
        
        //webView.scrollView.contentOffset.y=200;//任意の数字
        
        //webPlaneのmaterialにwebVieを指定
        self.webPlane = SCNPlane(width: web_width  , height: web_height)
        self.webPlane.firstMaterial?.diffuse.contents = webView //SKScene(size: CGSize(width: 1920, height: 1080))//webView
        self.webPlane.firstMaterial?.isDoubleSided = true
        
        //webPlaneNodeのgeometryにwebPlaneを貼り付ける
        self.webPlaneNode = SCNNode(geometry: webPlane)
        //self.webPlaneNode.simdTransform = webPlane_simdTransform
        //webPlaneNode.eulerAngles = webPlane_eulerAngles
    
        
        self.planeShape = SCNPhysicsShape(geometry: SCNBox(width: web_width, height: web_height, length: 0.1, chamferRadius: 0), options: nil)
        //衝突判定に使うのはwebPlaneNodeであってARWebViewNodeではない
        self.webPlaneNode.name = name
        self.webPlaneNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: self.planeShape)
        self.webPlaneNode.physicsBody?.categoryBitMask = 0b1000
        self.webPlaneNode.physicsBody?.collisionBitMask = 0b0100
        self.webPlaneNode.physicsBody?.contactTestBitMask = 0b0010 //handやfingerと接触するように
        self.webPlaneNode.physicsBody?.isAffectedByGravity = false
    }
    
    
}


