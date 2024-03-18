//
//  CountryTableView.swift
//  Cross_Test
//
//  Created by 박현준 on 3/18/24.
//

import UIKit

final class CountryTableView: UITableView {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setView()
    }
    
    private func setView() {
        register(CountryTableViewCell.self, forCellReuseIdentifier: CountryTableViewCell.identifier)
        separatorInset.left = 0
        rowHeight = 50
    }
}
