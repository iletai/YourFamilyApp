//
//  YourNoteView.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 9/6/22.
//

import SwiftUI
import SwiftUICharts
import PopupView

struct YourNoteView: View {
    @StateObject var viewModel = YourNoteViewModel()
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @State private var isShowActionSheet = false

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack(spacing: 16) {
                HStack {
                    Text("Good Morning \(profileViewModel.currentProfile.nickname)")
                    Spacer()
                    Button {
                    } label: {
                        Image(systemName: "arrow.down.backward.square")
                    }
                }
                TabView {
                    makeChartView()
                    makeChartView(false)
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .frame(maxHeight: 400)

                HStack {
                    Text("Chi tieu trong tuan")
                    Spacer()
                    Button {
                    } label: {
                        Text("See All")
                    }
                }
                ScrollView {
                    VStack {
                        makeCellTransition(true)
                        makeCellTransition(false)
                        makeCellTransition(true)
                        makeCellTransition(false)
                        makeCellTransition(true)
                        makeCellTransition(false)
                        makeCellTransition(true)
                        makeCellTransition(false)
                        makeCellTransition(true)
                        makeCellTransition(false)
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .overlay(alignment: .bottomTrailing) {
            FloatingMenuView(firstAction: {
                self.isShowActionSheet = true
            }, secondAction: {
                self.isShowActionSheet = true
            }, thirdAction: {
                self.isShowActionSheet = true
            })
                .padding()
        }
        .popup(isPresented: $isShowActionSheet,
               type: .toast,
               position: .bottom,
               closeOnTap: false,
               backgroundColor: .black.opacity(0.4)) {
            ActionSheetCustom {
                Color.gray
                    .frame(height: 500)
            }
        }
        .environmentObject(profileViewModel)
    }

    func makeCellTransition(_ isPlus: Bool) -> some View {
        HStack(spacing: 20) {
            Image(systemName: isPlus ? "arrow.up" : "arrow.down")
                .frame(width: 60, height: 60)
                .overlay(content: {
                    Color.c595085.opacity(0.3)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                })
            VStack(alignment: .leading) {
                Text("Buy a shoes")
                Text(Date().toFullDayString)
            }
            Spacer()
            Text("$100")
            Button {
            } label: {
                Image(systemName: "greaterthan")
            }

        }
        .frame(maxWidth: .infinity)
    }

    func makeChartView(_ isInput: Bool = true) -> some View {
        ZStack {
            if isInput {
                LineChartView(
                    data: viewModel.dataInput.map({ cash in
                        cash.cost
                    }), title: "Cash In", style: Styles.barChartMidnightGreenDark, form: ChartForm.large
                )
            } else {
                LineChartView(
                    data: viewModel.dataOutput.map({ cash in
                        cash.cost
                    }), title: "Cash Out", style: Styles.barChartMidnightGreenLight, form: ChartForm.large
                )
            }
        }
    }
}

struct YourNoteView_Previews: PreviewProvider {
    static var previews: some View {
        YourNoteView()
            .environmentObject(ProfileViewModel())
    }
}
