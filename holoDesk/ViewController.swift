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
import WebKit

//amazonSearchResultのURL
var amazonSearchResultURL = "https://www.amazon.co.jp" //GoogleCustomSearchクラスの結果が返ってくる

//video選択肢
let imageJ = UIImage(named: "エヴァ序改.png")
let imageH = UIImage(named: "エヴァ破改.png")
let imageQ = UIImage(named: "エヴァQ改.png")
let image_ARRIVAL = UIImage(named: "ARRIVAL.png")
let image_GODFATHER = UIImage(named: "GODFATHER.png")
let image_HOMEALONE = UIImage(named: "HOMEALONE.png")
let image_INCEPTION = UIImage(named: "INCEPTION.png")
let image_INTERSTELLAR = UIImage(named: "INTERSTELLAR.png")
let image_JURASSIC = UIImage(named: "JURASSIC WORLD.png")
let image_Mission = UIImage(named: "MissionImpossible.png")
let image_Rampage = UIImage(named: "rampage.png")
let image_Ready = UIImage(named: "READY PLAYER ONE.png")
let image_Sherlock = UIImage(named: "SHERLOCK.png")
let image_Toystory = UIImage(named: "toystory3.png")
let image_Ave = UIImage(named: "アベンジャーズ.png")
let image_Keion = UIImage(named: "けいおん.png")
let image_Summer = UIImage(named: "サマーウォーズ.png")
let image_Shin = UIImage(named: "シン・ゴジラ.png")
let image_Pai = UIImage(named: "パイレーツ.png")
let image_Pap = UIImage(named: "パプリカ.png")
let image_Mat = UIImage(named: "マトリックス.png")
let image_Yojo = UIImage(named: "四畳半神話大系.jpg")
let image_Orange = UIImage(named: "時計じかけのオレンジ.png")
let image_Coil = UIImage(named: "電脳コイル.png")
let image_Five = UIImage(named: "秒速5センチメートル.png")
let image_description = UIImage(named: "evaQdescription.png")
let image_play = UIImage(named: "play.png")

let menuNodeJ = ARPlaneUINode(image:imageJ!, width:0.1, height:0.15, name:"evaJ_button")
let menuNodeH = ARPlaneUINode(image:imageH!, width:0.1, height:0.15, name:"evaH_button")
let menuNodeQ = ARPlaneUINode(image:imageQ!, width:0.1, height:0.15, name:"evaQ_button")
let menuNodeARRIVAL = ARPlaneUINode(image:image_ARRIVAL!, width:0.1, height:0.15, name:"ARRIVAL_button")
let menuNodeGODFATHER = ARPlaneUINode(image:image_GODFATHER!, width:0.1, height:0.15, name:"GODFATHER_button")
let menuNodeHOMEALONE = ARPlaneUINode(image:image_HOMEALONE!, width:0.1, height:0.15, name:"HOMEALONE_button")
let menuNodeINCEPTION = ARPlaneUINode(image:image_INCEPTION!, width:0.1, height:0.15, name:"INCEPTION_button")
let menuNodeINTERSTELLAR = ARPlaneUINode(image:image_INTERSTELLAR!, width:0.1, height:0.15, name:"INTERSTELLAR_button")
let menuNodeJURASSIC = ARPlaneUINode(image:image_JURASSIC!, width:0.1, height:0.15, name:"JURASSIC_button")
let menuNodeMission = ARPlaneUINode(image:image_Mission!, width:0.1, height:0.15, name:"Mission_button")
let menuNodeRampage = ARPlaneUINode(image:image_Rampage!, width:0.1, height:0.15, name:"Rampage_button")
let menuNodeReady = ARPlaneUINode(image:image_Ready!, width:0.1, height:0.15, name:"Ready_button")
let menuNodeSherlock = ARPlaneUINode(image:image_Sherlock!, width:0.1, height:0.15, name:"Sherlock_button")
let menuNodeToystory = ARPlaneUINode(image:image_Toystory!, width:0.1, height:0.15, name:"Toystory_button")
let menuNodeAve = ARPlaneUINode(image:image_Ave!, width:0.1, height:0.15, name:"Ave_button")
let menuNodeKeion = ARPlaneUINode(image:image_Keion!, width:0.1, height:0.15, name:"Keion_button")
let menuNodeSummer = ARPlaneUINode(image:image_Summer!, width:0.1, height:0.15, name:"Summer_button")
let menuNodeShin = ARPlaneUINode(image:image_Shin!, width:0.1, height:0.15, name:"Shin_button")
let menuNodePai = ARPlaneUINode(image:image_Pai!, width:0.1, height:0.15, name:"Pai_button")
let menuNodePap = ARPlaneUINode(image:image_Pap!, width:0.1, height:0.15, name:"Pap_button")
let menuNodeMat = ARPlaneUINode(image:image_Mat!, width:0.1, height:0.15, name:"Mat_button")
let menuNodeYojo = ARPlaneUINode(image:image_Yojo!, width:0.1, height:0.15, name:"Yojo_button")
let menuNodeOrange = ARPlaneUINode(image:image_Orange!, width:0.1, height:0.15, name:"Orange_button")
let menuNodeCoil = ARPlaneUINode(image:image_Coil!, width:0.1, height:0.15, name:"Coil_button")
let menuNodeFive = ARPlaneUINode(image:image_Five!, width:0.1, height:0.15, name:"Five_button")




