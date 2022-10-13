//
//  OnThisDateView.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 10/13/22.
//

import SwiftUI

struct OnThisDateView: View {
    @Environment(\.redactionReasons) private var reasons
    @ObservedObject var memoryModel: LunarCalendarViewModel

    var body: some View {
        GeometryReader { geo in
            VStack {
                makeImageDetail(geo: geo.size)
                    .cornerRadius(14)
                Button {
                    withAnimation(.linear) {
                        memoryModel.saveTheDayToFirestore()
                    }
                } label: {
                    Text("Add Memory")
                        .foregroundColor(.white)
                        .font(.system(size: 12))
                        .fontWeight(.bold)
                        .padding()
                        .background(
                            Color.c5CCBF1.clipShape(RoundedCorner(radius: 20))
                        )
                        .shadow(color: .gray, radius: 16, x: 0, y: 2)
                }
            }
            .sheet(isPresented: $memoryModel.isShowPickerImage) {
                ImagePicker()
                    .environmentObject(self.memoryModel.userData)
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
        }
    }

    func makeImageDetail(geo: CGSize) -> some View {
        ZStack {
            Color.gray.scaledToFill()
            if memoryModel.userData.image != nil {
                Image(uiImage: memoryModel.userData.image ?? UIImage())
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.width, height: geo.height / 2)
                    .overlay(
                        alignment: .bottomTrailing,
                        content: {
                            memoryContent()
                        }
                    )
                    .overlay(alignment: .topTrailing) {
                        buttonAddImage()
                    }
            } else {
                VStack {
                    Image(systemName: "photo")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: geo.width, height: geo.height / 2)
                        .overlay(
                            alignment: .bottomTrailing,
                            content: {
                                memoryContent()
                            }
                        )
                        .overlay(alignment: .topTrailing) {
                            buttonAddImage()
                        }
                }
            }
        }
        .frame(width: geo.width, height: geo.height / 2)
    }

    func memoryContent() -> some View {
        VStack {
            TextField(text: $memoryModel.titleMemory) {
                Text("Where do you go?")
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)

            }
            HStack {
                Text("On time:")
                    .foregroundColor(.white)
                    .font(.system(size: 15))
                    .fontWeight(.bold)
                DatePicker(
                    "Travel On Time", selection: $memoryModel.travelOnTime,
                    displayedComponents: [.date]
                )
                .labelsHidden()
                .datePickerStyle(.compact)
                .colorMultiply(.white)
                .environment(\.colorScheme, .dark)
                Spacer()
                HStack {
                    Image(systemName: "plus.viewfinder")
                    TextField(text: $memoryModel.location) {
                        Text("Location?")
                            .foregroundColor(.white)
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                    }
                }
                .frame(alignment: .trailing)
                .fixedSize(horizontal: true, vertical: false)
            }
        }
        .foregroundColor(.white)
        .padding(8)
        .background(Color.c5CCBF1)
    }

    func buttonAddImage() -> some View {
        ZStack {
            Button {
                withAnimation(.linear) {
                    memoryModel.isShowPickerImage.toggle()
                }
            } label: {
                HStack(spacing: 2) {
                    Group {
                        Text(memoryModel.userData.image != nil ? "Change Image" : "Add Image")
                            .font(.system(size: 10))
                            .fontWeight(.bold)
                        Image(systemName: "plus.viewfinder")
                    }
                    .foregroundColor(.white)
                }
                .padding(8)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color("DarkGreen"), Color("LightGreen")]),
                        startPoint: .leading, endPoint: .trailing
                    )
                    .cornerRadius(16)
                    .shadow(color: .white, radius: 2, x: 0, y: 2)
                )
                .padding(16)
            }
        }
    }
}

struct OnThisDateView_Previews: PreviewProvider {
    static var previews: some View {
        OnThisDateView(memoryModel: LunarCalendarViewModel())
    }
}
