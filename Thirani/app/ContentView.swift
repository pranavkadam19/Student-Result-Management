//
//  ContentView.swift
//  Thirani
//
//  Created by indianrenters on 14/06/25.
//

import SwiftUI

struct ContentView: View {
    @State var redirectToSignIn: Bool = false
    @State var showMainView: Bool = false
    var body: some View {
        NavigationStack(){
            LaunchScreen(showMainView: $showMainView)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading){
                        HStack{
                            Spacer()
                            Image(systemName: "command.circle.fill")
                                .imageScale(.large)
                            
                            Text("Thirani")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .foregroundStyle(LinearGradient(colors: [.black ,.blue], startPoint: .top, endPoint: .bottom))
                    }
                    
                    if showMainView == true {
                        ToolbarItem(placement: .topBarTrailing){
                            NavigationLink(destination: SignInView()){
                                VStack {
                                    Button(action: {
                                        redirectToSignIn = true
                                    }){
                                        Text("Sign in")
                                            .padding(.vertical, 8)
                                            .padding(.horizontal)
                                            .fontWeight(.semibold)
                                            .foregroundStyle(.white)
                                            .background(Color.blue)
                                            .clipShape(Capsule())
                                            
                                    }
                                }
                            }
                        }
                    }
                }
                .background(
                    NavigationLink(destination: SignInView(), isActive: $redirectToSignIn){
                        EmptyView()
                    }
                        .hidden()
                )
        }
    }
}

#Preview {
    ContentView()
}
