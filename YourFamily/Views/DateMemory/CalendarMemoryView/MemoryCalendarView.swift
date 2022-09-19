//
//  CalendarView.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 8/29/22.
//

import Parchment
import SwiftUI

struct MemoryCalendarView<Page: View>: View {
    private let calendarOptions: PagingOptions
    private let contentCalendar: (CalendarMemoryItem) -> Page
    private let selected: Date

    init(
        options: PagingOptions = PagingOptions(),
        contentCalendar: @escaping (CalendarMemoryItem) -> Page,
        selected: Date
    ) {
        self.calendarOptions = options
        self.contentCalendar = contentCalendar
        self.selected = selected
    }

    var body: some View {
        ZStack {
            CalendarPageController(
                calendarOptions: calendarOptions,
                contentCalendar: contentCalendar,
                selected: selected
            )
                .padding(8)
        }
    }
}

extension MemoryCalendarView {
    struct CalendarPageController: UIViewControllerRepresentable {
        let calendarOptions: PagingOptions
        let contentCalendar: (CalendarMemoryItem) -> Page
        let selected: Date

        func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }

        func makeUIViewController(
            context: UIViewControllerRepresentableContext<CalendarPageController>
        ) -> PagingViewController {
            let pagingViewController = PagingViewController()

            pagingViewController.register(CalendarPagingCellView.self, for: CalendarMemoryItem.self)
            pagingViewController.menuItemSize = .fixed(
                width: UIScreen.main.bounds.width / 7, height: 80)
            pagingViewController.textColor = UIColor.gray
            pagingViewController.indicatorColor = UIColor.clear
            pagingViewController.borderOptions = .hidden
            pagingViewController.collectionView.isScrollEnabled = false
            pagingViewController.select(pagingItem: CalendarMemoryItem(Date()))

            return pagingViewController
        }

        func updateUIViewController(
            _ uiViewController: PagingViewController,
            context: UIViewControllerRepresentableContext<CalendarPageController>
        ) {
            context.coordinator.parent = self
            if uiViewController.infiniteDataSource == nil {
                uiViewController.infiniteDataSource = context.coordinator
            } else {
                uiViewController.reloadData(around: CalendarMemoryItem(selected))
            }
        }
    }

}

extension MemoryCalendarView {
    class Coordinator: PagingViewControllerInfiniteDataSource {
        var parent: CalendarPageController

        init(_ pagingController: CalendarPageController) {
            self.parent = pagingController
        }

        func pagingViewController(
            _: PagingViewController,
            itemAfter pagingItem: PagingItem
        ) -> PagingItem? {
            if let calendarItem = pagingItem as? CalendarMemoryItem,
                let diff = DateUtils.getDayDiff(calendarItem.date), diff < 6 {
                return CalendarMemoryItem(DateUtils.addingDay(calendarItem.date, day: 1))
            }
            return nil
        }

        func pagingViewController(
            _: PagingViewController,
            itemBefore pagingItem: PagingItem
        ) -> PagingItem? {
            if let calendarItem = pagingItem as? CalendarMemoryItem,
                let diff = DateUtils.getDayDiff(calendarItem.date),
                diff > .zero {
                return CalendarMemoryItem(DateUtils.addingDay(calendarItem.date, day: -1))
            }
            return nil
        }

        func pagingViewController(
            _: PagingViewController,
            viewControllerFor pagingItem: PagingItem
        ) -> UIViewController {
            if let calendarItem = pagingItem as? CalendarMemoryItem {
                return UIHostingController(rootView: self.parent.contentCalendar(calendarItem))
            }
            return UIHostingController(
                rootView: self.parent.contentCalendar(CalendarMemoryItem(Date())))
        }
    }
}
