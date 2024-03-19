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
    func starButtonTapped(country: CountryConfigure)
}

class CountryTableViewCell: UITableViewCell {
    static let identifier = "CountryTableViewCell"
    
    var starButtonSelected: Bool = false {
        didSet {
            starButton.isSelected = starButtonSelected
        }
    }
    
    var country: CountryConfigure? {
        didSet {
            configure()
        }
    }
    
    private let countryNameLabel: UILabel = {
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
        starButtonSelected = false
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
        guard let country else { return }
        
        countryNameLabel.text = country.name
    }
    
    // MARK: - Action
    private func bind() {
        starButton.rx.tap
            .bind { [weak self] _ in
                guard let self = self,
                let country = self.country else { return }
                self.delegate?.starButtonTapped(country: country)
                self.starButtonSelected.toggle()
            }
            .disposed(by: disposeBag)
    }
}
