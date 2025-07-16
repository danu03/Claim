//
//  ClaimListView.swift
//  Claim
//
//  Created by Danu  on 16/7/25.
//

import SwiftUI

struct ClaimListView: View {
    @StateObject private var viewModel = ClaimListViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .padding()
                } else {
                    List(viewModel.filteredClaims) { claim in
                        NavigationLink(
                            destination: ClaimDetailView(claim: claim)
                        ) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(claim.title)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .lineLimit(1)
                                    .padding(.bottom, 4)
                                Text(claim.body)
                                    .lineLimit(2)
                                    .foregroundColor(.gray)
                                    .padding(.bottom, 4)
                                Text(
                                    "Claim ID: \(claim.id) | User ID: \(claim.userId)"
                                )
                                .font(.caption)
                                .foregroundColor(.secondary)
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Daftar Klaim")
            .searchable(text: $viewModel.searchText, prompt: "Cari klaim...")
            .alert(isPresented: $viewModel.showError) {
                Alert(title: Text("Error"),
                      message: Text(viewModel.errorMessage),
                      dismissButton: .default(Text("OK")))
            }
            .task {
                await viewModel.fetchClaims()
            }
        }
    }
}

#Preview {
    ClaimListView()
}
