//
//  OnboardingStepView.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 8/25/22.
//

import SwiftUI

struct OnboardingStepView: View {
    var data: OnboardingDataModel

    var body: some View {
        VStack {
            Image(data.image)
                .resizable()
                .scaledToFit()
                .padding(.bottom, 50)

            Text(data.heading)
                .font(.system(size: 25, design: .rounded))
                .fontWeight(.bold)
                .padding(.bottom, 20)

            Text(data.text)
                .font(.system(size: 17, design: .rounded))
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
        }
        .padding()
        .contentShape(Rectangle())
    }
}

struct OnboardingStepView_Previews: PreviewProvider {
    static var data = OnBoardingViewModel().dataOnBoarding
    static var previews: some View {
        OnboardingStepView(data: data[0])
    }
}
