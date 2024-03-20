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
        $0.font = .preferredFont(forTextStyle: .body)
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - Set UI
    private func setView() {
        view.backgroundColor = .white
    }
    
    private func setLayout() {
        view.addSubview(currencyLabel)
        
        currencyLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

// MARK: - Bind
extension CurrencyViewController: View {
    public func bind(reactor: CurrencyReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }

    func bindAction(reactor: CurrencyReactor) {
        
    }

    func bindState(reactor: CurrencyReactor) {
        
    }
}

