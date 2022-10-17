//
//  OnThisDayCardView.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 10/12/22.
//

import SwiftUI

struct OnThisDayCardView: View {
    var viewModel: OnThisDayModel
    @State private var image: UIImage?

    init(viewModel: OnThisDayModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            VStack {
                Image(uiImage: self.image ?? UIImage())
                    .resizable()
                    .scaledToFill()
                    .frame(width: 400, height: 400)
                    .overlay(alignment: .bottomLeading, content: {
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Image(systemName: "timelapse")
                                Text(viewModel.title)
                                    .font(.system(size: 16))
                            }
                            .foregroundColor(.white)
                            Text(viewModel.time.toDayString)
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            HStack {
                                Image(systemName: "location.viewfinder")
                                Text(viewModel.location)
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                            }
                            .foregroundColor(.white)
                        }
                        .padding(16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.c595085)
                    })
                }
        }
        .onAppear {
            guard !viewModel.imageLink.isEmpty else {
                return
            }
            FileStorage.downloadImage(imageUrl: viewModel.imageLink) { image in
                self.image = image ?? UIImage()
            }
        }
    }
}

struct OnThisDayCardView_Previews: PreviewProvider {
    static var previews: some View {
        OnThisDayCardView(viewModel: OnThisDayModel.empty())
    }
}
