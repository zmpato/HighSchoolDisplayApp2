//
//  MainView.swift
//  HighSchoolDisplayApp
//
//  Created by Zak Mills on 1/25/24.
//

import SwiftUI

struct MainView: View {
    let col: Color = Color(red: 235/255, green: 235/255, blue: 235/255)
    let col2: Color = Color(red: 40/255, green: 40/255, blue: 60/255)
    let col3: Color = Color(red: 48/255, green: 50/255, blue: 63/255)
    
    @StateObject private var viewModel = MainViewModel(networkService: NetworkService())
    var body: some View {
        NavigationStack {
            switch viewModel.state {
            case .success(let data):
                List {
                    ForEach(data, id: \.dbn) { school in
                        NavigationLink(value: school) {
                            VStack(alignment: .leading, spacing: 10) {
                                Text(school.school_name)
                                    .font(.title2)
                                    .foregroundStyle(col)
                                Text(school.city)
                                    .font(.caption)
                                    .foregroundStyle(.cyan)
                                
                            }
                        }
                        .listRowInsets(.init(top: 30, leading: 30, bottom: 30, trailing: 30))
                        .listRowSeparatorTint(.gray)
                        
                    }
                    .listRowBackground(col3)
                }
                .scrollContentBackground(.hidden)
                .background(col3)
                
                
                .navigationTitle("Schools")
                
                .foregroundStyle(col)
                .toolbarBackground(col3)
                .navigationDestination(for: viewModel.model) { school in
                    ZStack {
                        col
                            .ignoresSafeArea(.all)
                        headerView
                            .offset(y: -350)
                        VStack(alignment: .leading) {
                            Text(school.school_name)
                                .multilineTextAlignment(.center)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .offset(y: -270)
                            HStack {
                                Image(systemName: "mappin.circle.fill")
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                    .padding([.leading], 20)
                                    .foregroundStyle(col)
                                Text(school.city)
                                    .multilineTextAlignment(.center)
                                    .font(.subheadline)
                            }
                            .offset(y: -200)
                        }
                        
                        ScrollView {
                            VStack(alignment: .leading, spacing: 30) {
                                Text("School Information:")
                                
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .offset(x:-55, y: -170)
                                    .foregroundStyle(col3)
                                HStack(alignment: .top) {
                                    Image(systemName: "phone.circle.fill")
                                        .resizable()
                                        .frame(width: 35, height: 35)
                                        .padding([.leading], 20)
                                        .foregroundStyle(col3)
                                    VStack(alignment: .leading) {
                                        Text("Contact:")
                                            .foregroundStyle(col3)
                                        Text(school.phone_number ?? "No Phone Number")
                                            .foregroundStyle(col3)
                                            .font(.caption)
                                        Text(school.school_email ?? "No Email")
                                            .foregroundStyle(col3)
                                            .font(.caption)
                                    }
                                }
                                HStack(alignment: .top) {
                                    Image(systemName: "sportscourt.circle.fill")
                                        .resizable()
                                        .frame(width: 35, height: 35)
                                        .padding([.leading], 20)
                                        .foregroundStyle(col3)
                                    VStack(alignment: .leading) {
                                        Text("Sports:")
                                            .foregroundStyle(col3)
                                        Text(school.school_sports ?? "No sport")
                                            .foregroundStyle(col3)
                                            .font(.caption)
                                    }
                                }
                                if (school.overview_paragraph != nil) {
                                    HStack(alignment: .top) {
                                        Image(systemName: "note.text")
                                            .resizable()
                                            .frame(width: 35, height: 35)
                                            .padding([.leading], 20)
                                            .foregroundStyle(col3)
                                        VStack(alignment: .leading) {
                                            Text("School Overview:")
                                                .foregroundStyle(col3)
                                            Text(school.overview_paragraph ?? "")
                                                .foregroundStyle(col3)
                                                .font(.caption)
                                        }
                                    }
                                }
                            }
                        }
                        .frame(height: 500)
                        .offset(y:150)
                    }
                }
            case .loading:
                ProgressView()
            default:
                EmptyView()
            }
        }
        .task {
            await viewModel.fetchViewData()
        }
        .tint(col)
    }
    
    var headerView: some View {
        Rectangle()
            .fill(col3)
            .frame(width: UIScreen.main.bounds.size.width, height: 500)
            .clipShape(.rect(cornerRadius: 5.0))
    }
}

#Preview {
    MainView()
}
