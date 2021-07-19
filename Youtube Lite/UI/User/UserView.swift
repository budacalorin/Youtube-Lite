//
//  UserView.swift
//  Youtube Lite
//
//  Created by Lorin Budaca on 18.07.2021.
//

import SwiftUI

struct UserView: View {
    @EnvironmentObject var user: User
    
    @Binding var isPresented: Bool
    
    @Binding var showAuthentication: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                Assets.Colors.backgroundBottom
                    .edgesIgnoringSafeArea(.vertical)
                
                VStack {
                    if (!user.isAuthenticated) {
                        Circle()
                            .foregroundColor(Assets.Colors.colorOnAccent.opacity(0.4))
                            .frame(width: 200, height: 200, alignment: .center)
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
                        
                        if (!user.isAuthenticated) {
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
                                        action: { user.isAuthenticated = false },
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
                .navigationBarItems(trailing: Button(action: { withAnimation { isPresented = false } }, label: {
                    Text("Close")
                }))
                .padding()
            }
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(isPresented: .constant(true), showAuthentication: .constant(false))
            .environmentObject(User())
    }
}
