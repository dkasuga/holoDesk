//
//  ViewController.swift
//  Stereoscopic-ARKit-Template
//
//  Created by Hanley Weng on 1/7/17.
//  Copyright © 2017 CompanyName. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import SwiftyJSON
import Foundation
import Starscream

//iPhoneとLeapmotionの間の奥行きoffset
internal let offset = 10.0


class GestureController {
    //ハンドジェスチャコントローラ
    var hand = Hand()
    var thumb = Thumb()
    var index = Index()
    var middle = Middle()
    var ring = Ring()
    var pinky = Pinky()
    
    var grabFlag = false
    var finger_flag = [Bool](repeating: false, count: 5)
    
    static let handBallSize = CGFloat(0.03)
    static let fingerBallSize = CGFloat(0.01)
    //手のノード
    let handNode = SCNNode(geometry: SCNSphere(radius: handBallSize))
    //各指のノード
    let thumbNode = SCNNode(geometry: SCNSphere(radius: fingerBallSize))
    let indexNode = SCNNode(geometry: SCNSphere(radius: fingerBallSize))
    let middleNode = SCNNode(geometry: SCNSphere(radius: fingerBallSize))
    let ringNode = SCNNode(geometry: SCNSphere(radius: fingerBallSize))
    let pinkyNode = SCNNode(geometry: SCNSphere(radius: fingerBallSize))
    
    
    init(){
        //主にphysics関連
        let handBall = SCNSphere(radius: GestureController.handBallSize)
        let fingerBall = SCNSphere(radius: GestureController.fingerBallSize)
        let handShape = SCNPhysicsShape(geometry: handBall, options: nil)
        let fingerShape = SCNPhysicsShape(geometry: fingerBall, options: nil)
        //手のノードのphysics初期化
        handNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: handShape)
        handNode.physicsBody?.categoryBitMask = 0b0010
        handNode.physicsBody?.contactTestBitMask = 1
        handNode.physicsBody?.isAffectedByGravity = false
        handNode.name = "hand"
        //親指のノードのphysics初期化
        thumbNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: fingerShape)
        thumbNode.physicsBody?.categoryBitMask = 0b0010
        thumbNode.physicsBody?.contactTestBitMask = 1
        thumbNode.physicsBody?.isAffectedByGravity = false
        thumbNode.name = "thumb"
        //人指指のノードのphysics初期化
        indexNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: fingerShape)
        indexNode.physicsBody?.categoryBitMask = 0b0010
        indexNode.physicsBody?.contactTestBitMask = 1
        indexNode.physicsBody?.isAffectedByGravity = false
        indexNode.name = "index"
        //中指のノードのphysics初期化
        middleNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: fingerShape)
        middleNode.physicsBody?.categoryBitMask = 0b0010
        middleNode.physicsBody?.contactTestBitMask = 1
        middleNode.physicsBody?.isAffectedByGravity = false
        middleNode.name = "middle"
        //薬指のノードのphysics初期化
        ringNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: fingerShape)
        ringNode.physicsBody?.categoryBitMask = 0b0010
        ringNode.physicsBody?.contactTestBitMask = 1
        ringNode.physicsBody?.isAffectedByGravity = false
        ringNode.name = "ring"
        //小指のノードのphysics初期化
        pinkyNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: fingerShape)
        pinkyNode.physicsBody?.categoryBitMask = 0b0010
        pinkyNode.physicsBody?.contactTestBitMask = 1
        pinkyNode.physicsBody?.isAffectedByGravity = false
        pinkyNode.name = "pinky"
    }
    
    func renderingColor(){
        //手を握ってたら赤，握ってなければ白
        let whitematerial = SCNMaterial()
        whitematerial.diffuse.contents = UIColor.white
        let redmaterial = SCNMaterial()
        redmaterial.diffuse.contents = UIColor.red
        
        if self.grabFlag == false {
            handNode.geometry?.materials = [whitematerial]
        } else{
            handNode.geometry?.materials = [redmaterial]
        }
        
    }
    
    func positionConverter(cameraNode:SCNNode){
        //いったんカメラ座標そのものをDouble->SCNVector3で保存
        var cameraHandNodePosition = SCNVector3(0.0, 0.0, 0.0)
        var cameraThumbNodePosition = SCNVector3(0.0, 0.0, 0.0)
        var cameraIndexNodePosition = SCNVector3(0.0, 0.0, 0.0)
        var cameraMiddleNodePosition = SCNVector3(0.0, 0.0, 0.0)
        var cameraRingNodePosition = SCNVector3(0.0, 0.0, 0.0)
        var cameraPinkyNodePosition = SCNVector3(0.0, 0.0, 0.0)
        var cameraHandNodeNormal = SCNVector3(0.0, 0.0, 0.0)
        var cameraHandNodeDirection = SCNVector3(0.0, 0.0, 0.0)
        //手のひらの位置
        cameraHandNodePosition.x = Float(self.hand.palmPosition[0] + 0.05)
        cameraHandNodePosition.y = Float(self.hand.palmPosition[1] - 0.06)
        cameraHandNodePosition.z = Float(self.hand.palmPosition[2] - 0.06)
        //手のひらの向き（指の向いている方向）
        cameraHandNodeDirection.x = Float(self.hand.direction[0])
        cameraHandNodeDirection.y = Float(self.hand.direction[1])
        cameraHandNodeDirection.z = Float(self.hand.direction[2])
        //手のひらの向いている方向（法線ベクトル）
        cameraHandNodeNormal.x = Float(self.hand.palmNormal[0])
        cameraHandNodeNormal.y = Float(self.hand.palmNormal[1])
        cameraHandNodeNormal.z = Float(self.hand.palmNormal[2])
        //姿勢を決めるもう1つの軸
        //DirectionとNormalに垂直なベクトル
        //外積を求める関数がないので直接求める
        let cameraHandNodeAnother =
            SCNVector3(
                -(cameraHandNodeNormal.y * cameraHandNodeDirection.z - cameraHandNodeNormal.z * cameraHandNodeDirection.y),
                -(cameraHandNodeNormal.z * cameraHandNodeDirection.x - cameraHandNodeNormal.x * cameraHandNodeDirection.z),
                -(cameraHandNodeNormal.x * cameraHandNodeDirection.y - cameraHandNodeNormal.y * cameraHandNodeDirection.x))
        //親指の位置
        cameraThumbNodePosition.x = Float(self.thumb.tipPosition[0] + 0.05)
        cameraThumbNodePosition.y = Float(self.thumb.tipPosition[1] - 0.04)
        cameraThumbNodePosition.z = Float(self.thumb.tipPosition[2] - 0.04)
        //人差し指の位置
        cameraIndexNodePosition.x = Float(self.index.tipPosition[0] + 0.05)
        cameraIndexNodePosition.y = Float(self.index.tipPosition[1] - 0.04)
        cameraIndexNodePosition.z = Float(self.index.tipPosition[2] - 0.04)
        //中指の位置
        cameraMiddleNodePosition.x = Float(self.middle.tipPosition[0] + 0.05)
        cameraMiddleNodePosition.y = Float(self.middle.tipPosition[1] - 0.04)
        cameraMiddleNodePosition.z = Float(self.middle.tipPosition[2] - 0.04)
        //薬指の位置
        cameraRingNodePosition.x = Float(self.ring.tipPosition[0] + 0.05)
        cameraRingNodePosition.y = Float(self.ring.tipPosition[1] - 0.04)
        cameraRingNodePosition.z = Float(self.ring.tipPosition[2] - 0.04)
        //小指の位置
        cameraPinkyNodePosition.x = Float(self.pinky.tipPosition[0] + 0.05)
        cameraPinkyNodePosition.y = Float(self.pinky.tipPosition[1] - 0.04)
        cameraPinkyNodePosition.z = Float(self.pinky.tipPosition[2] - 0.04)
        //カメラ座標からワールド座標に変換
        //まず位置を保存しておく
        let position = cameraNode.convertPosition(cameraHandNodePosition, to: nil)
        self.handNode.simdTransform = simd_float4x4(rows: [
            float4(-cameraHandNodeAnother.x, -cameraHandNodeDirection.x, cameraHandNodeNormal.x, position.x),
            float4(-cameraHandNodeAnother.y, -cameraHandNodeDirection.y, cameraHandNodeNormal.y, position.y),
            float4(-cameraHandNodeAnother.z, -cameraHandNodeDirection.z, cameraHandNodeNormal.z, position.z),
            float4(0.0, 0.0, 0.0, 1.0)
            ])

//        self.handNode.transform = SCNMatrix4(
//            m11: -cameraHandNodeAnother.x, m12: -cameraHandNodeAnother.y, m13: cameraHandNodeDirection.z, m14: 0.0,
//            m21: -cameraHandNodeDirection.x, m22: -cameraHandNodeDirection.y, m23: -cameraHandNodeDirection.z, m24: 0.0,
//            m31: cameraHandNodeNormal.x, m32: cameraHandNodeNormal.y, m33: cameraHandNodeNormal.z, m34: 0.0,
//            m41: position.x, m42: position.y, m43: position.z, m44: 1.0
//        )
        self.thumbNode.position = cameraNode.convertPosition(cameraThumbNodePosition, to: nil)
        self.indexNode.position = cameraNode.convertPosition(cameraIndexNodePosition, to: nil)
        self.middleNode.position = cameraNode.convertPosition(cameraMiddleNodePosition, to: nil)
        self.ringNode.position = cameraNode.convertPosition(cameraRingNodePosition, to: nil)
        self.pinkyNode.position = cameraNode.convertPosition(cameraPinkyNodePosition, to: nil)
    }
    
    func rendering(sceneNode:SCNNode){
        // 検出面の子要素にする
        sceneNode.addChildNode(self.handNode)
        if self.finger_flag[0] {
            sceneNode.addChildNode(self.thumbNode)
        } else{
            self.thumbNode.removeFromParentNode()
        }
        if self.finger_flag[1] {
            sceneNode.addChildNode(self.indexNode)
        } else{
            self.indexNode.removeFromParentNode()
        }
        if self.finger_flag[2] {
            sceneNode.addChildNode(self.middleNode)
        } else{
            self.middleNode.removeFromParentNode()
        }
        if self.finger_flag[3] {
            sceneNode.addChildNode(self.ringNode)
        } else{
            self.ringNode.removeFromParentNode()
        }
        if self.finger_flag[4] {
            sceneNode.addChildNode(self.pinkyNode)
        } else{
            self.pinkyNode.removeFromParentNode()
        }
    }
    
    //Leapmotionは認識した指を内側からに配列に入れる．
    func switch_finger(id:Int, tipPosition:[Double], tipDirection:[Double]){
        switch id % 10{
        case 0:
            //            print("親指" + "\(id):" + "\(tipPosition)")
            self.thumb.direction = tipDirection
            //親指の位置
            self.thumb.tipPosition[0] = -tipPosition[0] / 1000.0 //x = -z_leap
            self.thumb.tipPosition[1] = -tipPosition[2] / 1000.0 //y = x_leap
            self.thumb.tipPosition[2] = -(tipPosition[1] + offset) / 1000.0 //z = -(y_leap + offset)
            
            //親指の向き
            self.thumb.direction[0] = -tipDirection[0] / 1000.0 //x = -z_leap
            self.thumb.direction[1] = -tipDirection[2] / 1000.0 //y = x_leap
            self.thumb.direction[2] = -(tipDirection[1] + offset) / 1000.0 //z = -(y_leap + offset)
        case 1:
            //            print("人指指" + "\(id):" + "\(tipPosition)")
            //人指指の位置
            self.index.tipPosition[0] = -tipPosition[0] / 1000.0 //x = -z_leap
            self.index.tipPosition[1] = -tipPosition[2] / 1000.0 //y = x_leap
            self.index.tipPosition[2] = -(tipPosition[1] + offset) / 1000.0 //z = -(y_leap + offset)
            //人指指の向き
            self.index.direction[0] = -tipDirection[0] / 1000.0 //x = -z_leap
            self.index.direction[1] = -tipDirection[2] / 1000.0 //y = x_leap
            self.index.direction[2] = -(tipDirection[1] + offset) / 1000.0 //z = -(y_leap + offset)
        case 2:
            //            print("中指" + "\(id):" + "\(tipPosition)")
            //人指指の位置
            self.middle.tipPosition[0] = -tipPosition[0] / 1000.0 //x = -z_leap
            self.middle.tipPosition[1] = -tipPosition[2] / 1000.0 //y = x_leap
            self.middle.tipPosition[2] = -(tipPosition[1] + offset) / 1000.0 //z = -(y_leap + offset)
            //人指指の向き
            self.middle.direction[0] = -tipDirection[0] / 1000.0 //x = -z_leap
            self.middle.direction[1] = -tipDirection[2] / 1000.0 //y = x_leap
            self.middle.direction[2] = -(tipDirection[1] + offset) / 1000.0 //z = -(y_leap + offset)
        case 3:
            //            print("薬指" + "\(id):" + "\(tipPosition)")
            //人指指の位置
            self.ring.tipPosition[0] = -tipPosition[0] / 1000.0 //x = -z_leap
            self.ring.tipPosition[1] = -tipPosition[2] / 1000.0 //y = x_leap
            self.ring.tipPosition[2] = -(tipPosition[1] + offset) / 1000.0 //z = -(y_leap + offset)
            //人指指の向き
            self.ring.direction[0] = -tipDirection[0] / 1000.0 //x = -z_leap
            self.ring.direction[1] = -tipDirection[2] / 1000.0 //y = x_leap
            self.ring.direction[2] = -(tipDirection[1] + offset) / 1000.0 //z = -(y_leap + offset)
        case 4:
            //            print("小指" + "\(id):" + "\(tipPosition)")
            //人指指の位置
            self.pinky.tipPosition[0] = -tipPosition[0] / 1000.0 //x = -z_leap
            self.pinky.tipPosition[1] = -tipPosition[2] / 1000.0 //y = x_leap
            self.pinky.tipPosition[2] = -(tipPosition[1] + offset) / 1000.0 //z = -(y_leap + offset)
            //人指指の向き
            self.pinky.direction[0] = -tipDirection[0] / 1000.0 //x = -z_leap
            self.pinky.direction[1] = -tipDirection[2] / 1000.0 //y = x_leap
            self.pinky.direction[2] = -(tipDirection[1] + offset) / 1000.0 //z = -(y_leap + offset)
        default:
            print("エラー" + "\(id):")
        }
    }
}

