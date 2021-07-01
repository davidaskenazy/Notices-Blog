//
//  Data.swift
//  notices-blog
//
//  Created by David Askenazy on 01/07/2021.
//

import Foundation

struct Notice:Codable, Identifiable{
    let id : Int
    let title : String
    let subtitle : String
    let noticeId : Int
}

struct BodyNotice:Codable,Identifiable{
    let id : Int
    let body:String
    let noticeId:Int
}

class Api{
    //GENERAL LIST NOTICES
    func getListNotice(completion: @escaping ([Notice]) -> ()){
        guard let url = URL(string: "http://localhost:3000/notices") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let notices = try! JSONDecoder().decode([Notice].self, from:data!)
           
            DispatchQueue.main.async {
                completion(notices)
            }
        }
        .resume()
    }
    
    //BODY NOTICE BY ID
    
    func getBodyNoticeById(completion: @escaping (BodyNotice) -> (), idNotice:String){
        guard let url = URL(string: "http://localhost:3000/body-notices/\(idNotice)") else{
            return
        }
        URLSession.shared.dataTask(with: url) {(data,_,_) in
            let bodyNoticiaId = try! JSONDecoder().decode(BodyNotice.self, from: data!)
            print(bodyNoticiaId)
            DispatchQueue.main.async {
                completion(bodyNoticiaId)
            }
            
        }
        .resume()
    }
}
