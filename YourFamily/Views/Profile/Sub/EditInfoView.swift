//
//  EditInfoView.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 10/12/22.
//

import Foundation
import SwiftUI

struct EditInfoView: View {
    @Environment(\.presentationMode) var presentation
    @StateObject var viewModel: ProfileViewModel
    let onUpdateProfile: () -> Void

    init(viewModel: ProfileViewModel, onUpdateProfile: @escaping () -> Void) {
        _viewModel = .init(wrappedValue: viewModel)
        self.onUpdateProfile = onUpdateProfile
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color.cF18A5C.opacity(0.2)
                    .ignoresSafeArea()
                VStack {
                    TextField(viewModel.currentProfile.nickname, text: $viewModel.updateNickname)
                        .overlay(content: {
                            VStack {
                                Spacer()
                                Divider()
                            }
                        })
                        .padding()
                        .background(
                            Color.c949494
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .opacity(0.2)
                                .frame(height: 80)
                        )
                        .shadow(color: .red, radius: 2, x: 0, y: 2)
                    Spacer()
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Update Profile")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .bold()
                            .foregroundColor(.c595085)
                    }
                }
            }
            .navigationBarItems(leading: Button(action: {
                presentation.wrappedValue.dismiss()
            }, label: {
                Text("Cancel")
            }), trailing: Button(action: {
                onUpdateProfile()
                presentation.wrappedValue.dismiss()
            }, label: {
                Text("Update")
            }))
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct EditInfoView_Previews: PreviewProvider {
    static var previews: some View {
        EditInfoView(viewModel: ProfileViewModel()) {
        }
    }
}
