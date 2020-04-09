//
//  Collision.swift
//  Stereoscopic-ARKit-Template
//
//  Created by Daisuke Kasuga on 2019/01/05.
//  Copyright © 2019年 CompanyName. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import SwiftyJSON
import Foundation
import Starscream
import WebKit

//UINodeとFingerNodeの当たり判定
extension ViewController: SCNPhysicsContactDelegate, WKUIDelegate {
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        let nodeA = contact.nodeA
        let nodeB = contact.nodeB
        
        if (nodeA.name == "evaQ_button" && nodeB.name == "index") || (nodeB.name == "evaQ_button" && nodeA.name == "index") {
            if self.evaQFlag == false {
                self.evaQFlag = true
                print("index & evaQ_button collide!")
                if videoPlay == false{
                    if nodeA.name == "evaQ_button"{
                        for child in self.evaSelection.childNodes{
                            if child.name != "evaQ_button" {
                                //let moveLeft = SCNAction.moveBy(x: 0, y: -0.5, z: 0, duration: 1)
                                let fadeOut = SCNAction.fadeOut(duration: 1)
                                //moveLeft.timingMode = .easeIn
                                fadeOut.timingMode = .easeIn
                                child.runAction(SCNAction.sequence([fadeOut,SCNAction.removeFromParentNode()]))
                            }
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            //プレイヤー側へ接近しながら拡大
                            let moveToPlayer = SCNAction.moveBy(x: -0.12, y: 0, z: 0.1, duration: 0.5)
                            let scale = SCNAction.scale(by: 2, duration: 0.5)
                            moveToPlayer.timingMode = .easeIn
                            scale.timingMode = .easeIn
                            nodeA.runAction(SCNAction.sequence([
                                SCNAction.group([
                                    moveToPlayer,
                                    scale
                                    ]),
                                SCNAction.wait(duration: 1),
                                SCNAction.fadeOut(duration: 0.5),
                                SCNAction.removeFromParentNode()]))
//                            self.evaSelection.addChildNode(descriptionNode)
//                            descriptionNode.position =  self.menuAppSelection.convertPosition(SCNVector3(0.15, 0, 0.35), to: nil)
                        }
                    } else{
                        for child in self.evaSelection.childNodes{
                            if child.name != "evaQ_button" {
                                //let moveLeft = SCNAction.moveBy(x: 0, y: -0.5, z: 0, duration: 1)
                                let fadeOut = SCNAction.fadeOut(duration: 1)
                                //moveLeft.timingMode = .easeIn
                                fadeOut.timingMode = .easeIn
                                child.runAction(SCNAction.sequence([fadeOut,SCNAction.removeFromParentNode()]))
                            }
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            //プレイヤー側へ接近しながら拡大
                            let moveToPlayer = SCNAction.moveBy(x: -0.12, y: 0, z: 0.1, duration: 0.5)
                            let scale = SCNAction.scale(by: 2, duration: 0.5)
                            moveToPlayer.timingMode = .easeIn
                            scale.timingMode = .easeIn
                            nodeB.runAction(SCNAction.sequence([
                                SCNAction.group([
                                    moveToPlayer,
                                    scale
                                    ]),
                                SCNAction.wait(duration: 1),
                                SCNAction.fadeOut(duration: 0.5),
                                SCNAction.removeFromParentNode()]))
                        }
                    }
                    
                    
                    
                    
                    self.videoPlay = true    //再生開始
                    
                    var translation = matrix_identity_float4x4
                    translation.columns.3.z = -1.0  //カメラ座標系で1m奥に
                    var tvPlaneNode_simdtransform:simd_float4x4 = matrix_identity_float4x4
                    var tvPlaneNode_eulerAngles:SCNVector3 = SCNVector3(0.0, 0.0, 0.0)
                    if let camera = self.sceneView.pointOfView {
                        tvPlaneNode_simdtransform = matrix_multiply(simd_float4x4(camera.transform), translation)
                        tvPlaneNode_eulerAngles = SCNVector3(Double.pi,0,0)
                    }
                    let arVideoNode = ARVideoNode("evaQ1080p.mp4", 1.0, 0.75, tvPlaneNode_simdtransform, tvPlaneNode_eulerAngles, "evaQ_video")
                    
                    
                    //一時的なもの！現在再生中のarVideoに
                    self.nowARVideo = arVideoNode
                    
                    self.videoScreens.addChildNode(arVideoNode.tvPlaneNode)
                    
                    //video
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                        arVideoNode.play()  //再生開始
                        self.sceneView.scene.rootNode.addChildNode(self.videoScreens)
                    }
                }
            }
        }
        
        if (nodeA.name == "evaH_button" && nodeB.name == "index") || (nodeB.name == "evaH_button" && nodeA.name == "index") {
            if self.evaHFlag == false {
                self.evaHFlag = true
                print("index & ARPlaneUI collide!")
                if videoPlay == false{
                    if nodeA.name == "evaH_button"{
                        for child in self.evaSelection.childNodes{
                            if child.name != "evaH_button" {
                                //let moveLeft = SCNAction.moveBy(x: 0, y: -0.5, z: 0, duration: 1)
                                let fadeOut = SCNAction.fadeOut(duration: 1)
                                //moveLeft.timingMode = .easeIn
                                fadeOut.timingMode = .easeIn
                                child.runAction(SCNAction.sequence([fadeOut,SCNAction.removeFromParentNode()]))
                            }
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            //プレイヤー側へ接近しながら拡大
                            let moveToPlayer = SCNAction.moveBy(x: 0, y: 0, z: 0.1, duration: 0.5)
                            let scale = SCNAction.scale(by: 2, duration: 0.5)
                            moveToPlayer.timingMode = .easeIn
                            scale.timingMode = .easeIn
                            nodeA.runAction(SCNAction.sequence([
                                SCNAction.group([
                                    moveToPlayer,
                                    scale
                                    ]),
                                SCNAction.wait(duration: 1),
                                SCNAction.fadeOut(duration: 0.5),
                                SCNAction.removeFromParentNode()]))
                        }
                    } else{
                        for child in self.evaSelection.childNodes{
                            if child.name != "evaH_button" {
                                //let moveLeft = SCNAction.moveBy(x: 0, y: -0.5, z: 0, duration: 1)
                                let fadeOut = SCNAction.fadeOut(duration: 1)
                                //moveLeft.timingMode = .easeIn
                                fadeOut.timingMode = .easeIn
                                child.runAction(SCNAction.sequence([fadeOut,SCNAction.removeFromParentNode()]))
                            }
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            //プレイヤー側へ接近しながら拡大
                            let moveToPlayer = SCNAction.moveBy(x: 0, y: 0, z: 0.1, duration: 0.5)
                            let scale = SCNAction.scale(by: 2, duration: 0.5)
                            moveToPlayer.timingMode = .easeIn
                            scale.timingMode = .easeIn
                            nodeB.runAction(SCNAction.sequence([
                                SCNAction.group([
                                    moveToPlayer,
                                    scale
                                    ]),
                                SCNAction.wait(duration: 1),
                                SCNAction.fadeOut(duration: 0.5),
                                SCNAction.removeFromParentNode()]))
                        }
                    }
                    
                    
                    
                    
                    self.videoPlay = true    //再生開始
                    
                    var translation = matrix_identity_float4x4
                    translation.columns.3.z = -0.8  //カメラ座標系で1m奥に
                    var tvPlaneNode_simdtransform:simd_float4x4 = matrix_identity_float4x4
                    var tvPlaneNode_eulerAngles:SCNVector3 = SCNVector3(0.0, 0.0, 0.0)
                    if let camera = self.sceneView.pointOfView {
                        tvPlaneNode_simdtransform = matrix_multiply(simd_float4x4(camera.transform), translation)
                        tvPlaneNode_eulerAngles = SCNVector3(Double.pi,0,0)
                    }
                    let arVideoNode = ARVideoNode("evaH4K.mov", 1.0, 0.75, tvPlaneNode_simdtransform, tvPlaneNode_eulerAngles, "evaH_video")
                    
                    //いったんscaleを0.0に
                    arVideoNode.tvPlaneNode.scale = SCNVector3(0.0, 0.0, 0.0)
                    //pop出現
                    arVideoNode.pop()
                    
                    
                    self.videoScreens.addChildNode(tvPlaneNode)
                    
                    //video
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                        arVideoNode.play()  //再生開始
                        //self.sceneView.scene.rootNode.addChildNode(tvPlaneNode)
                        self.sceneView.scene.rootNode.addChildNode(self.videoScreens)
                    }
                }
            }
        }
        
        
        //衝突判定に使うのはtvPlaneNodeであってARPlaneNodeではない
        
        //evaQvideoハンドル
        if (nodeA.name == "evaQ_video" && nodeB.name == "hand") || (nodeB.name == "evaQ_video" && nodeA.name == "hand") {
            //print("index & evaQ_video collide!")
            if nodeA.name == "evaQ_video"{
                if gestureController.grabFlag {
                    //nodeA.simdTransform = self.gestureController.handNode.simdTransform
                    nodeA.transform = self.gestureController.handNode.transform
                }
            } else {
                if gestureController.grabFlag {
                    //nodeB.simdTransform = self.gestureController.handNode.simdTransform
                    nodeB.transform = self.gestureController.handNode.transform
                }
            }
        }
        
        if (nodeA.name == "evaH_video" && nodeB.name == "hand") || (nodeB.name == "evaH_video" && nodeA.name == "hand") {
            //print("index & evaH_video collide!")
            if nodeA.name == "evaH_video"{
                if gestureController.grabFlag {
                    //nodeA.simdTransform = self.gestureController.handNode.simdTransform
                    nodeA.simdTransform = self.gestureController.handNode.simdTransform
                }
            } else {
                if gestureController.grabFlag {
                    //nodeB.simdTransform = self.gestureController.handNode.simdTransform
                    nodeB.simdTransform = self.gestureController.handNode.simdTransform
                }
            }
        }
        
        
        //一時的！
        if (nodeA.name == "videoPlayButtonNode" && nodeB.name == "index") || (nodeB.name == "videoPlayButtonNode" && nodeA.name == "index") {
            if self.pauseFlag == false {
                self.pauseFlag = true
                print("pause押された")
                let nowARVideo = self.nowARVideo
                if nowARVideo.playNow == true {
                    nowARVideo.pause()
                    nowARVideo.playButton.changeImage(image: UIImage(named: "play.png")!)
                } else {
                    nowARVideo.play()
                    nowARVideo.playButton.changeImage(image: UIImage(named: "pause.png")!)
                }
            }
        }
        
        
        
        if (nodeA.name == "video_IconNode" && nodeB.name == "index") || (nodeB.name == "video_IconNode" && nodeA.name == "index") {
            if videoAppFlag == false{
                print("index & video_IconNode")
                videoAppFlag = true //1度きり
                
                 //起動した後のvideoNodeの位置を保存
                for child in self.menuAppSelection.childNodes{
                    if child.name != "video_IconNode" {
                        let moveLeft = SCNAction.moveBy(x: 0, y: 0, z: -0.5, duration: 1)
                        moveLeft.timingMode = .easeIn
                        child.runAction(SCNAction.sequence([moveLeft,SCNAction.fadeOut(duration: 0.5)]))
                    }
                }
                if nodeA.name == "video_IconNode"{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        //奥側へひっこみながら回転して拡大
                        let moveToOut = SCNAction.moveBy(x: 0.12, y: 0.4, z: -0.1, duration: 1.0) //ワールド座標
                        let scale = SCNAction.scale(by: 5, duration: 1.0)
                        let rotation = SCNAction.rotateBy(x: CGFloat(80 * (Float.pi / 180)), y: 0, z: 0, duration: 1.0) //なぜか90だといきすぎ
                        moveToOut.timingMode = .easeIn
                        scale.timingMode = .easeIn
                        rotation.timingMode = .easeIn
                        nodeA.runAction(SCNAction.sequence([
                            SCNAction.group([
                                moveToOut,
                                rotation,
                                scale
                                ]),
                            SCNAction.wait(duration: 1),
                            SCNAction.fadeOut(duration: 0.5),
                            ]))
                    }

                } else{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        //奥側へひっこみながら回転して拡大
                        let moveToOut = SCNAction.moveBy(x: 0.12, y: 0.4, z: -0.1, duration: 1.0)
                        let scale = SCNAction.scale(by: 5, duration: 1.0)
                        let rotation = SCNAction.rotateBy(x: CGFloat(80 * (Float.pi / 180)), y: 0, z: 0, duration: 1.0) //なぜか90だといきすぎ
                        moveToOut.timingMode = .easeIn
                        scale.timingMode = .easeIn
                        rotation.timingMode = .easeIn
                        nodeB.runAction(SCNAction.sequence([
                            SCNAction.group([
                                moveToOut,
                                rotation,
                                scale
                                ]),
                            SCNAction.wait(duration: 1),
                            SCNAction.fadeOut(duration: 0.5)]))
                    }
                    
                }
                
                let dispatchGroup = DispatchGroup()
                let dispatchQueue = DispatchQueue(label: "queue", attributes: .concurrent)
                dispatchGroup.enter()
                dispatchQueue.async(group: dispatchGroup) {
                    menuNodeShin.position = self.menuAppSelection.convertPosition(SCNVector3(-0.30, 0.066, 0.55), to: nil)
                    menuNodeINCEPTION.position = self.menuAppSelection.convertPosition(SCNVector3(-0.30, 0.033, 0.35), to: nil)
                    menuNodeSummer.position = self.menuAppSelection.convertPosition(SCNVector3(-0.30, 0, 0.15), to: nil)
                    menuNodeINTERSTELLAR.position = self.menuAppSelection.convertPosition(SCNVector3(-0.30, -0.033, -0.05), to: nil)
                    
                    menuNodeFive.position = self.menuAppSelection.convertPosition(SCNVector3(-0.15, 0.048, 0.45), to: nil)
                    menuNodeJ.position = self.menuAppSelection.convertPosition(SCNVector3(-0.15, 0.015, 0.25), to: nil)
                    menuNodeARRIVAL.position = self.menuAppSelection.convertPosition(SCNVector3(-0.15, -0.018, 0.05), to: nil)
                    menuNodeJURASSIC.position = self.menuAppSelection.convertPosition(SCNVector3(-0.15, -0.051, -0.15), to: nil)
                    
                    
                    menuNodeOrange.position = self.menuAppSelection.convertPosition(SCNVector3(0.0, 0.066, 0.55), to: nil)
                    menuNodeCoil.position = self.menuAppSelection.convertPosition(SCNVector3(0.0, 0.033, 0.35), to: nil)
                    menuNodeH.position = self.menuAppSelection.convertPosition(SCNVector3(0.0, 0, 0.15), to: nil)
                    menuNodeMat.position = self.menuAppSelection.convertPosition(SCNVector3(0.0, -0.033, -0.05), to: nil)
                    menuNodeYojo.position = self.menuAppSelection.convertPosition(SCNVector3(0.0, -0.066, -0.25), to: nil)
                    
                    
                    menuNodePap.position = self.menuAppSelection.convertPosition(SCNVector3(0.15, 0.048, 0.45), to: nil)
                    menuNodeQ.position = self.menuAppSelection.convertPosition(SCNVector3(0.15, 0.015, 0.25), to: nil)
                    menuNodeSherlock.position = self.menuAppSelection.convertPosition(SCNVector3(0.15, -0.018, 0.05), to: nil)
                    menuNodeRampage.position = self.menuAppSelection.convertPosition(SCNVector3(0.15, -0.051, -0.15), to: nil)
                    
                    menuNodeKeion.position = self.menuAppSelection.convertPosition(SCNVector3(0.30, 0.066, 0.55), to: nil)
                    menuNodeHOMEALONE.position = self.menuAppSelection.convertPosition(SCNVector3(0.30, 0.033, 0.35), to: nil)
                    menuNodeReady.position = self.menuAppSelection.convertPosition(SCNVector3(0.30, 0, 0.15), to: nil)
                    menuNodeToystory.position = self.menuAppSelection.convertPosition(SCNVector3(0.30, -0.033, -0.05), to: nil)
                }
                 dispatchGroup.leave()
                
                
                