let descriptionNode = ARPlaneUINode(image:image_description!, width:0.1, height:0.1, name:"description")
let playNode = ARPlaneUINode(image:image_play!, width:0.02, height:0.02, name:"description")

class ViewController: UIViewController, ARSCNViewDelegate, WebSocketDelegate{
    
    var videoPlay = false
    //videoを1度再生したかどうか
    var watchFlag = false
    //menuの表示フラグ
    var menuFlag = false
    //evaQの表示フラグ
    var evaQFlag = false
    //evaHの表示フラグ
    var evaHFlag = false
    //videoAppの立ち上がりフラグ
    var videoAppFlag = false
    //amazonAppの立ち上がりフラグ
    var amazonAppFlag = false
    //amazonAppの検索フラグ
    var amazonSearchFlag = false
    //menuのノード
    let menuAppSelection = SCNNode()
    //amazonAppMenuのノード
    let amazonAppMenu = SCNNode()
    //videoScreensのノード
    let videoScreens = SCNNode()
    
    
    
    //一時的なもの！！
    var nowARVideo = ARVideoNode("evaH4K.mov", 0.5, 0.375, simd_float4x4.init(), SCNVector3.init(), "evaH_video")
    var pauseFlag = false
    
    
    
    
    
    
    //amazonWeb
    var webView = UIWebView(frame: CGRect(x: 0, y: 0, width: 1280, height: 1280))
    
    //menuAppのノード
    static let videoIconImage = UIImage(named: "Videos.png")
    static let amazonIconImage = UIImage(named: "amazonIcon.png")
    static let mailIconImage = UIImage(named: "Mail.png")
    static let weatherIconImage = UIImage(named: "Weather.png")
    static let appstoreIconImage = UIImage(named: "AppStore.png")
    static let safariIconImage = UIImage(named: "Safari.png")
    static let musicIconImage = UIImage(named: "Music.png")
    static let photoIconImage = UIImage(named: "Photos.png")
    
    static let searchFieldImage = UIImage(named: "検索したいものをここに置いてください2.png")
    static let downArrowImage = UIImage(named: "矢印.png")
    static let searchImage = UIImage(named: "Search.png")
    
    static let mainMenuBackButtonImage = UIImage(named: "mainMenuBack.png")
    
    
    
