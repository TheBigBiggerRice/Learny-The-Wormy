//
//  networkRequest.swift
//  LearnyTheWormy
//
//  Created by Chenyang Zhang on 10/28/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

//import Foundation
//
//func apiCall(statement: String, completionHandler: @escaping (_ result: String?) -> Void) {
//  let json: [String: String] = ["statement": statement]
//  let jsonData = try? JSONSerialization.data(withJSONObject: json)
//  let url = URL(string: "http://elbertw.pythonanywhere.com/learny/api/v1.0/eval")!
//  var request = URLRequest(url: url)
//  request.httpMethod = "POST"
//  request.httpBody = jsonData
//  request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//  let task = URLSession.shared.dataTask(with: request) { data, response, error in
//    guard let data = data, error == nil else {
//      print(error?.localizedDescription ?? "No data")
//      return
//    }
//    
//    let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
//    
//    if let responseJSON = responseJSON as? [String: String] {
//      completionHandler(responseJSON["result"])
//    }
//  }
//  task.resume()
//  
//}





