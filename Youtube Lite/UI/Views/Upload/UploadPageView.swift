//
//  UploadPageView.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 18.07.2021.
//

import SwiftUI

struct UploadPageView: View {
    @ObservedObject var user = User.currentUser
    
    @State var name: String = ""
    
    @State var description: String = ""
    
    @State var url: String = ""
    
    @State var tags: [String] = []
    
    @State var newTag: String = ""
    
    @State var errorMessage: String = ""
    
    var body: some View {
        ZStack {
            Gradient.background
            
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
                                    .foregroundColor(.colorOnAccent)
                                
                                Spacer()
                                
                                Button(action: { tags.remove(at: index) }, label: {
                                    Image(systemName: "minus")
                                })
                            }
                        }
                        .listRowBackground(Color.formField.cornerRadius(3.0))
                        
                        HStack {
                            TextField("Enter new tag here", text: $newTag)
                                .foregroundColor(.colorOnAccent)
                            
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
                        .listRowBackground(Color.formField.cornerRadius(3.0))
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                LoadingView(errorMessage: $errorMessage, isProcessing: .constant(false))
                
                Button(action: {
                    pressedUploadButton()
                }, label: {
                    Text("Upload").largeButton().padding()
                })
            }
            .disabled(!user.isAuthenticated)
            
            if (!user.isAuthenticated) {
                Gradient.background.opacity(0.5)
                
                Text("You have to be authenticated to post videos. Please go to profile page and sign up.")
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.title)
                    .foregroundColor(.colorOnAccent)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(Color.accent.cornerRadius(3.0 ))
                
            }
        }
    }
    
    private func resetVariables() {
        DispatchQueue.main.async {
            name = ""
            description = ""
            url = ""
            tags = []
        }
    }
    
    func pressedUploadButton() {
        guard !name.isEmpty,
              !description.isEmpty,
              !url.isEmpty,
              User.currentUser.id != nil else {
            DispatchQueue.main.async {
                errorMessage = "The data you entered is invalid"
            }
            return
        }
        
        DispatchQueue.main.async {
            errorMessage = "Posted!"
        }
        
        FirebaseHelper.shared.videoHelper.updateVideo(
            video: Video(
                id: UUID().uuidString,
                name: name,
                description: description,
                url: url,
                userUID: user.id!,
                tags: tags,
                stars: StarsData()
            )
        )
        
        resetVariables()
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
            .foregroundColor(.colorOnAccent)
            .padding()
            .background(Color.formField)
            .cornerRadius(3.0)
    }
}


struct UploadPageView_Previews: PreviewProvider {
    static var previews: some View {
        UploadPageView()
    }
}