    static let weatherIconNode = ARPlaneUINode(image:weatherIconImage!, width:0.08, height:0.08, name:"weather_IconNode")
    static let videoIconNode = ARPlaneUINode(image:videoIconImage!, width:0.08, height:0.08, name:"video_IconNode")
    static let mailIconNode = ARPlaneUINode(image:mailIconImage!, width:0.08, height:0.08, name:"mail_IconNode")
    static let appstoreIconNode = ARPlaneUINode(image:appstoreIconImage!, width:0.08, height:0.08, name:"appstore_IconNode")
    static let safariIconNode = ARPlaneUINode(image:safariIconImage!, width:0.08, height:0.08, name:"safari_IconNode")
    static let amazonIconNode = ARPlaneUINode(image:amazonIconImage!, width:0.08, height:0.08, name:"amazon_IconNode")
    static let musicIconNode = ARPlaneUINode(image:musicIconImage!, width:0.08, height:0.08, name:"music_IconNode")
    static let photoIconNode = ARPlaneUINode(image:photoIconImage!, width:0.08, height:0.08, name:"photo_IconNode")
    
    
    
    static let searchFieldNode = ARPlaneUINode(image:searchFieldImage!, width:0.64, height:0.36, name:"searchField")
    static let downArrowNode = ARPlaneUINode(image:downArrowImage!, width:0.10, height:0.10, name:"downArrow")
    static let searchNode = ARPlaneUINode(image:searchImage!, width:0.125, height:0.0375, name:"searchNode")
    
    
    
    //mainMenuBackのノード
    static let mainMenuBackButton = ARPlaneUINode(image:mainMenuBackButtonImage!, width:0.125, height:0.0375, name:"mainMenuBackButtonNode")
    static let nowAppNode = ARPlaneUINode(image:mailIconImage!, width: 0.04, height:0.04, name:"nowAppNode")
    
    
    
    //videoのノード
    let tvPlaneNode = SCNNode()
    
    //ヱヴァの選択肢
    let evaSelection = SCNNode()
    let session = URLSession.shared

    
    //GoogleCustomVisionAPI
    var googleVisionAPIKey = "AIzaSyCml-614nqJuRsUawSKQ1awPgpescoyl3I"
    var googleVisionURL: URL {
        return URL(string: "https://vision.googleapis.com/v1/images:annotate?key=\(googleVisionAPIKey)")!
    }
    
    //sceneは2つ用意
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var sceneView2: ARSCNView!
    
    var myLabel: UILabel!
    
    //ハンドジェスチャコントローラ
    var gestureController = GestureController()
    //WebSocket通信のサーバーアドレス
    //let socket = WebSocket(url: URL(string: "ws://10.213.198.127:6437")!)
    let socket = WebSocket(url: URL(string: "ws://192.168.11.25:6437")!)
    //let socket = WebSocket(url: URL(string: "ws://10.213.198.127:6437")!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //websocket通信確立
        socket.delegate = self
        socket.connect()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        //sceneView.showsStatistics = true
        
        // Scene/View setup
        
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        
        // Set up SceneView2 (Right Eye)
        sceneView2.scene = scene
        
        // ライト追加（handGestureControllerのレンダリング結果を立体的に見せるため）
        sceneView.autoenablesDefaultLighting = true;
//        // デバッグ用のポイントクラウド表示
//        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        //衝突判定
        sceneView.scene.physicsWorld.contactDelegate = self
    
        let myButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        
        //mainでもってきた
        webView.loadRequest(URLRequest(url: URL(string: amazonSearchResultURL)!))
        //webView.load(URLRequest(url: URL(string: amazonSearchResultURL)!))
        
        
        guard let cameraNode = self.sceneView.pointOfView else { return }
        gestureController.positionConverter(cameraNode: cameraNode)
        gestureController.renderingColor()
        gestureController.rendering(sceneNode: sceneView.scene.rootNode)
        
        menuNodeShin.position = menuAppSelection.convertPosition(SCNVector3(-0.30, 0.066, 0.55), to: nil)
        menuNodeINCEPTION.position = menuAppSelection.convertPosition(SCNVector3(-0.30, 0.033, 0.35), to: nil)
        menuNodeSummer.position = menuAppSelection.convertPosition(SCNVector3(-0.30, 0, 0.15), to: nil)
        menuNodeINTERSTELLAR.position = menuAppSelection.convertPosition(SCNVector3(-0.30, -0.033, -0.05), to: nil)
        
