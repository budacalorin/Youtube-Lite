//
//  UploadPageView.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 18.07.2021.
//

import SwiftUI

struct UploadPageView: View {
    @State var name: String = ""
    
    @State var description: String = ""
    
    @State var url: String = ""
    
    @State var tags: [String] = []
    
    @State var newTag: String = ""
    
    @State var errorMessage: String = ""
    
    var body: some View {
        ZStack {
            Assets.Gradients.background
            
            
            VStack {
                FieldView(data: $name, title: "Name", hint: "Enter name here")
                
                FieldView(data: $description, title: "Description", hint: "Enter description here")
                
                FieldView(data: $url, title: "Video URL", hint: "Enter video URL here")
                
                VStack(alignment: .leading) {
                    Text("Tags")
                        .font(.italic(.body)())
                    
                    List {
                        ForEach(tags.indices, id: \.self) { index in
                            let tag = tags[index]
                            
                            HStack {
                                Text(tag)
                                    .foregroundColor(Assets.Colors.colorOnAccent)
                                
                                Spacer()
                                
                                Button(action: { tags.remove(at: index) }, label: {
                                    Image(systemName: "minus")
                                })
                            }
                        }
                        .listRowBackground(Assets.Colors.formField.cornerRadius(3.0))
                        
                        HStack {
                            TextField("Enter new tag here", text: $newTag)
                                .foregroundColor(Assets.Colors.colorOnAccent)
                            
                            Spacer()
                            
                            Button(action: {
                                withAnimation {
                                    if !newTag.isEmpty { tags.append(newTag) }
                                    newTag = ""
                                }
                            }, label: {
                                Image(systemName: "plus")
                            })
                        }
                        .listRowBackground(Assets.Colors.formField.cornerRadius(3.0))
                    }
                }
                .padding(.horizontal)
                
                if (!errorMessage.isEmpty) {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
                
                Button(action: {
                    pressedUploadButton()
                }, label: {
                    Text("Upload").largeButton().padding()
                })
            }
        }
    }
    
    func pressedUploadButton() {
        guard !name.isEmpty,
              !description.isEmpty,
              !url.isEmpty,
              User.currentUser.id != nil else {
            errorMessage = "The data you entered is invalid"
            return
        }
        
        FirebaseHelper.shared.videoHelper.updateVideo(
            video: Video(
                id: UUID().uuidString,
                name: name,
                description: description,
                url: url,
                userUID: User.currentUser.id!,
                tags: tags,
                stars: 0
            )
        )
    }
    
    init() {
        UITableView.appearance().backgroundColor = .none
        UITableViewCell.appearance().backgroundColor = .none
    }
}

fileprivate struct FieldView: View {
    @Binding var data: String
    
    let title: String
    
    let hint: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.italic(.body)())
            
            TextField(hint, text: $data)
                .field()
        }
        .padding(.horizontal)
    }
    
}

fileprivate extension View {
    func field() -> some View {
        return self
            .textContentType(.emailAddress)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .foregroundColor(Assets.Colors.colorOnAccent)
            .padding()
            .background(Assets.Colors.formField)
            .cornerRadius(3.0)
    }
}


struct UploadPageView_Previews: PreviewProvider {
    static var previews: some View {
        UploadPageView()
    }
}
