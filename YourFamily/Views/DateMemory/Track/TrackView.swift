//
// Create in 2022 by iletai.
// Follow me at: @iletai
//

import SwiftUI

struct TrackView: View {
    private var onBoardingViewModel = OnBoardingViewModel()

    var body: some View {
        Group {
            if !onBoardingViewModel.finishOnBoarding {
                OnboardingViewPure(data: onBoardingViewModel.dataOnBoarding) {
                    self.onBoardingViewModel.saveFinishOnBoarding()
                }
            } else {
                Text("Hello world")
            }
        }
    }
}

struct TrackView_Previews: PreviewProvider {
    static var previews: some View {
        TrackView()
    }
}
