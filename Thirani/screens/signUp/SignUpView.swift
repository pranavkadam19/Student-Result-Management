//
//  SignUpView.swift
//  Thirani
//
//  Created by indianrenters on 14/06/25.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var vm: AuthManager = AuthManager.shared
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    var body: some View {
        VStack(alignment: .leading, spacing: 64){
            
            HStack{
                Spacer()
                Image(systemName: "command.circle.fill")
                    .imageScale(.large)
                
                Text("Thirani School")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            .foregroundStyle(LinearGradient(colors: [.black ,.blue], startPoint: .top, endPoint: .bottom))
            
            VStack(alignment: .leading, spacing: 18){
                VStack(alignment: .leading, spacing: 8){
                    Text("Create a new account")
                        .fontWeight(.bold)
                        .font(.title)
                    
                    Text("Please enter your details")
                        .font(.title3)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 20)
                }
                
                HStack(alignment: .center){
                    TextField("Enter Username...", text: $username)
                    Spacer()
                    Image(systemName: "person.fill")
                        .foregroundColor(.gray)
                }
                .padding()
                .background{
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(lineWidth: 1)
                        .foregroundStyle(.gray.opacity(0.5))
                }
                
                HStack(alignment: .center){
                    TextField("Enter Email...", text: $email)
                    Spacer()
                    Image(systemName: "envelope")
                        .foregroundColor(.gray)
                }
                .padding()
                .background{
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(lineWidth: 1)
                        .foregroundStyle(.gray.opacity(0.5))
                }
                
                HStack(alignment: .center){
                    SecureField("Enter Password...", text: $password)
                    Spacer()
                    Image(systemName: "eye.fill")
                        .foregroundColor(.gray)
                }
                .padding()
                .background{
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(lineWidth: 1)
                        .foregroundStyle(.gray.opacity(0.5))
                    
                }
                
                Button(action: {
                    vm.signUp(username: username, email: email, password: password){ error in
                        if let error = error {
                            print("error while login: \(error)")
                        } else {
                            print("Login successful")
                        }
                    }
                }){
                    NavigationLink(destination: SignInView()){
                        Text("Sign Up")
                            .padding()
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                    }
                }
                
                Button(action: { }){
                    HStack(spacing: 0){
                        Image(systemName: "key")
                            .foregroundStyle(.gray)
                        
                        Text("Sign up with Google")
                            .padding()
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                        
                    }
                    .frame(maxWidth: .infinity)
                    .background{
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(lineWidth: 1)
                            .foregroundStyle(.gray.opacity(0.5))
                    }
                }
                
                HStack{
                    Spacer()
                    NavigationLink(destination: SignInView()) {
                        Text("Already have an account?")
                            .foregroundStyle(.gray)
                        
                        Text("Sign In")
                            .foregroundStyle(.blue)
                    }
                    Spacer()
                }
                Spacer()
            }
        }
        .padding()
        .background(Color.white)
        //.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SignUpView()
}
