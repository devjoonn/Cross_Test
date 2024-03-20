//
//  CurrencyViewController.swift
//  Cross_Test
//
//  Created by 박현준 on 3/20/24.
//

import UIKit

import ReactorKit
import RxSwift
import RxCocoa
import SnapKit

final class CurrencyViewController: UIViewController {
    
    private let reactor: CurrencyReactor
    private let coordinator: CountryCoordinator
    var disposeBag = DisposeBag()
    
    // MARK: - Properties
    private let currencyLabel: UILabel = {
        $0.text = "불러오는 중"
        $0.font = .preferredFont(forTextStyle: .headline)
        $0.textAlignment = .center
        $0.textColor = .label
        return $0
    }(UILabel())
    
    // MARK: - Life Cycles
    init(reactor: CurrencyReactor, coordinator: CountryCoordinator) {
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
        reactor.fetchCurrency()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - Set UI
    private func setView() {
        view.backgroundColor = .systemBackground
    }
    
    private func setLayout() {
        view.addSubview(currencyLabel)
        
        currencyLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
}

// MARK: - Bind
extension CurrencyViewController: View {
    public func bind(reactor: CurrencyReactor) {
        bindState(reactor: reactor)
    }

    func bindState(reactor: CurrencyReactor) {
        reactor.state
            .map { $0.resultCurrency }
            .observe(on: MainScheduler.instance)
            .bind { [weak self] currency in
                self?.currencyLabel.text = currency
            }
            .disposed(by: disposeBag)
    }
}