        menuNodeFive.position = menuAppSelection.convertPosition(SCNVector3(-0.15, 0.048, 0.45), to: nil)
        menuNodeJ.position = menuAppSelection.convertPosition(SCNVector3(-0.15, 0.015, 0.25), to: nil)
        menuNodeARRIVAL.position = menuAppSelection.convertPosition(SCNVector3(-0.15, -0.018, 0.05), to: nil)
        menuNodeJURASSIC.position = menuAppSelection.convertPosition(SCNVector3(-0.15, -0.051, -0.15), to: nil)
        
        
        menuNodeOrange.position = menuAppSelection.convertPosition(SCNVector3(0.0, 0.066, 0.55), to: nil)
        menuNodeCoil.position = menuAppSelection.convertPosition(SCNVector3(0.0, 0.033, 0.35), to: nil)
        menuNodeH.position = menuAppSelection.convertPosition(SCNVector3(0.0, 0, 0.15), to: nil)
        menuNodeMat.position = menuAppSelection.convertPosition(SCNVector3(0.0, -0.033, -0.05), to: nil)
        menuNodeYojo.position = menuAppSelection.convertPosition(SCNVector3(0.0, -0.066, -0.25), to: nil)
        
        
        menuNodePap.position = menuAppSelection.convertPosition(SCNVector3(0.15, 0.048, 0.45), to: nil)
        menuNodeQ.position = menuAppSelection.convertPosition(SCNVector3(0.15, 0.015, 0.25), to: nil)
        menuNodeSherlock.position = menuAppSelection.convertPosition(SCNVector3(0.15, -0.018, 0.05), to: nil)
        menuNodeRampage.position = menuAppSelection.convertPosition(SCNVector3(0.15, -0.051, -0.15), to: nil)
        
        menuNodeKeion.position = menuAppSelection.convertPosition(SCNVector3(0.30, 0.066, 0.55), to: nil)
        menuNodeHOMEALONE.position = menuAppSelection.convertPosition(SCNVector3(0.30, 0.033, 0.35), to: nil)
        menuNodeReady.position = menuAppSelection.convertPosition(SCNVector3(0.30, 0, 0.15), to: nil)
        menuNodeToystory.position = menuAppSelection.convertPosition(SCNVector3(0.30, -0.033, -0.05), to: nil)
        
