//
//  LoginView.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 19.07.2021.
//

import SwiftUI

struct LoginView: View {
    @State var email: String = ""
    
    @State var password: String = ""
    
    var body: some View {
        ZStack {
            Assets.Gradients.background
                .edgesIgnoringSafeArea(.vertical)
            
            VStack {
                VStack(alignment: .leading) {
                    Text("Email address")
                        .font(.italic(.body)())
                    
                    TextField("Enter email here", text: $email)
                        .textContentType(.emailAddress)
                        .autocapitalization(.none)
                        .foregroundColor(Assets.Colors.colorOnAccent)
                        .padding()
                        .background(Assets.Colors.formField)
                        .cornerRadius(3.0)
                }
                .padding()
                
                VStack(alignment: .leading) {
                    Text("Password")
                        .font(.italic(.body)())
                    
                    SecureField("Enter password here", text: $password)
                        .autocapitalization(.none)
                        .foregroundColor(Assets.Colors.colorOnAccent)
                        .padding()
                        .background(Assets.Colors.formField)
                        .cornerRadius(3.0)
                }
                .padding()
                
                Spacer()
                
                Button(action: {}, label: {
                    Text("Login").largeButton().padding()
                })
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
