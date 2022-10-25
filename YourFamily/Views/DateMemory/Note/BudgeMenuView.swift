//
//  BudgeMenuView.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 10/19/22.
//

import SwiftUI

struct BudgeMenuView: View {
    @StateObject var viewModel = BudgeMenuViewModel()
    @EnvironmentObject private var noteViewModel: YourNoteViewModel

    var body: some View {
        ZStack {
            Color.gray.opacity(0.2).ignoresSafeArea()
            VStack(spacing: 12) {
                Text("My Cash")
                    .font(.system(.title))
                    .fontWeight(.bold)
                    .foregroundColor(Color.c745CF1.opacity(0.7))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.c745CF1.opacity(0.2).clipShape(Capsule()))
                HStack {
                    ForEach(viewModel.menuBudget, id: \.self) { item in
                        makeIconBought(item.imageName)
                            .onTapGesture {
                                viewModel.billTitle = item.titleName
                            }
                    }
                }
                HStack {
                    ForEach(viewModel.bugdetDefine, id: \.self) { item in
                        Button {
                            viewModel.setBillCost(item)
                        } label: {
                            makeMoneyCard(Int(item))
                        }
                    }
                }

                VStack {
                    HStack {
                        Text("Amount:")
                        Spacer()
                        TextField(
                            "Your cost", value: $viewModel.billAmout, formatter: NumberFormatter()
                        )
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                        .fixedSize()

                    }
                    HStack {
                        Text("Bill date:")
                        Spacer()
                        DatePicker(
                            "Bill date", selection: $viewModel.billDate, displayedComponents: .date
                        )
                        .labelsHidden()
                        .pickerStyle(.menu)
                    }
                    HStack {
                        Text("Cost For:")
                        Spacer()
                        TextField("Your cost for", text: $viewModel.billTitle)
                            .multilineTextAlignment(.trailing)
                            .fixedSize()

                    }
                    HStack {
                        Text("Is Cash In:")
                        Spacer()
                        Toggle(
                            isOn: $viewModel.billCashIn,
                            label: {
                            }
                        )
                        .multilineTextAlignment(.trailing)
                        .fixedSize()
                    }
                    Button {
                        noteViewModel.updateListNote(
                            item: CashInModel(
                                id: UUID().uuidString,
                                cost: viewModel.billAmout,
                                isCashIn: viewModel.billCashIn,
                                title: viewModel.billTitle,
                                dayInWeek: viewModel.billDate)
                        )
                    } label: {
                        Text("Save Bill")
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(14)
                            .background(Color.c745CF1.opacity(0.7).cornerRadius(14))
                    }

                }
                .padding()
                .background(
                    Color.c745CF1
                        .opacity(0.1)
                        .cornerRadius(14)
                        .shadow(color: Color.c949494, radius: 2, x: 0, y: 2))
            }
            .padding()
            .background(
                Color.white.cornerRadius(20)
                    .shadow(color: .gray, radius: 2, x: 0, y: 2)
            )
            .padding(.horizontal, 12)
            .frame(maxWidth: .infinity)
        }
    }

    func makeIconBought(_ imageName: String) -> some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .frame(width: 20, height: 20)
            .padding()
            .background {
                Color.orange
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
    }

    func makeMoneyCard(_ value: Int) -> some View {
        return Text("\(value)")
            .padding(.horizontal, 16)
            .padding(.vertical, 4)
            .background(Color.c949494.opacity(0.2).clipShape(RoundedRectangle(cornerRadius: 20)))
    }
}

struct BudgeMenuView_Previews: PreviewProvider {
    static var previews: some View {
        BudgeMenuView()
    }
}
