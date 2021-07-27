//
//  UploadPageView.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 18.07.2021.
//

import SwiftUI

struct UploadPageView: View {
    @ObservedObject private var user = User.currentUser
    
    @StateObject private var viewModel = UploadViewModel()
    
    @Binding var showUser: Bool
    
    @Binding var showSearch: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                Gradient.background
                    .onTapGesture(perform: hideKeyboard)
                
                ScrollView {
                    VStack {
                        FieldView(data: $viewModel.name, title: "Name", hint: "Enter name here")
                        
                        FieldView(data: $viewModel.description, title: "Description", hint: "Enter description here")
                        
                        FieldView(data: $viewModel.url, title: "Video URL", hint: "Enter video URL here")
                        
                        VStack(alignment: .leading, spacing: 1) {
                            Text("Tags")
                                .font(.italic(.body)())
                                .padding(.bottom)
                            
                            ForEach(viewModel.tags.indices, id: \.self) { index in
                                let tag = viewModel.tags[index]
                                
                                HStack {
                                    Text(tag)
                                        .foregroundColor(.colorOnAccent)
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        DispatchQueue.main.async {
                                            viewModel.tags.remove(at: index)
                                        }
                                    }, label: {
                                        Image(systemName: "minus")
                                            .foregroundColor(.colorOnAccent)
                                    })
                                }
                            }
                            .padding()
                            .background(Color.formField.cornerRadius(3.0))
                            
                            HStack {
                                TextField("Enter new tag here", text: $viewModel.newTag)
                                    .foregroundColor(.colorOnAccent)
                                
                                Spacer()
                                
                                Button(action: {
                                    DispatchQueue.main.async {
                                        withAnimation {
                                            if !viewModel.newTag.isEmpty { viewModel.tags.append(viewModel.newTag) }
                                            viewModel.newTag = ""
                                        }
                                    }
                                }, label: {
                                    Image(systemName: "plus")
                                        .foregroundColor(.colorOnAccent)
                                })
                            }
                            .padding()
                            .background(Color.formField.cornerRadius(3.0))
                            
                            Spacer()
                            
                            LoadingView(errorMessage: $viewModel.errorMessage, isProcessing: .constant(false))
                        }
                        .padding(.horizontal)
                        
                        
                        Button(
                            action: viewModel.pressedUploadButton,
                            label: {
                                Text("Upload").largeButton().padding()
                            })
                    }
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
                        .padding()
                }
            }
            .setNavigationTitle(title: "Upload", showUser: $showUser, showSearch: $showSearch)
        }
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
        UploadPageView(showUser: .constant(false), showSearch: .constant(false))
    }
}
