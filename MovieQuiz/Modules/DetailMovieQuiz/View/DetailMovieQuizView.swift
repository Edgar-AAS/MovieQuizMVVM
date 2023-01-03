import UIKit

protocol DetailMovieQuizViewDelegate: AnyObject {
    func playAgainButtonDidTapped()
}

final class DetailMovieQuizView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    weak var delegate: DetailMovieQuizViewDelegate?
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private lazy var detailBackgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "gameOver"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var congratsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Parabéns"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 45)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "O seu total de acertos foi: "
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "100"
        label.textColor = UIColor(hexString: "FFFF8B")
        label.font = UIFont.boldSystemFont(ofSize: 130)
        return label
    }()
    
    private lazy var playAgainButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(hexString: "FF5446")
        button.addTarget(self, action: #selector(playAgainButtonTapped), for: .touchUpInside)
        button.setTitle("Jogar novamente", for: .normal)
        return button
    }()
    
    @objc private func playAgainButtonTapped() {
        delegate?.playAgainButtonDidTapped()
    }
}

extension DetailMovieQuizView: CodeView {
    func buildViewHierarchy() {
        addSubview(detailBackgroundImageView)
        addSubview(congratsLabel)
        addSubview(descriptionLabel)
        addSubview(scoreLabel)
        addSubview(playAgainButton)
    }
    
    func setupConstrains() {
        detailBackgroundImageView.fillConstraints(
            top: topAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: bottomAnchor,
            padding: .init(top: -4, left: 0, bottom: -4, right: 0)
        )
        
        congratsLabel.topAnchor.constraint(equalTo: topAnchor, constant: 130).isActive = true
        congratsLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: congratsLabel.bottomAnchor, constant: 8).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        scoreLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8).isActive = true
        scoreLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        playAgainButton.fillConstraints(
            top: nil,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: bottomAnchor,
            padding: .init(top: 0, left: 10, bottom: 30, right: 20),
            size: .init(width: 0, height: 40)
        )
    }
}
