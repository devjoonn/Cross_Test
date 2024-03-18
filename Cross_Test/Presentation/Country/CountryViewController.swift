//
//  CountryViewController.swift
//  Cross_Test
//
//  Created by 박현준 on 3/18/24.
//

import UIKit

import ReactorKit
import RxSwift
import SnapKit

class CountryViewController: UIViewController {

    private let reactor = CountryReactor()
    var disposeBag = DisposeBag()
    
    // MARK: - Properties
    private let countryTableView = CountryTableView()
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setLayout()
    }
    
    // MARK: - Set UI
    private func setView() {
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        countryTableView.delegate = self
        countryTableView.dataSource = self
    }
    
    private func setLayout() {
        view.addSubview(countryTableView)
        
        countryTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
    }
}

extension CountryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.identifier, for: indexPath) as? CountryTableViewCell else { return UITableViewCell() }
        
        cell.configure()
        return cell
    }
}

// MARK: - Bind
extension CountryViewController: View {
    public func bind(reactor: CountryReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }

    func bindAction(reactor: CountryReactor) {

    }

    func bindState(reactor: CountryReactor) {
        
    }
}
