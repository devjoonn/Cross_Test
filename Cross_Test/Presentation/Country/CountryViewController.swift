//
//  CountryViewController.swift
//  Cross_Test
//
//  Created by 박현준 on 3/18/24.
//

import UIKit

import ReactorKit
import RxSwift
import RxCocoa
import SnapKit

final class CountryViewController: UIViewController {

    private let reactor: CountryReactor
    private let coordinator: CountryCoordinator
    var disposeBag = DisposeBag()
    
    // MARK: - Properties
    private let refreshControl = UIRefreshControl()
    private let countryTableView = CountryTableView()
    
    // MARK: - Life Cycles
    init(reactor: CountryReactor, coordinator: CountryCoordinator) {
        self.reactor = reactor
        self.coordinator = coordinator
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
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Set UI
    private func setView() {
        view.backgroundColor = .white
        countryTableView.delegate = self
        countryTableView.dataSource = self
        countryTableView.refreshControl = refreshControl
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = reactor.currentState.countries[indexPath.row]
        coordinator.startCurrencyViewController(country: country)
    }
}

// MARK: - Bind
extension CountryViewController: View {
    public func bind(reactor: CountryReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }

    func bindAction(reactor: CountryReactor) {
        refreshControl.rx.controlEvent(.valueChanged)
            .observe(on: MainScheduler.instance)
            .bind { [weak self] _ in
                self?.reactor.fetchCountries()
            }
            .disposed(by: disposeBag)
    }

    func bindState(reactor: CountryReactor) {
        reactor.state
            .map { $0.countries }
            .observe(on: MainScheduler.instance)
            .bind { [weak self] countries in
                self?.countryTableView.reloadData()
                self?.refreshControl.endRefreshing()
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
