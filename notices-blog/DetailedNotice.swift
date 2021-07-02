//
//  DetailedNotice.swift
//  notices-blog
//
//  Created by David Askenazy on 01/07/2021.
//

import SwiftUI

struct DetailedNotice: View {
    @State var bodyNotice: BodyNotice
    
    @Binding var notices : Notice
    var body: some View {
        
        VStack{
            Text(bodyNotice.body)
        }.onAppear(){
            Api().getBodyNoticeById(completion: {bodyNotice in
                self.bodyNotice = bodyNotice}, idNotice: String(notices.id))
            

        }
        Comments(bodyNoticeId: .constant(String(notices.noticeId)))
    }
}



