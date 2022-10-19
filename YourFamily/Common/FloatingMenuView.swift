//
//  FloatingMenuView.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 10/19/22.
//

import SwiftUI

struct FloatingMenuView: View {
    @State private var showMenuItem1 = false
    @State private var showMenuItem2 = false
    @State private var showMenuItem3 = false
    let firstAction: () -> Void
    let secondAction: () -> Void
    let thirdAction: () -> Void

    init(
        firstAction: @escaping () -> Void, secondAction: @escaping () -> Void,
        thirdAction: @escaping () -> Void
    ) {
        self.firstAction = firstAction
        self.secondAction = secondAction
        self.thirdAction = thirdAction
    }

    var body: some View {
        VStack(spacing: 8) {
            Spacer()
            if showMenuItem1 {
                MenuItem(icon: "camera.fill") {
                    firstAction()
                }
            }
            if showMenuItem2 {
                MenuItem(icon: "photo.on.rectangle") {
                    secondAction()
                }
            }
            if showMenuItem3 {
                MenuItem(icon: "square.and.arrow.up.fill") {
                    thirdAction()
                }
            }
            Button {
                self.showChildMenu()
            } label: {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.purple)
                    .shadow(color: .gray, radius: 0.2, x: 1, y: 1)
                    .frame(width: 40, height: 40)
            }
        }
        .frame(maxHeight: .infinity)
    }

    func showChildMenu() {
        withAnimation {
            self.showMenuItem3.toggle()
        }
        DispatchQueue.main.asyncAfter(
            deadline: .now() + 0.1,
            execute: {
                withAnimation {
                    self.showMenuItem2.toggle()
                }
            })
        DispatchQueue.main.asyncAfter(
            deadline: .now() + 0.2,
            execute: {
                withAnimation {
                    self.showMenuItem1.toggle()
                }
            })
    }
}

struct MenuItem: View {
    let icon: String
    let action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                Circle()
                    .foregroundColor(Color(red: 153 / 255, green: 102 / 255, blue: 255 / 255))
                    .frame(width: 35, height: 35)
                Image(systemName: icon)
                    .imageScale(.small)
                    .foregroundColor(.white)
            }
        }
        .shadow(color: .gray, radius: 0.2, x: 1, y: 1)
        .transition(.move(edge: .trailing))
    }
}

struct FloatingMenuView_Previews: PreviewProvider {
    static var previews: some View {
        FloatingMenuView {
        } secondAction: {
        } thirdAction: {
        }
    }
}
