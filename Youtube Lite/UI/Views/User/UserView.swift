//
//  UserView.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 18.07.2021.
//

import SwiftUI

struct UserView: View {
    @ObservedObject var user = User.currentUser
    
    @Binding var isPresented: Bool
    
    @Binding var showAuthentication: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundBottom
                    .edgesIgnoringSafeArea(.vertical)
                
                VStack {
                    
                    Circle()
                        .foregroundColor(.colorOnAccent.opacity(0.4))
                        .frame(width: 200, height: 200, alignment: .center)
                    
                    if user.isAuthenticated {
                        Text(user.userData[UserDataKeys.name.rawValue] ?? "N/A")
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Label(
                            title: { Button(action: { }, label: {
                                Text("Settings")
                            }) },
                            icon: { Image(systemName: "gearshape") }
                        )
                        Label(
                            title: {
                                Button(action: { }, label: {
                                    Text("My Analytics")
                                })
                                .disabled(!user.isAuthenticated)
                            },
                            icon: { Image(systemName: "arrow.up.right") }
                        )
                        
                        Spacer()
                        
                        if !user.isAuthenticated {
                            Label(
                                title: {
                                    Button(
                                        action: { showAuthentication = true },
                                        label: { Text("Authenticate") }
                                    )
                                },
                                icon: { Image(systemName: "person.badge.plus") }
                            )
                        } else {
                            Label(
                                title: {
                                    Button(
                                        action: { FirebaseHelper.shared.authenticator.signOut() },
                                        label: { Text("Log out") }
                                    )
                                },
                                icon: { Image(systemName: "person.fill.xmark") }
                            )
                        }
                    }
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .navigationTitle("User")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(
                    trailing:
                        Button(
                            action: {
                                withAnimation { isPresented = false }
                            }, label: {
                                Text("Close")
                            }
                        )
                )
                .padding()
            }
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(isPresented: .constant(true), showAuthentication: .constant(false))
    }
}
