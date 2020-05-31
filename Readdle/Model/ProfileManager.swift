//
//  ProfileManager.swift
//  CustomCollectionLayout
//
//  Created by Vladimir Drozdin on 26/05/2020
//  Copyright © 2020 Vladimir Drozdin. All rights reserved.
//

import Foundation
import UIKit

struct ProfileManager {
    let masterUrl = "https://www.gravatar.com/avatar/"
    //let defaultImageUrl = "https%3A%2F%2Fpngimage.net%2Fwp-content%2Fuploads%2F2018%2F06%2Fprofile-png-5.png"
    
    func fetchGravatars(with url: String, gravatarComplitionHandler: @escaping (UIImage?, Error?) -> Void) {
          
        let md5Data = MD5(string:url)
        let md5Hex =  md5Data.map { String(format: "%02hhx", $0) }.joined()
            if let url = URL(string: self.masterUrl + md5Hex){
            let task = URLSession.shared.dataTask(with: url){ (data, urlResponse, error) in
                
            if error != nil{
                gravatarComplitionHandler(nil, error)
            }
                
            if let data = data {
                let image = UIImage(data: data)
                gravatarComplitionHandler(image, nil)
            }
        }
        task.resume()
   
            
    }
        
    }
}
