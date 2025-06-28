//
//  LaunchScreenView.swift
//  Thirani
//
//  Created by indianrenters on 14/06/25.
//
import SwiftUI

struct LaunchScreen: View {
    @State private var logoScale: CGFloat = 0.6
    @State private var logoOpacity: Double = 0.0
    @Binding var showMainView: Bool
    
    var body: some View {
        Group {
            if showMainView {
                SchoolDetailView()
            } else {
                VStack(spacing: 16) {
                    Image(systemName: "lightbulb.max.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.yellow)
                        .frame(width: 200, height: 200)
                        .scaleEffect(logoScale)
                        .opacity(logoOpacity)
                    
                    Text("Welcome to Thirani School")
                        .padding()
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .opacity(logoOpacity)
                }
                .onAppear {
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.6)) {
                        logoScale = 1.0
                        logoOpacity = 1.0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation(.easeOut(duration: 0.8)) {
                            showMainView = true
                        }
                    }
                }
            }
        }
    }
}

//struct MainView: View {
//    var body: some View {
//        VStack(){
//            Text("Detail for item")
//                .font(.title)
//        }
//        
//    }
//}

// Preview
struct LaunchScreen_Previews: PreviewProvider {
    @State static var showMainView: Bool = false
    static var previews: some View {
        LaunchScreen(showMainView: $showMainView)
    }
}

struct SchoolDetailView: View {
    var school: School = .sample

    var body: some View {
        VStack(spacing: 16) {
            // Title & Location
            VStack(alignment: .leading, spacing: 4) {
                Text(school.location)
                    .font(.subheadline).foregroundColor(.secondary)
            }.padding(.horizontal)

            // Key Stats: horizontal cards
            HStack(spacing: 12) {
                MiniCard(icon: "person.3", value: "\(school.studentCount)")
                MiniCard(icon: "book.closed", value: "\(school.courseCount)")
                MiniCard(icon: "calendar", value: school.establishedYear)
            }
            .padding(.horizontal)

            // About with toggle
            VStack(alignment: .leading, spacing: 8) {
                Text("About")
                    .font(.headline)
                Text(school.description)
                    .font(.body)
            }
            .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Details")
                    .font(.headline)
                Text(school.description)
                    .font(.body)
            }
            .padding(.horizontal)
            
            Image(systemName: "books.vertical.fill")
                .resizable()
                .scaledToFit()
                .frame(height: 180)
                .clipped()
                .overlay(Color.white.opacity(0.2))
        }
    }
}

struct MiniCard: View {
    let icon: String
    let value: String

    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .foregroundColor(.blue)
            Text(value).bold()
        }
        .frame(width: 70, height: 70)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(8)
    }
}

// Sample data model (similar to before)
struct School {
    let name, location, establishedYear, description: String
    let studentCount, teacherCount, courseCount: Int
    let details: String
    
    static let sample = School(
        name: "Thirani School",
        location: "Thane, India",
        //bannerImage: "schoolBanner",
        establishedYear: "1998",
        description: "Thirani School is a semi-English school in Thane that offers quality education, celebrates cultural events, and provides well-equipped facilities like sports areas and computer labs.",
        studentCount: 1200,
        teacherCount: 75,
        courseCount: 45,
        details: "Thirani School has dedicated, experienced teachers who ensure every child receives individual attention. The school features clean, safe classrooms, well-equipped science labs, computer facilities, a library, and sports grounds."
    )
}
