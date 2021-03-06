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


//GoogleCustomSearchに関するクラス
class googleCustomSearch {
    
    // APIを利用するためのアプリケーションID
    static let googleSearchAPIKey = "AIzaSyAvIRZn5M216tMHJ1gDQyfPfNkfq4Iliro"
    // APIのURL
    static let googleSearchURL: String = "https://www.googleapis.com/customsearch/v1"
    //利用するAPIのサーチタイプ
    static let searchType: String = "image"
    //APIを利用するためのサーチエンジンキー
    static let cx: String = "008287110170925205944:suodj0kmvbq"
    
    static var query: String = ""
    
    
    // パラメータのURLエンコード処理
    class func encodeParameter(key: String, value: String) -> String? {
        // 値をエンコードする
        guard let escapedValue = value.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
            // エンコード失敗
            return nil
        }
        // エンコードした値をkey=valueの形式で返却する
        return "\(key)=\(escapedValue)"
    }
    
    // URL作成処理
    class func createRequestUrl(parameter: [String: String]) -> String {
        var parameterString = ""
        for key in parameter.keys {
            // 値の取り出し
            guard let value = parameter[key] else {
                // 値なし。次のfor文の処理を行なう
                continue
            }
            
            // 既にパラメータが設定されていた場合
            if parameterString.lengthOfBytes(using: String.Encoding.utf8) > 0 {
                // パラメータ同士のセパレータである&を追加する
                parameterString += "&"
            }
            
            // 値をエンコードする
            guard let encodeValue = encodeParameter(key: key, value: value) else {
                // エンコード失敗。次のfor文の処理を行なう
                continue
            }
            // エンコードした値をパラメータとして追加する
            parameterString += encodeValue
            
        }
        let requestUrl = googleSearchURL + "?" + parameterString

        return requestUrl
    }
    
    // 検索結果をパース
    static func parseData(items: [Any], resultHandler: @escaping (([String]?) -> Void)) {
        
        for item in items {
            
            // レスポンスデータから画像の情報を取得する
            guard let item = item as? [String: Any], let imageURL = item["link"] as? String else {
                resultHandler(nil)
                return
            }
            print(imageURL)
            
            // 配列に追加
            //wordImageArray.append(imageURL)
        }
        
        //resultHandler(wordImageArray)
    }
    
    // リクエストを行う
    static func request(requestUrl: String) {
        // URL生成
        guard let url = URL(string: requestUrl) else {
            // URL生成失敗
            //resultHandler(nil)
            return
        }
        
        // リクエスト生成
        let request = URLRequest(url: url)
        
        // APIをコールして検索を行う
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            // 通信完了後の処理
            //print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue) ?? "")
            
            // エラーチェック
            guard error == nil else {
                // エラー表示
                /*
                 let alert = UIAlertController(title: "エラー", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                 
                 // UIに関する処理はメインスレッド上で行なう
                 DispatchQueue.main.async {
                 self.present(alert, animated: true, completion: nil)
                 }
                 */
                
                print("search error")
                //resultHandler(nil)
                return
            }
            
            // JSONで返却されたデータをパースして格納する
            guard let data = data else {
                print("dataFail")
                // データなし
                //resultHandler(nil)
                return
            }
            print("dataSuccess")
            
            //JSON形式への変換処理
            guard let jsonData = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any] else {
                // 変換失敗
                print("jsonFail")
                //resultHandler(nil)
                return
            }
            print("jsonSuccess")
            //JSON形式への変換処理
            
            //print(jsonData)
            
            // データを解析
//            guard let resultSet = jsonData["items"] as? [Any] else {
//                // データなし
//                print("resultFail")
//                //resultHandler(nil)
//                return
//            }
            if let resultSet = jsonData["items"] as? [Any] {
                print("items suscess")
                for page in resultSet {
                    print("for succcess")
                    if let pageDictionary = page as? Dictionary<String, AnyObject> {
                        print("pageDictionary success")
                        let link = pageDictionary["link"] as! String
                        print("link success")
                        if link.contains("https://www.amazon.co.jp/") {
                            amazonSearchResultURL = link
                            print("linkGetSuccess")
                            print(amazonSearchResultURL)
                            return 
                        } else{
                            print("contains failed")
                        }
                    } else {
                        print("dictionary fail")
                    }
                            
                }
            }

            //self.parseData(items: resultSet, resultHandler: resultHandler)
        }
        // 通信開始
        task.resume()
}
}

////GoogleCustomSearchリクエストのjsonを入れる構造体
//struct googleCustomSearchData: Codable {
//    let kind: String
//    let url: googleCustomSearchUrl
//    let queries: googleCustomSearchQueries
//    let context: googleCustomSearchcontext
//    let searchInformation: [String: Any]
//    let items: [pages]
//}
//
//struct pages: Codable {
//
//}
