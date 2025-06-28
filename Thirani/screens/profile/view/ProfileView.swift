//
//  Profile.swift
//  Thirani
//
//  Created by indianrenters on 15/06/25.
//
import SwiftUI

struct ProfileView: View {
    @State private var fullName: String?
    @State private var email: String?
    @State private var photoURL: String? // Add this state variable
    
    @State private var subject = "Mathematics"
    @State private var school = "Thirani High School"
    @ObservedObject var vm = AuthManager.shared
    
    var onLogout: () -> Void
    
    var body: some View {
        NavigationView {
            VStack(spacing: 32) {
                // Profile Picture
                Group {
                    // Check both vm.photoURL and local photoURL state
                    if let photoURLString = vm.photoURL ?? photoURL,
                       !photoURLString.isEmpty,
                       let url = URL(string: photoURLString) {
                        
                        // Using AsyncImage with better error handling
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 140, height: 140)
                                .clipShape(Circle())
                                .overlay(
                                    Circle().stroke(Color.gray.opacity(0.3), lineWidth: 2)
                                )
                        } placeholder: {
                            // Show loading indicator while image loads
                            ZStack {
                                Circle()
                                    .fill(Color.gray.opacity(0.1))
                                    .frame(width: 140, height: 140)
                                ProgressView()
                                    .scaleEffect(1.2)
                            }
                            .overlay(
                                Circle().stroke(Color.gray.opacity(0.3), lineWidth: 2)
                            )
                        }
                        .padding(.top, 40)
                        
                    } else {
                        // Default placeholder when no photo URL
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 140, height: 140)
                            .foregroundColor(.blue.opacity(0.7))
                            .overlay(
                                Circle().stroke(Color.gray.opacity(0.3), lineWidth: 2)
                            )
                            .padding(.top, 40)
                    }
                }
                
                // Teacher details
                Group {
                    InfoRow(icon: "person.fill", label: "Name", value: fullName ?? "Guest")
                    InfoRow(icon: "envelope.fill", label: "Email", value: email ?? "email")
                    InfoRow(icon: "building.columns.fill", label: "School", value: school)
                }
                .padding(.horizontal)
                
                Divider()
                    .padding(.horizontal)
                
                // Optional Certifications section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Certifications")
                        .font(.headline)
                    HStack(spacing: 16) {
                        Label("Google Educator", systemImage: "rosette")
                        Label("STEM Specialist", systemImage: "hammer.fill")
                        Label("SEL Training", systemImage: "heart.text.square.fill")
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
                .padding(.horizontal)
                
                Spacer()
                
                // Debug section (remove this after fixing)
                VStack(alignment: .leading, spacing: 4) {
                    Text("Debug Info:")
                        .font(.caption)
                        .foregroundColor(.red)
                    Text("vm.photoURL: \(vm.photoURL ?? "nil")")
                        .font(.caption2)
                        .foregroundColor(.gray)
                    Text("local photoURL: \(photoURL ?? "nil")")
                        .font(.caption2)
                        .foregroundColor(.gray)
                    Text("UserDefaults photoURL: \(UserDefaults.standard.string(forKey: "photoURL") ?? "nil")")
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                
                // Logout button
                Button(action: {
                    vm.logout()
                }) {
                    Text("Log Out")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                Spacer(minLength: 40)
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                loadUserData()
            }
        }
    }
    
    private func loadUserData() {
        fullName = UserDefaults.standard.string(forKey: "username")
        email = UserDefaults.standard.string(forKey: "email")
        photoURL = UserDefaults.standard.string(forKey: "photoURL")
        
        // Debug prints
        print("Loading user data:")
        print("fullName: \(fullName ?? "nil")")
        print("email: \(email ?? "nil")")
        print("photoURL from UserDefaults: \(photoURL ?? "nil")")
        print("vm.photoURL: \(vm.photoURL ?? "nil")")
    }
}

struct InfoRow: View {
    let icon: String
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .frame(width: 24)
                .foregroundColor(.blue)
            VStack(alignment: .leading, spacing: 2) {
                Text(label.uppercased())
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(value)
                    .font(.body)
                    .bold()
            }
            Spacer()
        }
    }
}
