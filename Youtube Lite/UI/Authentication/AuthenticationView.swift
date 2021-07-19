//
//  AuthenticationView.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 18.07.2021.
//

import SwiftUI

struct AuthenticationView: View {
    @Binding var isPresented: Bool
    
    @State var showLogin = false
    @State var showSignup = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Assets.Gradients.background
                    .edgesIgnoringSafeArea(.vertical)
                
                VStack {
                    HStack(alignment: .lastTextBaseline) {
                        Spacer()
                        Button(
                            action: { isPresented = false }, label: {
                                Text("Cancel")
                            }
                        )
                    }
                    
                    Spacer()
                    
                    Assets.Images.logo
                    
                    Text("Create, discover & consume engaging content that makes work a breeze!")
                        .font(.italic(.title)())
                        .foregroundColor(Assets.Colors.colorOnPrimary)
                        .multilineTextAlignment(.center)
                    
                    Text("Youtube puts the power of the world’s leading AI-powered content engagement platform in the palm of your hands!")
                        .font(.subheadline)
                        .foregroundColor(Assets.Colors.subHeadline)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    NavigationLink(
                        destination: LoginView().navigationTitle("Login"),
                        label: {
                            Text("Login").largeButton()
                        }
                    )
                    
                    NavigationLink(
                        destination: SignupView().navigationTitle("Sign Up"),
                        label: {
                            Text("Sign Up").largeButton()
                        }
                    )
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .navigationBarHidden(true)
            }
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView(isPresented: .constant(true))
    }
}