class Hand {
    var direction:[Double] //手のひらの向き（指を指している方向）
    var id:Int
    var palmNormal:[Double] //手のひらの向いている方向（法線ベクトル）
    var palmPosition:[Double] //手のひらの位置
    var palmVelocity:[Double]
    var timeVisible:Double
    
    init(){
        self.direction = [Double](repeating: 0.0, count: 3)
        self.id = 0
        self.palmNormal = [Double](repeating: 0.0, count: 3)
        self.palmPosition = [Double](repeating: 0.0, count: 3)
        self.palmVelocity = [Double](repeating: 0.0, count: 3)
        self.timeVisible = 0.0
    }
}

class Finger {
    var direction:[Double]
    var id:Int
    var length:Double
    var timeVisible:Double
    var tipPosition:[Double]
    var width:Double
    
    var name:String
    
    init(){
        self.direction = [Double](repeating: 0.0, count: 3)
        self.id = 0
        self.length = 0.0
        self.timeVisible = 0.0
        self.tipPosition = [Double](repeating: 0.0, count: 3)
        self.width = 0.0
        
        self.name = ""
    }
}

class Thumb : Finger {
    override init() {
        super.init()
        self.name = "thumb"
    }
}

class Index : Finger {
    override init() {
        super.init()
        self.name = "index"
    }
}

class Middle : Finger {
    override init() {
        super.init()
        self.name = "middle"
    }
}

class Ring : Finger {
    override init() {
        super.init()
        self.name = "ring"
    }
}

class Pinky : Finger {
    override init() {
        super.init()
        self.name = "pinky"
    }
}

//Leapmotionトラッキングデータを入れる構造体
//値がnilの場合もある（手をとらえていない場合など）もあるので，すべてオプショナル型にしておく
struct trackingData: Codable {
    
    let currentFrameRate: Double?
    let devices: [String]?
    let hands: [hands]?
    let id: Int?
    let pointables: [pointables]?
    let timestamp: Int?
}

struct hands: Codable {
    let direction: [Double]?
    let id: Int?
    let palmNormal: [Double]?
    let palmPosition: [Double]?
    let palmVelocity: [Double]?
    let timeVisible: Double?
}

struct pointables: Codable {
    let direction: [Double]?
    let handld: Int?
    let id: Int?
    let length: Double?
    let timeVisible: Double?
    let tipPosition: [Double]?
    let width: Double?
}
