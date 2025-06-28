//
//  LoginView.swift
//  Thirani
//
//  Created by indianrenters on 14/06/25.
//

import SwiftUI

struct SignInView: View {
    @ObservedObject var vm: AuthManager = AuthManager.shared
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
                    Text("Login to your account")
                        .fontWeight(.bold)
                        .font(.title)
                    
                    Text("Please enter your details")
                        .font(.title3)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 20)
                }
                
                HStack(alignment: .center){
                    TextField("Enter email...", text: $email)
                    
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
                
                HStack(alignment: .center){
                    Toggle("Remember me", isOn: $vm.rememberMe)
                        .toggleStyle(.button)
                    
                    Spacer()
                    
                    Button(action: { }){
                        Text("Forgot Password?")
                            .foregroundColor(.blue)
                    }
                }
                
                Button(action: {
                    vm.login(email: email, password: password){ error in
                        if let error = error {
                            print("error while login: \(error)")
                        } else {
                            print("Login successful")
                        }
                    }
                    email = ""
                    password = ""
                }){
                    Text("Sign in")
                        .padding()
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                    
                }
                
                Button(action: {
                    vm.handleGoogleSignIn()
                }){
                    HStack(spacing: 0){
                        Image(systemName: "key")
                            .foregroundStyle(.gray)
                        
                        Text("Sign in with Google")
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
                
                if !vm.isAuthenticated && vm.errorMessage?.isEmpty == false {
                    Text(vm.errorMessage ?? "Error")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundStyle(.red)
                        .fontWeight(.semibold)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                HStack{
                    Spacer()
                    NavigationLink(destination: SignUpView()){
                        Text("Don't have an account?")
                            .foregroundStyle(.gray)
                        
                        Text("Sign up")
                            .foregroundStyle(.blue)
                    }
                    Spacer()
                }
                
                NavigationLink(destination: HomeScreenView(), isActive: $vm.isAuthenticated){
                    EmptyView()
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
    SignInView()
}
