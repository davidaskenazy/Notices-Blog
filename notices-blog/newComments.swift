//
//  newComments.swift
//  notices-blog
//
//  Created by David Askenazy on 05/07/2021.
//

import SwiftUI

struct newComments: View {
    //Estados del formulario
    @State var nameForm:String = ""
    @State var commentForm:String = ""
    @Binding var idComment:Int
    @State var cantComment: Int = 0

    var body: some View {

        
        
            Form{
                Section{
                TextField("Alias", text: $nameForm)
                TextField("Comentario", text:$commentForm)
                }
                Section{
                    Button(action: {

                        Api().postComment(idComment: cantComment, aliasComment: self.nameForm, textComment: self.commentForm, bodyNoticeId: self.idComment)
                        
                        print("cantidad comment : ", cantComment)
                        print("name: "+nameForm)
                            print("comment: "+commentForm)
                        print("idComment" ,idComment)
                        
                    }, label: {
                        Text("Enviar")
                    })
                }
            }.onAppear(){
                Api().getCantComments(completion: { comment in
                     self.cantComment = comment
                    self.cantComment += 1
                 print(self.cantComment)
                 })
            }

   
        

        
    }
}

struct newComments_Previews: PreviewProvider {
    static var previews: some View {
        newComments( idComment: .constant(1))
    }
}
