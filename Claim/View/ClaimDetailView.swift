//
//  ClaimDetailView.swift
//  Claim
//
//  Created by Danu  on 16/7/25.
//

import SwiftUI

struct ClaimDetailView: View {
    let claim: Claim

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(claim.title)
                    .font(.title2)
                    .bold()

                Text(claim.body)
                    .font(.body)

                Divider()

                Text("Claim ID: \(claim.id)")
                Text("User ID: \(claim.userId)")
            }
            .padding()
        }
        .navigationTitle("Detail Klaim")
    }
}
