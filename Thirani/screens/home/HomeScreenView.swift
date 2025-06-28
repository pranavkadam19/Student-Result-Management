//
//  HomeScreenView.swift
//  Thirani
//
//  Created by indianrenters on 15/06/25.
//

import SwiftUI

struct HomeScreenView: View {
    @State var selection: Int = 0
    @ObservedObject var vm = AuthManager.shared
    
    var body: some View {
        TabView(selection: $selection){
            Tab("Student Entry", systemImage: "list.bullet.clipboard", value: 0){
                StudentEntryView()
            }
            
            Tab("Student Report", systemImage: "scroll", value: 1){
                StudentReportView()
            }
            
            Tab("Profile", systemImage: "person.fill", value: 2){
                ProfileView(){
                    print("Logged out.")
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .fullScreenCover(isPresented: .constant(!vm.isAuthenticated)){
            SignInView()
        }
    }
}

#Preview {
    HomeScreenView()
}
