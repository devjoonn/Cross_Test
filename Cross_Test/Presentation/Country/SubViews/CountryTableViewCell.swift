//
//  CountryTableViewCell.swift
//  Cross_Test
//
//  Created by 박현준 on 3/18/24.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit

protocol CountryTableViewCellDelegate: AnyObject {
    func checkedButtonTapped()
}

class CountryTableViewCell: UITableViewCell {
    static let identifier = "CountryTableViewCell"
    
    var checkedButtonSelected: Bool = false {
        didSet {
            starButton.isSelected = checkedButtonSelected
        }
    }
    
//    var country: Country? {
//        didSet {
//            configure()
//        }
//    }
    
    private let countryNameLabel: UILabel = {
        $0.text = "베트남"
        $0.font = .preferredFont(forTextStyle: .body)
        return $0
    }(UILabel())
    
    private let starButton: UIButton = {
        $0.setImage(UIImage(systemName: "star"), for: .normal)
        $0.setImage(UIImage(systemName: "star.fill"), for: .selected)
        return $0
    }(UIButton())
    
    weak var delegate: CountryTableViewCellDelegate?
    var disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView()
        addViews()
        setLayout()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        countryNameLabel.text = ""
        checkedButtonSelected = false
    }
    
    // MARK: - Set UI
    private func setView() {
        selectionStyle = .none
    }
    
    private func addViews() {
        [
            countryNameLabel,
            starButton,
        ].forEach {
            contentView.addSubview($0)
        }
    }
    private func setLayout() {
        countryNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
        }
        starButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalTo(countryNameLabel.snp.centerY)
            make.size.equalTo(30)
        }
    }
    
    func configure() {
        
    }
    
    // MARK: - Action
    private func bind() {
        starButton.rx.tap
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.delegate?.checkedButtonTapped()
                self.checkedButtonSelected.toggle()
            }.disposed(by: disposeBag)
    }
}
