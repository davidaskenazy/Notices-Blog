//
//  NoticesList.swift
//  notices-blog
//
//  Created by David Askenazy on 01/07/2021.
//

import SwiftUI
//Primera pantalla a ver de noticias

struct NoticesList: View {
    @State var notices: [Notice] = []

    var body: some View {
        NavigationView{
        List{
            ForEach(Array(notices.enumerated()), id: \.offset){index,notices in
            HStack{
                VStack{
                    Text(notices.title)
                    Text(notices.subtitle).font(.subheadline).foregroundColor(.gray)
                }
                .padding()
                .frame(width: 250, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .bottom)
                VStack{
             
                    NavigationLink(
                        destination: DetailedNotice(bodyNotice: BodyNotice(id:1, body:"",noticeId: 1), notices: $notices[index]),
                        label: {
                            Text("Detailed")
                                
                        }
                    
                    )
                }
            }
            }
        }.onAppear(){
            Api().getListNotice{(notices) in
                self.notices = notices
                
            }
    }
    }
}
}
struct NoticesList_Previews: PreviewProvider {
    static var previews: some View {
        NoticesList()
    }
}