        sceneView2.addSubview(myButton)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        // Run the view's session
        sceneView.session.run(configuration)
        
    }
    

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
    
    
    
    //レンダリングアップデート
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
//        DispatchQueue.main.async(
//            execute: {

                // UPDATE EVERY FRAME:
                guard let cameraNode = self.sceneView.pointOfView else { return }
                
                gestureController.positionConverter(cameraNode: cameraNode)
                gestureController.renderingColor()
                gestureController.rendering(sceneNode: sceneView.scene.rootNode)
                
                //            print(self.handNode.position)
                //            print(self.thumbNode.position)
                //            print(self.indexNode.position)
                //            print(self.middleNode.position)
                //            print(self.ringNode.position)
                //            print(self.pinkyNode.position)
        
        
        //机の上でグーしたらメニューが出現
        //なんかラグる
        if self.gestureController.grabFlag == true {
            if menuFlag == false {
                print("menu")
                menuFlag = true
                //        let videoIconButton_position = SCNVector3(x: -0.1, y: 0, z: -0.3)
                //            videoIconButton.position.y -= Float(0.2)
                //            videoIconButton.position.z -= Float(0.4)
                //menuAppSelectionノードのtransformをグーしたときの手のtransformに
                menuAppSelection.transform = self.gestureController.handNode.transform
                //menuAppSelection.position = SCNVector3(0, -0.5, -0.3)
                menuAppSelection.rotation = SCNVector4(1, 0, 0, -0.45 * Float.pi)
                
                let dispatchGroup = DispatchGroup()
                let dispatchQueue = DispatchQueue(label: "queue", attributes: .concurrent)
                dispatchGroup.enter()
                dispatchQueue.async(group: dispatchGroup) {
                    //scaleを0に初期化
                    ViewController.weatherIconNode.scale = SCNVector3(0.0, 0.0, 0.0)
                    ViewController.videoIconNode.scale = SCNVector3(0.0, 0.0, 0.0)
                    ViewController.mailIconNode.scale = SCNVector3(0.0, 0.0, 0.0)
                    ViewController.appstoreIconNode.scale = SCNVector3(0.0, 0.0, 0.0)
                    ViewController.safariIconNode.scale = SCNVector3(0.0, 0.0, 0.0)
                    ViewController.amazonIconNode.scale = SCNVector3(0.0, 0.0, 0.0)
                    ViewController.musicIconNode.scale = SCNVector3(0.0, 0.0, 0.0)
                    ViewController.photoIconNode.scale = SCNVector3(0.0, 0.0, 0.0)
                    
                    
                    self.menuAppSelection.addChildNode(ViewController.videoIconNode)
                    self.menuAppSelection.addChildNode(ViewController.amazonIconNode)
                    self.menuAppSelection.addChildNode(ViewController.mailIconNode)
                    self.menuAppSelection.addChildNode(ViewController.weatherIconNode)
                    self.menuAppSelection.addChildNode(ViewController.appstoreIconNode)
                    self.menuAppSelection.addChildNode(ViewController.safariIconNode)
                    self.menuAppSelection.addChildNode(ViewController.musicIconNode)
                    self.menuAppSelection.addChildNode(ViewController.photoIconNode)
                    
                    
                    ViewController.weatherIconNode.position = SCNVector3(0.06, 0, 0)
                    ViewController.videoIconNode.position = SCNVector3(-0.06, 0, 0)
                    ViewController.mailIconNode.position = SCNVector3(0.18, 0, 0)
                    ViewController.appstoreIconNode.position = SCNVector3(-0.18, 0, 0)
                    ViewController.safariIconNode.position = SCNVector3(0.06, -0.12, 0)
                    ViewController.amazonIconNode.position = SCNVector3(-0.06, -0.12, 0)
                    ViewController.musicIconNode.position = SCNVector3(0.18, -0.12, 0)
                    ViewController.photoIconNode.position = SCNVector3(-0.18, -0.12, 0)
                    //menuAppSelectionノードにAppノードを追加
                    self.sceneView.scene.rootNode.addChildNode(self.menuAppSelection)
                    
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
                }
                self.updateFrame()
                
                
                
                
                
//                ViewController.videoIconNode.position = SCNVector3(0.06, 0, 0)
//                ViewController.amazonIconNode.position = SCNVector3(-0.06, 0, 0)
//                ViewController.mailIconNode.position = SCNVector3(0.18, 0, 0)
//                ViewController.weatherIconNode.position = SCNVector3(-0.18, 0, 0)
//                ViewController.appstoreIconNode.position = SCNVector3(0.06, -0.12, 0)
                
                

//                ViewController.videoIconNode.rotation = SCNVector4(1, 0, 0, 0.50 * Float.pi)
//                ViewController.videoIconNode.transform = self.gestureController.handNode.transform
//                ViewController.videoIconNode.position.x += 0.06
//                ViewController.videoIconNode.position.y -= 0.03
//                ViewController.videoIconNode.rotation = SCNVector4(1, 0, 0, -0.50 * Float.pi)
//                ViewController.amazonIconNode.transform = self.gestureController.handNode.transform
//                ViewController.amazonIconNode.position.x -= 0.06
//                ViewController.amazonIconNode.position.y -= 0.03
//                ViewController.amazonIconNode.rotation = SCNVector4(1, 0, 0, -0.50 * Float.pi)
//                ViewController.mailIconNode.transform = self.gestureController.handNode.transform
//                ViewController.mailIconNode.position.x += 0.18
//                ViewController.mailIconNode.position.y -= 0.03
//                ViewController.mailIconNode.rotation = SCNVector4(1, 0, 0, -0.50 * Float.pi)
//                ViewController.weatherIconNode.transform = self.gestureController.handNode.transform
//                ViewController.weatherIconNode.position.x -= 0.18
//                ViewController.weatherIconNode.position.y -= 0.03
//                ViewController.weatherIconNode.rotation = SCNVector4(1, 0, 0, -0.50 * Float.pi)
//
//                ViewController.appstoreIconNode.transform = self.gestureController.handNode.transform
//                ViewController.appstoreIconNode.position.x += 0.06
//                ViewController.appstoreIconNode.position.y -= 0.03
//                ViewController.appstoreIconNode.position.z += 0.12
//                ViewController.appstoreIconNode.rotation = SCNVector4(1, 0, 0, -0.50 * Float.pi)
            }
        }
                //self.updateFrame()
        //})
    }
    
    func updateFrame() {

        // Clone pointOfView for Second View
        let pointOfView : SCNNode = (sceneView.pointOfView?.clone())!

        // Determine Adjusted Position for Right Eye
        let orientation : SCNQuaternion = pointOfView.orientation
        let orientationQuaternion : GLKQuaternion = GLKQuaternionMake(orientation.x, orientation.y, orientation.z, orientation.w)
        let eyePos : GLKVector3 = GLKVector3Make(1.0, 0.0, 0.0)
        let rotatedEyePos : GLKVector3 = GLKQuaternionRotateVector3(orientationQuaternion, eyePos)
        let rotatedEyePosSCNV : SCNVector3 = SCNVector3Make(rotatedEyePos.x, rotatedEyePos.y, rotatedEyePos.z)

        let mag : Float = 0.066 // This is the value for the distance between two pupils (in metres). The Interpupilary Distance (IPD).
        pointOfView.position.x += rotatedEyePosSCNV.x * mag
        pointOfView.position.y += rotatedEyePosSCNV.y * mag
        pointOfView.position.z += rotatedEyePosSCNV.z * mag

        // Set PointOfView for SecondView

    }
    

}


