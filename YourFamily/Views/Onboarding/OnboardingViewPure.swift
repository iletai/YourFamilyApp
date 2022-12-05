//
//  OnboardingViewPure.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 8/25/22.
//

import SwiftUI

struct OnboardingViewPure: View {
    var data: [OnboardingDataModel]
    var doneFunction: () -> Void

    @State var slideGesture: CGSize = CGSize.zero
    @State var curSlideIndex = 0
    var distance: CGFloat = UIScreen.main.bounds.size.width

    var body: some View {
        ZStack {
            Color(.systemBackground).edgesIgnoringSafeArea(.all)
            ZStack(alignment: .center) {
                ForEach(data, id: \.id) { item in
                    OnboardingStepView(data: item)
                        .offset(x: CGFloat(item.id) * self.distance)
                        .offset(
                            x: self.slideGesture.width - CGFloat(self.curSlideIndex) * self.distance
                        )
                        .gesture(
                            DragGesture().onChanged { value in
                                self.slideGesture = value.translation
                            }
                            .onEnded { _ in
                                if self.slideGesture.width < -50 {
                                    if self.curSlideIndex < self.data.count - 1 {
                                        withAnimation {
                                            self.curSlideIndex += 1
                                        }
                                    }
                                }
                                if self.slideGesture.width > 50 {
                                    if self.curSlideIndex > 0 {
                                        withAnimation {
                                            self.curSlideIndex -= 1
                                        }
                                    }
                                }
                                self.slideGesture = .zero
                            }
                        )
                }
            }
            VStack {
                Spacer()
                HStack {
                    self.progressView()
                    Spacer()
                    Button(action: nextButton) {
                        self.arrowView()
                    }
                }
            }
            .padding(20)
        }
    }

    func arrowView() -> some View {
        Group {
            if self.curSlideIndex == self.data.count - 1 {
                HStack {
                    Text("Done")
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundColor(Color(.systemBackground))
                }
                .frame(width: 70, height: 40)
                .background(Color(.label))
                .cornerRadius(25)
            } else {
                Image(systemName: "arrow.right.circle.fill")
                    .resizable()
                    .foregroundColor(Color(.label))
                    .scaledToFit()
                    .frame(width: 50)
            }
        }
    }

    func progressView() -> some View {
        HStack {
            ForEach(data, id: \.id) { i in
                Circle()
                    .scaledToFit()
                    .frame(width: 10)
                    .foregroundColor(
                        self.curSlideIndex >= i.id ? Color(.systemIndigo) : Color(.white)
                    )
            }
        }
        .padding()
        .background(
            Color.secondary
                .opacity(0.3)
                .clipShape(Capsule())
        )
    }

    func nextButton() {
        if self.curSlideIndex == self.data.count - 1 {
            doneFunction()
            return
        }

        if self.curSlideIndex < self.data.count - 1 {
            withAnimation {
                self.curSlideIndex += 1
            }
        }
    }
}

struct OnboardingViewPure_Previews: PreviewProvider {
    static let sample = OnBoardingViewModel()
    static var previews: some View {
        OnboardingViewPure(data: sample.dataOnBoarding) {
        }
    }
}
