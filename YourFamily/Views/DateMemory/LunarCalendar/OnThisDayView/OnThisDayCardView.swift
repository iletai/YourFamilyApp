//
//  OnThisDayCardView.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 10/12/22.
//

import SwiftUI

struct OnThisDayCardView: View {
    var body: some View {
        ZStack {
            VStack {
                Image("dummyAvatar")
                    .resizable()
                    .scaledToFit()
                    .frame(width: .infinity, height: 400)
                    .overlay(alignment: .topTrailing, content: {
                        Image(systemName: "arrow.up.heart.fill")
                            .foregroundColor(.pink)
                            .padding(.trailing, 8)
                    })
                    .overlay(alignment: .bottomLeading, content: {
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Image(systemName: "timelapse")
                                Text("100 Days Ago")
                                    .font(.system(size: 12))
                            }
                            Text(Date().toDateAndMonthString)
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                            HStack {
                                Image(systemName: "location.viewfinder")
                                Text("Hoi An, Viet Nam")
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                            }
                            .foregroundColor(.gray)
                        }
                        .padding(8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.white)
                    })
                    .cornerRadius(16)
                }
            .shadow(color: .gray, radius: 4, x: 0, y: 2)
        }
    }
}

struct OnThisDayCardView_Previews: PreviewProvider {
    static var previews: some View {
        OnThisDayCardView()
    }
}