/// Image processing
extension ViewController {
    
    func analyzeResults(_ dataToParse: Data) {
        
        // Update UI on the main thread
        DispatchQueue.main.async(execute: {
            
            
            // Use SwiftyJSON to parse results
            let json = JSON(data: dataToParse)
            let errorObj: JSON = json["error"]
            
            //self.faceResults.isHidden = false
            //self.faceResults.text = ""
            
            // Check for errors
            if (errorObj.dictionaryValue != [:]) {
                print("error")
            } else {
                // Parse the response
                print(json["responses"][0]["webDetection"]["bestGuessLabels"][0]["label"])
                
                googleCustomSearch.query = json["responses"][0]["webDetection"]["bestGuessLabels"][0]["label"].string!  //googleCustomSearchのquery変数に代入
                let parameter = ["key": googleCustomSearch.googleSearchAPIKey,"cx":googleCustomSearch.cx,"q":json["responses"][0]["webDetection"]["bestGuessLabels"][0]["label"].string! ]
                // パラメータをエンコードしたURLを作成する
                let requestUrl = googleCustomSearch.createRequestUrl(parameter: parameter as! [String : String])
                
                googleCustomSearch.request(requestUrl: requestUrl)
                let responses: JSON = json["responses"][0]
                
                
                // Get label annotations
                let labelAnnotations: JSON = responses["labelAnnotations"]
                let numLabels: Int = labelAnnotations.count
                var labels: Array<String> = []
                if numLabels > 0 {
                    var labelResultsText:String = "Labels found: "
                    for index in 0..<numLabels {
                        let label = labelAnnotations[index]["description"].stringValue
                        labels.append(label)
                    }
                    for label in labels {
                        // if it's not the last item add a comma
                        if labels[labels.count - 1] != label {
                            labelResultsText += "\(label), "
                        } else {
                            labelResultsText += "\(label)"
                        }
                    }
                    //self.labelResults.text = labelResultsText
                } else {
                    //self.labelResults.text = "No labels found"
                    print("No labels found")
                }
            }
        })
        
    }
    