//                menuNodeCoil.position = SCNVector3(-0.15, 0, 0.65)
//                menuNodeFive.position = SCNVector3(-0.15, 0, 0.45)
//                menuNodeJ.position = SCNVector3(-0.15, 0, 0.25)
//                menuNodeARRIVAL.position = SCNVector3(-0.15, 0, 0.05)
//                menuNodeH.position = SCNVector3(0.0, 0, 0.15)
//                menuNodeQ.position = SCNVector3(0.15, 0, 0.25)
                
                //起動中のアプリボタン
                ViewController.nowAppNode.changeImage(image:UIImage(named: "videoIcon.png")!) //videoIconに
                //ViewController.nowAppNode.position = menuAppSelection.convertPosition(SCNVector3(0.30, 0, 0), to: nil)
                ViewController.nowAppNode.position = SCNVector3(0.22, -0.10, 0)
                //ViewController.nowAppNode.rotation = SCNVector4(1, 0, 0, 0.45 * Float.pi)
                //ホームへ戻るボタン
                //ViewController.mainMenuBackButton.position = menuAppSelection.convertPosition(SCNVector3(0.30, 0, 0), to: nil)
                ViewController.mainMenuBackButton.position = SCNVector3(0.22, -0.15, 0)
                //ViewController.mainMenuBackButton.rotation = SCNVector4(1, 0, 0, 0.45 * Float.pi)
                
                
                evaSelection.addChildNode(menuNodeShin)
                evaSelection.addChildNode(menuNodeINCEPTION)
                evaSelection.addChildNode(menuNodeSummer)
                evaSelection.addChildNode(menuNodeINTERSTELLAR)
                evaSelection.addChildNode(menuNodeJURASSIC)
                
                evaSelection.addChildNode(menuNodeJ)
                evaSelection.addChildNode(menuNodeARRIVAL)
                evaSelection.addChildNode(menuNodeCoil)
                evaSelection.addChildNode(menuNodeFive)
                
                evaSelection.addChildNode(menuNodeOrange)
                evaSelection.addChildNode(menuNodeCoil)
                evaSelection.addChildNode(menuNodeH)
                evaSelection.addChildNode(menuNodeMat)
                evaSelection.addChildNode(menuNodeYojo)
                
                evaSelection.addChildNode(menuNodePap)
                evaSelection.addChildNode(menuNodeQ)
                evaSelection.addChildNode(menuNodeSherlock)
                
                evaSelection.addChildNode(menuNodeKeion)
                evaSelection.addChildNode(menuNodeHOMEALONE)
                evaSelection.addChildNode(menuNodeReady)
                evaSelection.addChildNode(menuNodeToystory)
                evaSelection.addChildNode(menuNodeRampage)
                
                
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5){
                    self.sceneView.scene.rootNode.addChildNode(self.evaSelection)
                    self.menuAppSelection.addChildNode(ViewController.nowAppNode)
                    self.menuAppSelection.addChildNode(ViewController.mainMenuBackButton)
                }
            }
        }
        
        //amazonの起動
        if (nodeA.name == "amazon_IconNode" && nodeB.name == "index") || (nodeB.name == "amazon_IconNode" && nodeA.name == "index") {
            if amazonAppFlag == false{
                print("index & amazon_IconNode")
                amazonAppFlag = true //1度きり
            
                
                for child in self.menuAppSelection.childNodes{
                    if child.name != "amazon_IconNode" {
                        let moveLeft = SCNAction.moveBy(x:0, y: 0, z: -0.5, duration: 1)
                        moveLeft.timingMode = .easeIn
                        child.runAction(SCNAction.sequence([moveLeft,SCNAction.fadeOut(duration: 0.5)]))
                    }
                }
                if nodeA.name == "amazon_IconNode" {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        //奥側へひっこみながら回転して拡大
                        let moveToOut = SCNAction.moveBy(x: 0.12, y: 0.4, z: -0.1, duration: 1.0)
                        let scale = SCNAction.scale(by: 5, duration: 1.0)
                        let rotation = SCNAction.rotateBy(x: CGFloat(80 * (Float.pi / 180)), y: 0, z: 0, duration: 1.0) //なぜか90だといきすぎ
                        moveToOut.timingMode = .easeIn
                        scale.timingMode = .easeIn
                        rotation.timingMode = .easeIn
                        nodeA.runAction(SCNAction.sequence([
                            SCNAction.group([
                                moveToOut,
                                rotation,
                                scale
                                ]),
                            SCNAction.wait(duration: 1),
                            SCNAction.fadeOut(duration: 0.5),
                            ]))
                    }
                    
                } else{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        //奥側へひっこみながら回転して拡大
                        let moveToOut = SCNAction.moveBy(x: 0.12, y: 0.4, z: -0.1, duration: 1.0)
                        let scale = SCNAction.scale(by: 5, duration: 1.0)
                        let rotation = SCNAction.rotateBy(x: CGFloat(80 * (Float.pi / 180)), y: 0, z: 0, duration: 1.0) //なぜか90だといきすぎ
                        moveToOut.timingMode = .easeIn
                        scale.timingMode = .easeIn
                        rotation.timingMode = .easeIn
                        nodeB.runAction(SCNAction.sequence([
                            SCNAction.group([
                                moveToOut,
                                rotation,
                                scale
                                ]),
                            SCNAction.wait(duration: 1),
                            SCNAction.fadeOut(duration: 0.5),
                            ]))
                    }
                }
                let dispatchGroup = DispatchGroup()
                let dispatchQueue = DispatchQueue(label: "queue", attributes: .concurrent)
                dispatchGroup.enter()
                dispatchQueue.async(group: dispatchGroup) {
                    //検索したいものを置いてくださいwindow
                    ViewController.searchFieldNode.rotation = SCNVector4(1, 0, 0, 0.45 * Float.pi)
                    ViewController.searchFieldNode.position = SCNVector3(0.05, 0.15, 0)
                    //矢印ノード
                    ViewController.downArrowNode.rotation = SCNVector4(1, 0, 0, 0.45 * Float.pi)
                    ViewController.downArrowNode.position = SCNVector3(0.05, 0.12, 0)
                    //検索ノード
                    ViewController.searchNode.position = SCNVector3(0.05, -0.1, 0)
                
                
                    //起動中のアプリボタン
                    ViewController.nowAppNode.changeImage(image:UIImage(named: "amazonIcon.png")!) //videoIconに
                    //ViewController.nowAppNode.position = menuAppSelection.convertPosition(SCNVector3(0.30, 0, 0), to: nil)
                    ViewController.nowAppNode.position = SCNVector3(0.22, -0.10, 0)
                    //ViewController.nowAppNode.rotation = SCNVector4(1, 0, 0, 0.45 * Float.pi)
                    //ホームへ戻るボタン
                    //ViewController.mainMenuBackButton.position = menuAppSelection.convertPosition(SCNVector3(0.30, 0, 0), to: nil)
                    ViewController.mainMenuBackButton.position = SCNVector3(0.22, -0.15, 0)
                    //ViewController.mainMenuBackButton.rotation = SCNVector4(1, 0, 0, 0.45 * Float.pi)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5){
                    
                    self.menuAppSelection.addChildNode(ViewController.nowAppNode)
                    self.menuAppSelection.addChildNode(ViewController.mainMenuBackButton)
                    
                    self.amazonAppMenu.addChildNode(ViewController.searchFieldNode)
                    self.amazonAppMenu.addChildNode(ViewController.downArrowNode)
                    self.amazonAppMenu.addChildNode(ViewController.searchNode)
                    self.menuAppSelection.addChildNode(self.amazonAppMenu)
                    
                    let action1 = SCNAction.moveBy(x: 0, y: 0, z: -0.1, duration: 2)
                    action1.timingMode = .easeInEaseOut
                    let action2 = SCNAction.wait(duration: 0.5)
                    ViewController.downArrowNode.runAction(
                        SCNAction.repeatForever(
                            SCNAction.sequence([
                                action1,
                                action2,
                                action1.reversed()
                                ])
                        )
                    )
                }
            }
        }
        
        //amazonで検索
        if (nodeA.name == "searchNode" && nodeB.name == "index") || (nodeB.name == "searchNode" && nodeA.name == "index") {
            if amazonSearchFlag == false{
                print("index & searchNode")
                amazonSearchFlag = true //1度きり
                
                for child in self.amazonAppMenu.childNodes{
                    if child.name != "searchNode" {
                        child.runAction(SCNAction.fadeOut(duration: 0.5))
                    }
                }
                if nodeA.name == "searchNode" {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        nodeA.runAction(SCNAction.fadeOut(duration: 1.0))
                    }
                } else{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        nodeB.runAction(SCNAction.fadeOut(duration: 1.0))
                    }
                }
                
                
                //GoogleCustomVision & Google検索
                // CVPixelBufferでカメラ画像を取得して，それをUIImageに変換してbase64EncodeImageに渡す
                guard let captureImage = sceneView.session.currentFrame?.capturedImage else {
                    return
                }   //CVPixelBuffer
                let ciImage = CIImage(cvPixelBuffer: captureImage)
                //CIImageからCGImageを作成
                let captureImageWidth = CGFloat(CVPixelBufferGetWidth(captureImage))
                let captureImageHeight = CGFloat(CVPixelBufferGetHeight(captureImage))
                let imageRect:CGRect = CGRect(x:0, y:0, width:captureImageWidth, height:captureImageHeight)
                let ciContext = CIContext.init()
                let cgimage = ciContext.createCGImage(ciImage, from: imageRect )
                // CGImageからUIImageを作成
                let myImage = UIImage(cgImage: cgimage!)
                
                let binaryImageData = base64EncodeImage(myImage)
                createVisionRequest(with: binaryImageData) ////googleCustomSearchのquery変数にbestGuessLabelが代入
                //検索結果返ってくるまで次のコードにはいかない？
                
                print("GoogleCustomVision success")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                    self.webView.loadRequest(URLRequest(url: URL(string: amazonSearchResultURL)!))
                    let webPlane = SCNPlane(width: 1.6, height: 1.2)
                    webPlane.firstMaterial?.diffuse.contents = self.webView//SKScene(size: CGSize(width: 1920, height: 1080))//webView
                    webPlane.firstMaterial?.isDoubleSided = true
                    
                    //webPlaneNodeのgeometryにwebPlaneを貼り付ける
                    let webPlaneNode = SCNNode(geometry: webPlane)
                    //self.webPlaneNode.simdTransform = webPlane_simdTransform
                    //webPlaneNode.eulerAngles = webPlane_eulerAngles
                    
                    
                    let planeShape = SCNPhysicsShape(geometry: SCNBox(width: 1.6, height: 1.2, length: 0.1, chamferRadius: 0), options: nil)
                    //衝突判定に使うのはwebPlaneNodeであってARWebViewNodeではない
                    webPlaneNode.name = "resultWebPageNode" //name
                    webPlaneNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: planeShape)
                    webPlaneNode.physicsBody?.categoryBitMask = 0b1000
                    webPlaneNode.physicsBody?.collisionBitMask = 0b0100
                    webPlaneNode.physicsBody?.contactTestBitMask = 0b0010 //handやfingerと接触するように
                    webPlaneNode.physicsBody?.isAffectedByGravity = false
                    

                    self.amazonAppMenu.addChildNode(webPlaneNode)
                    webPlaneNode.position = SCNVector3(0.05, 0.4, 0)
                    webPlaneNode.rotation = SCNVector4(1, 0, 0, 0.45 * Float.pi)
                }
                
