import UIKit

protocol HomeMovieQuizViewDelegate: AnyObject {
    func didOptionButtonTapped(sender: UIButton)
    func didSliderSelected(sender: UISlider)
    func didMusicButtonTapped(sender: UIButton)
    func didPlayPauseButtonTapped(sender: UIButton)
    func didSoundButtonTapped()
}

final class HomeMovieQuizView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
        addSoundSliderAction()
        addPlayerPauseButtonAction()
        addSoundButtonAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    weak var delegate: HomeMovieQuizViewDelegate?
    
    lazy var backView: BackView = {
        return BackView()
    }()
    
    lazy var soundBarView: SoundBarView = {
        return SoundBarView()
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "background"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var timerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.alpha = 0.5
        return view
    }()
    
    var buttons: [UIButton] {
        let buttons = [
            optionButtonOne,
            optionButtonTwo,
            optionButtonThree,
            optionButtonFour
        ]
        return buttons
    }
    
    private lazy var optionButtonOne: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Nome do filme", for: .normal)
        button.addTarget(self, action: #selector(optionButtonTapped(sender:)), for: .touchUpInside)
        button.backgroundColor = UIColor(hexString: "FFFF8B")
        return button
    }()
    
    private lazy var optionButtonTwo: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Nome do filme", for: .normal)
        button.addTarget(self, action: #selector(optionButtonTapped(sender:)), for: .touchUpInside)
        button.backgroundColor = UIColor(hexString: "FFFF8B")
        return button
    }()
    
    private lazy var optionButtonThree: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Nome do filme", for: .normal)
        button.addTarget(self, action: #selector(optionButtonTapped(sender:)), for: .touchUpInside)
        button.backgroundColor = UIColor(hexString: "FFFF8B")
        return button
    }()
    
    private lazy var optionButtonFour: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Nome do filme", for: .normal)
        button.addTarget(self, action: #selector(optionButtonTapped(sender:)), for: .touchUpInside)
        button.backgroundColor = UIColor(hexString: "FFFF8B")
        return button
    }()
    
    private lazy var musicButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "music"), for: .normal)
        button.addTarget(self, action: #selector(musicButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private func addSoundButtonAction() {
        backView.soundButton.addTarget(self, action: #selector(soundButtonTapped), for: .touchUpInside)
    }
    
    private func addSoundSliderAction() {
        soundBarView.soundSlider.addTarget(self, action: #selector(sliderSelected(sender:)), for: .valueChanged)
    }
    
    private func addPlayerPauseButtonAction() {
        soundBarView.playPauseButton.addTarget(self, action: #selector(playPauseButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func soundButtonTapped() {
        delegate?.didSoundButtonTapped()
    }
        
    @objc func playPauseButtonTapped(_ sender: UIButton) {
        delegate?.didPlayPauseButtonTapped(sender: sender)
    }
    
    @objc func musicButtonTapped(_ sender: UIButton) {
        delegate?.didMusicButtonTapped(sender: sender)
    }
    
    @objc func sliderSelected(sender: UISlider) {
        delegate?.didSliderSelected(sender: sender)
    }
    
    @objc func optionButtonTapped(sender: UIButton) {
        delegate?.didOptionButtonTapped(sender: sender)
    }
}

extension HomeMovieQuizView: CodeView {
    func buildViewHierarchy() {
        addSubview(backgroundImageView)
        addSubview(timerView)
        addSubview(backView)
        addSubview(optionButtonOne)
        addSubview(optionButtonTwo)
        addSubview(optionButtonThree)
        addSubview(optionButtonFour)
        addSubview(soundBarView)
        addSubview(musicButton)
    }
    
    func setupConstrains() {
        backgroundImageView.fillSuperview()
        
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.fillConstraints(
            top: topAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: nil
        )
        
        optionButtonOne.fillConstraints(
            top: backView.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: nil,
            padding: .init(top: 20, left: 0, bottom: 0, right: 0),
            size: .init(width: 0, height: 44)
        )
        
        optionButtonTwo.fillConstraints(
            top: optionButtonOne.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: nil,
            padding: .init(top: 8, left: 0, bottom: 0, right: 0),
            size: .init(width: 0, height: 44)
        )
        
        optionButtonThree.fillConstraints(
            top: optionButtonTwo.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: nil,
            padding: .init(top: 8, left: 0, bottom: 0, right: 0),
            size: .init(width: 0, height: 44)
        )
        
        optionButtonFour.fillConstraints(
            top: optionButtonThree.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: nil,
            padding: .init(top: 8, left: 0, bottom: 0, right: 0),
            size: .init(width: 0, height: 44)
        )
        
        soundBarView.fillConstraints(
            top: optionButtonFour.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: bottomAnchor,
            padding: .init(top: 20, left: 0, bottom: 0, right: 0),
            size: .init(width: 0, height: 60)
        )
        
        musicButton.fillConstraints(
            top: nil,
            leading: nil,
            trailing: trailingAnchor,
            bottom: bottomAnchor,
            padding: .init(top: 0, left: 0, bottom: 10, right: 10),
            size: .init(width: 50, height: 44)
        )
    }
}

