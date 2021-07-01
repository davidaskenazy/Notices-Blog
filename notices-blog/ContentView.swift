//
//  ContentView.swift
//  notices-blog
//
//  Created by David Askenazy on 01/07/2021.
//

import SwiftUI

struct ContentView: View {
    var title:String =  "Venezuela en crisis"
    var subtitle:String = "La ciudad de caracas esta en peligro"
    @State var bodyNotice: BodyNotice

    var body: some View {
        VStack{
            Text("work")
        }.onAppear(){
            Api().getBodyNoticeById(completion: {bodyNotice in
                                        self.bodyNotice = bodyNotice}, idNotice: "2")
            

        }
    }
}



