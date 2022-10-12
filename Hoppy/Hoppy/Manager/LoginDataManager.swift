//
//  LoginDataManager.swift
//  Hoppy
//
//  Created by Jaehyeok Lim on 2022/10/08.
//

import UIKit

class LoginDataManager: UIViewController {
    
    func loginDataManagerFunction(id: Int, email: String, profileUrl: String) {
        let semaphore = DispatchSemaphore (value: 0)
        print("\(id)")
        let parameters = "{\n  \"socialId\" : \(id),\n  \"email\" : \"\(email)\",\n  \"profileUrl\" : \"\(profileUrl)\"\n}"
        let postData = parameters.data(using: .utf8)
        var request = URLRequest(url: URL(string: "http://hoppy.r-e.kr/api/login/kakao")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
            return
          }
          
            let tokenData = String(data: data, encoding: .utf8)!
            print("TokenData: \(tokenData)")
            let tokenItem = TokenModel(token: tokenData)
            TokenList.append(tokenItem)
            
            semaphore.signal()
        }

        task.resume()
        semaphore.wait()
    }
}

//KaZTjCQ64p4bvWX1i5awm0cSCkWcGk5aN70OGeM9Cj102wAAAYPHZFsn
//2427802414
//https://k.kakaocdn.net/dn/cuJmPH/btrN5aPfBcp/xoNomBQOE8HQbxYU5hUnVK/img_110x110.jpg
