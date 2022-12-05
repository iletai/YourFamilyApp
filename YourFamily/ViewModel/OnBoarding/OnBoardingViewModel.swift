//
// Create in 2022 by iletai.
// Follow me at: @iletai
//

import Foundation

final class OnBoardingViewModel: ObservableObject {
    @Published var finishOnBoarding = SettingManager.finishOnboarding
    @Published var dataOnBoarding = [
        OnboardingDataModel(
            id: 0,
            image: "period_tracker_first",
            heading: "Period Tracker",
            text: "Note the day"
        ),
        OnboardingDataModel(
            id: 1,
            image: "period_tracker_second",
            heading: "Explore the Near Date",
            text: "Remind Date"
        ),
        OnboardingDataModel(
            id: 2,
            image: "period_tracker_third",
            heading: "Live Life Easy",
            text: "Tracking Timesheet"
        )
    ]
}

extension OnBoardingViewModel {
    func saveFinishOnBoarding() {
        SettingManager.finishOnboarding = true
    }
}
