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


struct Comment: Codable, Identifiable{
    var id : Int
    var alias : String
    var comment: String
    var bodyNoticeId : Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case alias
        case comment
        case bodyNoticeId = "body-noticeId"
    }
}

// al tener body-notice en el json y no poder referenciarlo linealmente


//
/*
 "id":1,
    "alias":"Nico",
    "comment":"HAHAH LOL!",
    "body-noticeId":1
 **/

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
    
    func getCantComments(completion: @escaping (Int) -> ()){
        guard let url = URL(string: "http://localhost:3000/comments") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let comment = try! JSONDecoder().decode([Comment].self, from:data!)
           
            DispatchQueue.main.async {
                completion(comment.count)
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
    
    // Commets by bodyNoticeID, la idea es basica... cada cuerpo de una noticia tiene determinados comentarios...
    // una especie de inner join (?)
    
    func getCommentsById(completion: @escaping ([Comment]) -> (), bodyNoticeId:String){
        guard let url = URL(string: "http://localhost:3000/body-notices/\(bodyNoticeId)/comments") else{
            return
        }
        URLSession.shared.dataTask(with:url){(data,_,_) in
            let comments = try! JSONDecoder().decode([Comment].self, from: data!)
            print(comments)
            DispatchQueue.main.async{
                completion(comments)
            }
            
        }
        .resume()
        
    }

    
    
    func postComment(idComment:Int, aliasComment:String, textComment:String, bodyNoticeId:Int) {
            guard let url = URL(string: "http://localhost:3000/comments") else {
                print("Error: cannot create URL")
                return
            }
            
       
            
            // Add data to the model
            let uploadDataModel = Comment(id: idComment, alias: aliasComment, comment: textComment, bodyNoticeId: bodyNoticeId)
            
            // Convert model to JSON data
            guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else {
                print("Error: Trying to convert model to JSON data")
                return
            }
            // Create the url request
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
            request.setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
            request.httpBody = jsonData
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard error == nil else {
                    print("Error: error calling POST")
                    print(error!)
                    return
                }
                guard let data = data else {
                    print("Error: Did not receive data")
                    return
                }
                guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                    print("Error: HTTP request failed")
                    return
                }
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        print("Error: Cannot convert data to JSON object")
                        return
                    }
                    guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                        print("Error: Cannot convert JSON object to Pretty JSON data")
                        return
                    }
                    guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                        print("Error: Couldn't print JSON in String")
                        return
                    }
                    
                    print(prettyPrintedJson)
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }.resume()
        }
}
