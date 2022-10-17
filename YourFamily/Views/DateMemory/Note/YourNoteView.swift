//
//  YourNoteView.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 9/6/22.
//

import SwiftUI
import SwiftUICharts

struct YourNoteView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.gray.opacity(0.3)
                VStack(spacing: 16) {
                    HStack {
                        Text("Good Morning, TaiLe")
                        Spacer()
                        Button {
                        } label: {
                            Image(systemName: "arrow.down.backward.square")
                        }

                    }
                    ZStack {
                        LineView(data: [8,23,54,32,12,37,7,23,43], title: "Line chart", legend: "Full screen")
                            .padding()
                    }
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
        }
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
}

struct YourNoteView_Previews: PreviewProvider {
    static var previews: some View {
        YourNoteView()
    }
}