//                let resultWebPageNode = ARWebViewNode(amazonSearchResultURL, 0.4, 0.3,  "resultWebPageNode")
//                resultWebPageNode.webPlaneNode.position = SCNVector3(0.05, -0.15, 0)
//                resultWebPageNode.webPlaneNode.rotation = SCNVector4(1, 0, 0, 0.45 * Float.pi)
//                self.amazonAppMenu.addChildNode(resultWebPageNode.webPlaneNode)
                
                //let webView = WKWebView(frame:CGRect(x:0, y:0, width:640, height:480))
                //let webView = UIWebView(frame: CGRect(x: 0, y: 0, width: 640, height: 480))
                //        // create a web view
                //        self.webView.loadRequest(URLRequest(url: URL(string: requestURL)!))
                //webView.load(URLRequest(url: URL(string: amazonSearchResultURL)!))
                //webView.loadRequest(URLRequest(url: URL(string: amazonSearchResultURL)!))
                //webView.scrollView.contentOffset.y=200;//任意の数字
                
                //webPlaneのmaterialにwebVieを指定
                //self.webView.load(URLRequest(url: URL(string: amazonSearchResultURL)!))
                
//                let webPlane = SCNPlane(width: 0.4, height: 0.3)
//                self.webView.loadRequest(URLRequest(url: URL(string: amazonSearchResultURL)!))
//                webPlane.firstMaterial?.diffuse.contents = self.webView//SKScene(size: CGSize(width: 1920, height: 1080))//webView
//                webPlane.firstMaterial?.isDoubleSided = true
//                
//                //webPlaneNodeのgeometryにwebPlaneを貼り付ける
//                let webPlaneNode = SCNNode(geometry: webPlane)
//                //self.webPlaneNode.simdTransform = webPlane_simdTransform
//                //webPlaneNode.eulerAngles = webPlane_eulerAngles
//                
//                
//                let planeShape = SCNPhysicsShape(geometry: SCNBox(width: 0.4, height: 0.3, length: 0.1, chamferRadius: 0), options: nil)
//                //衝突判定に使うのはwebPlaneNodeであってARWebViewNodeではない
//                webPlaneNode.name = "resultWebPageNode" //name
//                webPlaneNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: planeShape)
//                webPlaneNode.physicsBody?.categoryBitMask = 0b1000
//                webPlaneNode.physicsBody?.collisionBitMask = 0b0100
//                webPlaneNode.physicsBody?.contactTestBitMask = 0b0010 //handやfingerと接触するように
//                webPlaneNode.physicsBody?.isAffectedByGravity = false
//                
//                
//                webPlaneNode.position = SCNVector3(0.05, -0.15, 0)
//                webPlaneNode.rotation = SCNVector4(1, 0, 0, 0.45 * Float.pi)
//                self.amazonAppMenu.addChildNode(webPlaneNode)
            }
        }
        
        
        //mainMenuBack
        if (nodeA.name == "mainMenuBackButtonNode" && nodeB.name == "index") || (nodeB.name == "mainMenuBackButtonNode" && nodeA.name == "index") {
            //videoAppを起動中だったら
            if videoAppFlag == true {
                videoAppFlag = false
                evaSelection.removeFromParentNode()
                
                //videoノードのプロパティをもとに戻す
                ViewController.videoIconNode.opacity = 1.0
                ViewController.videoIconNode.rotation = SCNVector4(1, 0, 0, -CGFloat(0.001 * (Float.pi / 180)))
                ViewController.videoIconNode.scale = SCNVector3(1.0, 1.0, 1.0)
                
                if self.evaQFlag == true {
                    self.evaQFlag = false
                    self.videoScreens.removeFromParentNode()
                    self.videoPlay = false
                    nowARVideo.pause()
                } else if self.evaHFlag == true {
                    self.evaHFlag = false
                    self.videoScreens.removeFromParentNode()
                    self.videoPlay = false
                    nowARVideo.pause()
                }
                
            } else if amazonAppFlag == true {
                ViewController.amazonIconNode.rotation = SCNVector4(1, 0, 0, -CGFloat(0.001 * (Float.pi / 180)))
                amazonAppFlag = false
                
                //すべてのamazonAppMenuの子ノードを削除
                for c in self.amazonAppMenu.childNodes {
                    c.removeFromParentNode()
                    c.opacity = 1.0
                }
                
                amazonSearchFlag = false //検索できるように
                
                amazonAppMenu.removeFromParentNode()
            }
            
            //MainMenu
            
            //表示
            ViewController.weatherIconNode.opacity = 1.0
            ViewController.videoIconNode.opacity = 1.0
            ViewController.mailIconNode.opacity = 1.0
            ViewController.appstoreIconNode.opacity = 1.0
            ViewController.safariIconNode.opacity = 1.0
            ViewController.amazonIconNode.opacity = 1.0
            ViewController.musicIconNode.opacity = 1.0
            ViewController.photoIconNode.opacity = 1.0
            
            //scaleを0に初期化
            ViewController.weatherIconNode.scale = SCNVector3(0.0, 0.0, 0.0)
            ViewController.videoIconNode.scale = SCNVector3(0.0, 0.0, 0.0)
            ViewController.mailIconNode.scale = SCNVector3(0.0, 0.0, 0.0)
            ViewController.appstoreIconNode.scale = SCNVector3(0.0, 0.0, 0.0)
            ViewController.safariIconNode.scale = SCNVector3(0.0, 0.0, 0.0)
            ViewController.amazonIconNode.scale = SCNVector3(0.0, 0.0, 0.0)
            ViewController.musicIconNode.scale = SCNVector3(0.0, 0.0, 0.0)
            ViewController.photoIconNode.scale = SCNVector3(0.0, 0.0, 0.0)
            
            
            menuAppSelection.addChildNode(ViewController.videoIconNode)
            menuAppSelection.addChildNode(ViewController.amazonIconNode)
            menuAppSelection.addChildNode(ViewController.mailIconNode)
            menuAppSelection.addChildNode(ViewController.weatherIconNode)
            menuAppSelection.addChildNode(ViewController.appstoreIconNode)
            menuAppSelection.addChildNode(ViewController.safariIconNode)
            menuAppSelection.addChildNode(ViewController.musicIconNode)
            menuAppSelection.addChildNode(ViewController.photoIconNode)
            
            
            ViewController.weatherIconNode.position = SCNVector3(0.06, 0, 0)
            ViewController.videoIconNode.position = SCNVector3(-0.06, 0, 0)
            ViewController.mailIconNode.position = SCNVector3(0.18, 0, 0)
            ViewController.appstoreIconNode.position = SCNVector3(-0.18, 0, 0)
            ViewController.safariIconNode.position = SCNVector3(0.06, -0.12, 0)
            ViewController.amazonIconNode.position = SCNVector3(-0.06, -0.12, 0)
            ViewController.musicIconNode.position = SCNVector3(0.18, -0.12, 0)
            ViewController.photoIconNode.position = SCNVector3(-0.18, -0.12, 0)
            //menuAppSelectionノードにAppノードを追加
            self.sceneView.scene.rootNode.addChildNode(menuAppSelection)
            
            ViewController.videoIconNode.pop()
            ViewController.weatherIconNode.pop()
            ViewController.amazonIconNode.pop()
            ViewController.safariIconNode.pop()
            
            //ちょっと遅れて周りも出現
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                ViewController.mailIconNode.pop()
                ViewController.appstoreIconNode.pop()
                ViewController.musicIconNode.pop()
                ViewController.photoIconNode.pop()
            }
            
            ViewController.nowAppNode.removeFromParentNode()
            ViewController.mainMenuBackButton.removeFromParentNode()
        }
        
    }
    
    
    
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == gestureController.indexNode.categoryBitMask || contact.bodyB.categoryBitMask == gestureController.indexNode.categoryBitMask{
            
            print("------------人差し指と衝突しました------------")
        }
    }
}
