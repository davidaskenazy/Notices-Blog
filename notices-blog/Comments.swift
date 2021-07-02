//
//  Comments.swift
//  notices-blog
//
//  Created by David Askenazy on 02/07/2021.
//

import SwiftUI

struct Comments: View {
    @State var comment: [Comment] = []
    @Binding var bodyNoticeId:String
    var body: some View {
        NavigationView{
        List{
            ForEach(Array(comment.enumerated()), id: \.offset){index,notices in
            HStack{
                VStack{
                    Text(comment[index].alias)
                    Text(comment[index].comment)
                }.frame(maxWidth:.infinity, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
     
            }
            }
        }.onAppear(){
            Api().getCommentsById(completion: {comment in
                self.comment = comment}, bodyNoticeId: bodyNoticeId)
        }
        .navigationBarTitle(Text("Comments"))
        }
       
    }
}

