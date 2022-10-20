//
//  BudgeMenuView.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 10/19/22.
//

import SwiftUI

struct BudgeMenuView: View {
    @StateObject var viewModel = BudgeMenuViewModel()
    var body: some View {
        ZStack {
            Color.gray.opacity(0.2).ignoresSafeArea()
            VStack(spacing: 12) {
                Text("My Cash")
                    .font(.system(.largeTitle))
                    .fontWeight(.bold)
                    .foregroundColor(Color.c745CF1)
                HStack {
                    makeIconBought("heart")
                    makeIconBought("drink-tea")
                    makeIconBought("money")
                }
                HStack {
                    Button {
                    } label: {
                        makeMoneyCard(500)

                    }
                    Button {
                    } label: {
                        makeMoneyCard(200)

                    }
                    Button {
                    } label: {
                        makeMoneyCard(50)
                    }
                    Button {

                    } label: {
                        makeMoneyCard(100)
                    }
                }

                VStack {
                    HStack {
                        Text("Amount:")
                        Spacer()
                        TextField("Your cost", text: $viewModel.billAmout)
                            .keyboardType(.numberPad)
                            .fixedSize()

                    }
                    HStack {
                        Text("Bill date:")
                        Spacer()
                        TextField("MM / DD / YY", value: $viewModel.billDate, format: .dateTime)
                            .fixedSize()

                    }
                    HStack {
                        Text("Cost For:")
                        Spacer()
                        TextField("Your cost for", text: $viewModel.billTitle)
                            .fixedSize()

                    }
                    Button {
                    } label: {
                        Text("Save Bill")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(14)
                            .background(Color.blue.cornerRadius(14))
                    }

                }
                .padding()
                .background(Color.white
                    .cornerRadius(14)
                    .shadow(color: Color.c949494, radius: 2, x: 0, y: 2))
            }
            .padding()
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
