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

final class CountryViewController: UIViewController {

    private let reactor: CountryReactor
    var disposeBag = DisposeBag()
    
    // MARK: - Properties
    private let countryTableView = CountryTableView()
    
    // MARK: - Life Cycles
    init(reactor: CountryReactor) {
        self.reactor = reactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setLayout()
        bind(reactor: reactor)
        reactor.fetchCountries()
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

// MARK: - UITableViewDelegate, UITableViewDataSource
extension CountryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reactor.currentState.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.identifier, for: indexPath) as? CountryTableViewCell else { return UITableViewCell() }
        let country = reactor.currentState.countries[indexPath.row]
        
        if !reactor.checkBookmarkedCountry(country: country).isEmpty {
            cell.starButtonSelected = true
        }
        
        cell.delegate = self
        cell.country = country
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
        reactor.state
            .map { $0.countries }
            .observe(on: MainScheduler.instance)
            .bind { [weak self] countries in
                self?.countryTableView.reloadData()
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - StarButton을 눌렀을 때
extension CountryViewController: CountryTableViewCellDelegate {
    func starButtonTapped(country: CountryConfigure) {
        reactor.bookmarkCountry(country: country)
    }
}
