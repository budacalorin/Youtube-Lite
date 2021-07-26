//
//  SignupView.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 19.07.2021.
//

import SwiftUI

struct SignupView: View {
    
    @StateObject private var viewModel = SignupViewModel()
    
    var body: some View {
        ZStack {
            Gradient.background
            
            ScrollView {
                VStack {
                    VStack(alignment: .leading) {
                        Text("Name")
                            .font(.italic(.body)())
                        
                        TextField("Enter name here", text: $viewModel.name)
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
                        
                        TextField("Enter email here", text: $viewModel.email)
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
                        
                        SecureField("Enter password here", text: $viewModel.password)
                            .autocapitalization(.none)
                            .foregroundColor(.colorOnAccent)
                            .padding()
                            .background(Color.formField)
                            .cornerRadius(3.0)
                    }
                    .padding()
                    
                    Spacer()
                    
                    LoadingView(errorMessage: $viewModel.errorMessage, isProcessing: $viewModel.isProcessing)
                    
                    Button(
                        action: viewModel.pressedSignup,
                        label: {
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
