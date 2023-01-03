//
//  BackView.swift
//  MovieQuiz
//
//  Created by Leonardo Almeida on 28/12/22.
//

import UIKit

class BackView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    lazy var soundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "movieSound"))
        return imageView
    }()
    
    lazy var soundButton: UIButton = {
        let button = UIButton()
        return button
    }()
}

extension BackView: CodeView {
    func buildViewHierarchy() {
        addSubview(soundImageView)
        addSubview(soundButton)
    }
    
    func setupConstrains() {
        soundImageView.superviewCenter(size: .init(width: 450, height: 300))
        soundButton.superviewCenter()
        soundButton.size(size: .init(width: soundImageView.frame.width, height: soundImageView.frame.height))
    }
}
