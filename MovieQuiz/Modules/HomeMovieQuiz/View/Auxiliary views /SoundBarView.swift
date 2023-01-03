import UIKit

class SoundBarView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    lazy var playPauseButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "pause"), for: .normal)
        return button
    }()
    
    lazy var backgroundSoundBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var soundSlider: UISlider = {
        let slider = UISlider()
        slider.isContinuous = false
        slider.maximumValue = 1.0
        slider.minimumValue = 0.0
        slider.value = 0.5
        return slider
    }()
}

extension SoundBarView: CodeView {
    func buildViewHierarchy() {
        addSubview(playPauseButton)
        addSubview(soundSlider)
    }
    
    func setupConstrains() {
        playPauseButton.fillConstraints(
            top: topAnchor,
            leading: leadingAnchor,
            trailing: nil,
            bottom: nil,
            padding: .init(top: 10, left: 10, bottom: 0, right: 0),
            size: .init(width: 50, height: 44)
        )
        
        soundSlider.fillConstraints(
            top: nil,
            leading: playPauseButton.trailingAnchor,
            trailing: trailingAnchor,
            bottom: nil,
            padding: .init(top: 0, left: 10, bottom: 0, right: 80)
        )
        
        soundSlider.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
