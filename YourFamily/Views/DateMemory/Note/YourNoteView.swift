//
//  YourNoteView.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 9/6/22.
//

import PopupView
import SwiftUI
import SwiftUICharts
import Foundation
import SwiftUICommon

struct YourNoteView: View {
    @ObservedObject var viewModel = YourNoteViewModel()
    @EnvironmentObject var profileViewModel: ProfileViewModel

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack(spacing: 16) {
                HStack {
                    Text("Good Morning \(profileViewModel.currentProfile.nickname)!")
                        .font(.system(.subheadline))
                        .fontWeight(.bold)
                    Spacer()
                    Button {
                    } label: {
                        Image(systemName: "arrow.down.backward.square")
                    }
                }
                HStack {
                    makeChartView()
                    makeChartView(false)
                }
                .padding()
                .background(
                    Color.c595085
                        .opacity(0.5)
                        .cornerRadius(20)
                )

                HStack {
                    Text("Chi tieu trong tuan")
                        .font(.system(.callout))
                        .fontWeight(.semibold)
                    Spacer()
                    Button {
                    } label: {
                        Text("See All")
                    }
                }
                ScrollView(showsIndicators: false) {
                    VStack {
                        ForEach(viewModel.dataInput, id: \.dayInWeek) { item in
                            makeCellTransition(item)
                            Divider()
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .overlay(alignment: .bottomTrailing) {
            FloatingMenuView(
                firstAction: {
                    self.viewModel.isShowActionSheet = true
                },
                secondAction: {
                    self.viewModel.isShowActionSheet = true
                },
                thirdAction: {
                    self.viewModel.isShowActionSheet = true
                }
            )
            .padding()
        }
        .sheet(isPresented: $viewModel.isShowActionSheet) {
            BudgeMenuView()
                .environmentObject(self.viewModel)
        }
        .padding(.top, 16)
    }

    func makeCellTransition(_ item: CashInModel) -> some View {
        HStack(spacing: 20) {
            Image(systemName: item.isCashIn ? "arrow.up" : "arrow.down")
                .foregroundColor(item.isCashIn ? .blue : .red)
                .frame(width: 60, height: 60)
                .background(
                    Color("PurpleF1")
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                )
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                Text(item.dayInWeek.toFullDayString)
                    .font(.system(.callout))
                    .foregroundColor(Color.c595085)
            }
            Spacer()
            Text(String(format: "$%.2f", item.cost))
                .font(.system(size: 14))
                .fontWeight(.semibold)
        }
        .frame(maxWidth: .infinity)
    }

    func makeChartView(_ isInput: Bool = true) -> some View {
        ZStack {
            if isInput {
                LineChartView(
                    data: viewModel.dataInput.filter {
                        $0.isCashIn
                    }.map({ cash in
                        cash.cost
                    }
                         ), title: "Cash In", style: Styles.barChartStyleOrangeLight,
                    form: ChartForm.small
                )
            } else {
                LineChartView(
                    data: viewModel.dataInput
                        .filter {
                            !$0.isCashIn
                        }.map({ cash in
                            cash.cost
                        }), title: "Cash Out", style: Styles.barChartMidnightGreenLight,
                    form: ChartForm.small
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
