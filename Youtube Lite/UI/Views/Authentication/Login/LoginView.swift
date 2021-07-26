//
//  LoginView.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 19.07.2021.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
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
                        FirebaseHelper.shared.authenticator.signIn(email: email, password: password) { result, error in
                            DispatchQueue.main.async {
                                isProcessing = false
                                guard error == nil else {
                                    errorMessage = error?.localizedDescription ?? ""
                                    return
                                }
                            }
                        }
                    }, label: {
                        Text("Login").largeButton().padding()
                    })
                }
            }
            .onTapGesture(perform: hideKeyboard)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