    func resizeImage(_ imageSize: CGSize, image: UIImage) -> Data {
        UIGraphicsBeginImageContext(imageSize)
        image.draw(in: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        let resizedImage = UIImagePNGRepresentation(newImage!)
        UIGraphicsEndImageContext()
        return resizedImage!
    }
}

/// Networking
extension ViewController {
    
    func base64EncodeImage(_ image: UIImage) -> String {
        var imagedata = UIImagePNGRepresentation(image)
        
        // Resize the image if it exceeds the 2MB API limit
        if (imagedata!.count > 2097152) {
            let oldSize: CGSize = image.size
            let newSize: CGSize = CGSize(width: 800, height: oldSize.height / oldSize.width * 800)
            imagedata = resizeImage(newSize, image: image)
        }
        
        return imagedata!.base64EncodedString(options: .endLineWithCarriageReturn)
    }
    
    func createVisionRequest(with imageBase64: String) {
        // Create our request URL
        
        var request = URLRequest(url: googleVisionURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(Bundle.main.bundleIdentifier ?? "", forHTTPHeaderField: "X-Ios-Bundle-Identifier")
        
        // Build our API request
        let jsonRequest = [
            "requests": [
                "image": [
                    "content": imageBase64
                ],
                "features": [
                    [
                        "type": "WEB_DETECTION",
                        "maxResults": 10
                    ],
                    [
                        "type": "TEXT_DETECTION",
                        "maxResults": 10
                    ]
                ]
            ]
        ]
        let jsonObject = JSON(jsonRequest)  //イニシャライザ注意！
        
        // Serialize the JSON
        guard let data = try? jsonObject.rawData() else {
            return
        }
        
        request.httpBody = data
        
        // Run the request on a background thread
        DispatchQueue.global().async { self.runRequestOnBackgroundThread(request) }
    }
    
    func runRequestOnBackgroundThread(_ request: URLRequest) {
        // run the request
        
        let task: URLSessionDataTask = session.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            
            self.analyzeResults(data)
        }
        
        task.resume()
    }
}

//websocket
extension ViewController {
    func websocketDidConnect(socket: WebSocketClient) {
        print("websocket is connected")
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        if let e = error as? WSError {
            print("websocket is disconnected: \(e.message)")
        } else if let e = error {
            print("websocket is disconnected: \(e.localizedDescription)")
        } else {
            print("websocket disconnected")
        }
    }
    
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("Received data: \(data.count)")
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        //print("got some text: \(text)")
        do{
            let resp = try! JSONDecoder().decode(trackingData.self, from: text.data(using: .utf8)!)
            //print("------------------------------")
            if let hands = resp.hands{
                if !hands.isEmpty {
                    //leap座標系からiPhoneワールド座標系に
                    //単位もmmからmに
                    //手のひらの向き（指を指している方向）
                    gestureController.hand.direction[0] = -hands[0].direction![0] //x = -z_leap
                    gestureController.hand.direction[1] = -hands[0].direction![2] //y = x_leap
                    gestureController.hand.direction[2] = -hands[0].direction![1] //z = -(y_leap + offset)
                    
                    //手のひらの向いている方向（法線ベクトル）
                    gestureController.hand.palmNormal[0] = -hands[0].palmNormal![0] //x = -z_leap
                    gestureController.hand.palmNormal[1] = -hands[0].palmNormal![2] //y = x_leap
                    gestureController.hand.palmNormal[2] = -hands[0].palmNormal![1] //z = -(y_leap + offset)
                    
                    //手の位置
                    gestureController.hand.palmPosition[0] = -hands[0].palmPosition![0] / 1000.0 //y = x_leap
                    gestureController.hand.palmPosition[1] = -hands[0].palmPosition![2] / 1000.0 //x = -z_leap
                    gestureController.hand.palmPosition[2] = -(hands[0].palmPosition![1] + offset) / 1000.0 //z = -(y_leap + offset)
                    
                    //                    gestureController.hand.palmPosition[0] = -hands[0].palmPosition![0] / 1000.0  //x = -x_leap
                    //                    gestureController.hand.palmPosition[1] = -hands[0].palmPosition![2] / 1000.0 - 0.15 //y = -z_leap
                    //                    gestureController.hand.palmPosition[2] = -(hands[0].palmPosition![1] + offset) / 1000.0 //z = -(y_leap + offset)
                    
                    //手のスピード
                    gestureController.hand.palmVelocity[0] = -hands[0].palmVelocity![0] / 1000.0 //x = -z_leap
                    gestureController.hand.palmVelocity[1] = -hands[0].palmVelocity![2] / 1000.0 //y = x_leap
                    gestureController.hand.palmVelocity[2] = -hands[0].palmVelocity![1] / 1000.0 //z = -(y_leap + offset)
                    
                    
                    //                    print("手のひらの向き：" + "\(gestureController.hand.direction)\n",
                    //                        "手のひらの向いている方向：" + "\(gestureController.hand.palmNormal)\n",
                    //                        "手のひらの位置：" + "\(gestureController.hand.palmPosition)\n")
                    //                    print("手のスピード：" + "\(gestureController.hand.palmVelocity)\n")
                    
                    //手がなきゃぜったい指はない
                    if let pointables = resp.pointables{
                        var finger_flag_statement = [Int]() //立っている指のidの下1桁を入れていく
                        if !pointables.isEmpty  {
                            gestureController.grabFlag = false //握ってない（何かしら指が出てる）
                            if pointables.count >= 1{
                                gestureController.switch_finger(id: pointables[0].id!, tipPosition: pointables[0].tipPosition!, tipDirection: pointables[0].direction!) //1本目の指を代入
                                finger_flag_statement.append(pointables[0].id! % 10)
                                if pointables.count >= 2{
                                    gestureController.switch_finger(id: pointables[1].id!, tipPosition: pointables[1].tipPosition!, tipDirection: pointables[1].direction!) //2本目の指を代入
                                    finger_flag_statement.append(pointables[1].id! % 10)
                                    if pointables.count >= 3{
                                        gestureController.switch_finger(id: pointables[2].id!, tipPosition: pointables[2].tipPosition!, tipDirection: pointables[2].direction!) //3本目の指を代入
                                        finger_flag_statement.append(pointables[2].id! % 10)
                                        if pointables.count >= 4{
                                            gestureController.switch_finger(id: pointables[3].id!, tipPosition: pointables[3].tipPosition!, tipDirection: pointables[3].direction!) //4本目の指を代入
                                            finger_flag_statement.append(pointables[3].id! % 10)
                                            if pointables.count >= 5{
                                                gestureController.switch_finger(id: pointables[4].id!, tipPosition: pointables[4].tipPosition!, tipDirection: pointables[4].direction!) //3本目の指を代入
                                                finger_flag_statement.append(pointables[4].id! % 10)
                                            }
                                        }
                                    }
                                }
                            }
                        } else {
                            gestureController.grabFlag = true   //握ってるとき
                        }
                        for i in 0..<5{
                            if finger_flag_statement.contains(i){
                                gestureController.finger_flag[i] = true
                            } else{
                                gestureController.finger_flag[i] = false
                            }
                        }
                    }
                }
            }
        }
    }
}

extension UIView {
    
    func GetImage() -> UIImage{
        
        // キャプチャする範囲を取得.
        let rect = self.bounds
        
        // ビットマップ画像のcontextを作成.
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        
        // 対象のview内の描画をcontextに複写する.
        self.layer.render(in: context)
        
        // 現在のcontextのビットマップをUIImageとして取得.
        let capturedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        // contextを閉じる.
        UIGraphicsEndImageContext()
        
        return capturedImage
    }
}
