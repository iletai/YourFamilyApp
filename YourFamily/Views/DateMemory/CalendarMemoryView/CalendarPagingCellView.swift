//
//  CalendarPagingCellView.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 8/29/22.
//

import Foundation
import Parchment
import SwiftUI
import UIKit

class CalendarPagingCellView: PagingCell {
    lazy var weekdayHostingController: UIHostingController = UIHostingController(
        rootView: weekdayLabelView
    )

    lazy var weekdayLabelView: WeekdayLabelView = {
        let weekdayLabelView = WeekdayLabelView(viewModel: DateMemoryViewModel())
        return weekdayLabelView
    }()

    lazy var dateLableView: DateLabelView = {
        let dateLable = DateLabelView(viewModel: DateMemoryViewModel())
        return dateLable
    }()

    lazy var dateHostingController: UIHostingController = UIHostingController(
        rootView: dateLableView
    )
    lazy var date = Date()

    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        config()
    }

    func config() {
        self.backgroundColor = UIColor(.white)
        addSubview(weekdayHostingController.view)
        addSubview(dateHostingController.view)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let insets = UIEdgeInsets(top: 10, left: .zero, bottom: 5, right: .zero)

        weekdayHostingController.view.frame = CGRect(
            x: .zero,
            y: insets.top,
            width: contentView.bounds.width,
            height: contentView.bounds.midY - insets.top
        )

        dateHostingController.view.frame = CGRect(
            x: .zero,
            y: contentView.bounds.midY,
            width: contentView.bounds.width,
            height: contentView.bounds.midY - insets.bottom
        )
    }

    func updateSelection(selected: Bool) {
        if selected {
            self.weekdayLabelTextColor(selected)
            dateLableView.viewModel.dateLabelBackgroundColor = Color.blue
        } else {
            self.weekdayLabelTextColor(selected)
            dateLableView.viewModel.dateLabelBackgroundColor = Color.clear
        }
    }

    private func weekdayLabelTextColor(_ selected: Bool = false) {
        if selected {
            weekdayLabelView.viewModel.weekdayLabelTextColor = Color.blue
        } else {
            weekdayLabelView.viewModel.weekdayLabelTextColor = Color.gray
        }
    }

    override func setPagingItem(_ pagingItem: PagingItem, selected: Bool, options: PagingOptions) {
        if let calendarItem = pagingItem as? CalendarMemoryItem {
            date = calendarItem.date
            dateLableView.viewModel.dateLabelText = calendarItem.dateText
            weekdayLabelView.viewModel.weekdayLabelText = calendarItem.weekdayText
            updateSelection(selected: selected)
        }
    }

    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
    }
}

extension CalendarPagingCellView {
    struct WeekdayLabelView: View {
        @ObservedObject var viewModel: DateMemoryViewModel
        var body: some View {
            ZStack {
                Text(viewModel.weekdayLabelText)
                    .fontWeight(.light)
                    .foregroundColor(viewModel.weekdayLabelTextColor)
                    .padding(.bottom, 16)
            }
            .background(Color.white)
        }
    }

    struct DateLabelView: View {
        @ObservedObject var viewModel: DateMemoryViewModel
        var body: some View {
            ZStack {
                Circle()
                    .fill(viewModel.dateLabelBackgroundColor)
                Text(viewModel.dateLabelText)
                    .bold()
                    .fontWeight(.light)
                    .padding(.all, 8)
            }
            .background(Color.white)
        }
    }
}
