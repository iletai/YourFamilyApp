//
//  MemoryCardView.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 9/16/22.
//

import SwiftUI

struct MemoryCardView: View {
    @State private var selectedPage = 0

    var body: some View {
        ZStack(alignment: .leading) {
            Image("Ngomon2")
                .resizable()
                .scaledToFit()
                .overlay(VStack(alignment: .leading, spacing: 0) {
                    Spacer()
                    HStack {
                        Text("Hue - Viet Nam")
                            .font(.system(size: 24))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        .frame(alignment: .leading)
                        Spacer()
                    }
                    .padding(.leading, 16)
                    .padding(.bottom, 16)
                })
        }
        .cornerRadius(20)
        .padding()
    }
}

struct MemoryCardView_Previews: PreviewProvider {
    static var previews: some View {
        MemoryCardView()
    }
}
