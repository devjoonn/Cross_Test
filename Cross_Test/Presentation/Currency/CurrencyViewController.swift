//
//  CurrencyViewController.swift
//  Cross_Test
//
//  Created by 박현준 on 3/20/24.
//

import UIKit

final class CurrencyViewController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - Life Cycles
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setLayout()
    }
    
    // MARK: - Set UI
    private func setView() {
        view.backgroundColor = .blue
    }
    
    private func setLayout() {
        
    }
}
