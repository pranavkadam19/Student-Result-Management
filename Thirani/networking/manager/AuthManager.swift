//
//  AuthManager.swift
//  Thirani
//
//  Created by indianrenters on 16/06/25.
//
import FirebaseAuth
import Foundation
import Firebase
import GoogleSignIn
import GoogleSignInSwift

class AuthManager: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var rememberMe: Bool = false
    @Published var errorMessage: String?
    @Published var photoURL: String?
    
    static var shared = AuthManager()
    
    init(){}
    
    func signUp(username: String?, email: String?, password: String?, completion: @escaping (Error?) -> Void){
        
        guard let username = username else {
            print("Please enter username")
            errorMessage = "Please enter username"
            return
        }
        
        guard let email = email else {
            print("Please enter email")
            errorMessage = "Please enter email"
            return
        }
        
        guard let password = password else {
            print("Please enter password")
            errorMessage = "Please enter password"
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(error)
                self.errorMessage = String(describing: error.localizedDescription)
                return
            }
            self.isAuthenticated = true
            self.errorMessage = nil
            print("user: \(result?.user ?? nil)")
            print("accessToken: \(result?.credential?.accessToken ?? "no token")")
        }
    }
    
    func logout(){
        isAuthenticated = false
        try? Auth.auth().signOut()
        UserDefaults.standard.removeObject(forKey: "username")
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "photoURL")
    }
    
    func login(email: String?, password: String?, completion: @escaping (Error?) -> Void){
        guard let email = email else {
            print("Please enter email")
            errorMessage = "Please enter email"
            return
        }
        
        guard let password = password else {
            print("Please enter password")
            errorMessage = "Please enter password"
            return
        }
        Auth.auth().signIn(withEmail: email, password: password){ result, error in
            if let error = error{
                completion(error)
                self.errorMessage = String(describing: error)
                return
            }
            
            self.isAuthenticated = true
        }
    }
    
    func handleGoogleSignIn() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        guard let rootVC = UIApplication.shared.connectedScenes
            .compactMap({ ($0 as? UIWindowScene)?.windows.first?.rootViewController })
            .first else {
            self.errorMessage = "No root view controller"
            return
        }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootVC) { result, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                return
            }
            
            guard
                let idToken = result?.user.idToken?.tokenString,
                let accessToken = result?.user.accessToken.tokenString
            else {
                self.errorMessage = "Google Sign-In failed to get tokens"
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
            Auth.auth().signIn(with: credential) { result, error in
                if let error = error {
                    self.errorMessage = error.localizedDescription
                } else if let result = result {
                    UserDefaults.standard.set(result.user.email, forKey: "email")
                    UserDefaults.standard.set(result.user.displayName, forKey: "username")
                    
                    guard let photoURL = result.user.photoURL?.absoluteString else { return }
                    UserDefaults.standard.set(photoURL, forKey: "photoURL")
                    self.photoURL = photoURL
                    print("photoURL: ", photoURL)
                    self.isAuthenticated = true
                    self.errorMessage = ""
                } else {
                    //
                }
            }
        }
    }
}
