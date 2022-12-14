//
//  SearchResponseTableViewController.swift
//
//
//  Created by Lorenzo Fiamingo on 21/02/22.
//

import MapKit
import UIKit

class SearchResponseTableViewController: UITableViewController {
    private static let cellReuseID = "CellReuseID"
    private var currentPlacemark: CLPlacemark?
    var onMapItemSelection: ((Int) -> Void)?
    var onViewWillLayoutSubviews: (() -> Void)?
    var searchResponse: MKLocalSearch.Response? {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: SearchResponseTableViewController.cellReuseID
        )
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        onViewWillLayoutSubviews?()
    }
}

extension SearchResponseTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResponse?.mapItems.count ?? 0
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int)
    -> String? {
        if let city = currentPlacemark?.locality {
            return "Results near \(city)"
        } else {
            return "Results"
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
    -> UITableViewCell {
        if #available(iOS 14.0, *) {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: SearchResponseTableViewController.cellReuseID,
                for: indexPath
            )
            if let response = searchResponse {
                let mapItem = response.mapItems[indexPath.item]
                var content = cell.defaultContentConfiguration()
                content.text = mapItem.placemark.name
                content.secondaryText = mapItem.placemark.title
                cell.contentConfiguration = content
            }
            return cell
        } else {
            fatalError("Fail")
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onMapItemSelection?(indexPath.item)
    }
}
