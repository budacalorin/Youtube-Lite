//
//  SignupView.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 19.07.2021.
//

import SwiftUI

struct SignupView: View {
    @State var name: String = ""
    
    @State var email: String = ""
    
    @State var password: String = ""
    
    @State var errorMessage = ""
    
    @State var isProcessing = false
    
    var body: some View {
        ZStack {
            Gradient.background
            
            ScrollView {
                VStack {
                    VStack(alignment: .leading) {
                        Text("Name")
                            .font(.italic(.body)())
                        
                        TextField("Enter name here", text: $name)
                            .textContentType(.emailAddress)
                            .autocapitalization(.none)
                            .foregroundColor(.colorOnAccent)
                            .padding()
                            .background(Color.formField)
                            .cornerRadius(3.0)
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Email address")
                            .font(.italic(.body)())
                        
                        TextField("Enter email here", text: $email)
                            .textContentType(.emailAddress)
                            .autocapitalization(.none)
                            .foregroundColor(.colorOnAccent)
                            .padding()
                            .background(Color.formField)
                            .cornerRadius(3.0)
                            .disableAutocorrection(true)
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Password")
                            .font(.italic(.body)())
                        
                        SecureField("Enter password here", text: $password)
                            .autocapitalization(.none)
                            .foregroundColor(.colorOnAccent)
                            .padding()
                            .background(Color.formField)
                            .cornerRadius(3.0)
                    }
                    .padding()
                    
                    Spacer()
                    
                    LoadingView(errorMessage: $errorMessage, isProcessing: $isProcessing)
                    
                    Button(action: {
                        isProcessing = true
                        FirebaseHelper.shared.authenticator.signUp(email: email, password: password, name: name) { result, error in
                            DispatchQueue.main.async {
                                isProcessing = false
                                guard error == nil else {
                                    errorMessage = error!.localizedDescription
                                    return
                                }
                            }
                        }
                    }, label: {
                        Text("Sign Up").largeButton().padding()
                    })
                }
                .onTapGesture(perform: hideKeyboard)
            }
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
