import UIKit
import AVFoundation

class HomeMovieQuizViewController: UIViewController, Coordinating {
    var coordinator: Coordinator?
    
    private var quizPlayer: AVAudioPlayer!
    private var playeritem: AVPlayerItem!
    private var backgroundMusicPlayer: AVPlayer!
    
    private let viewModel: HomeMovieQuizViewModel?
    
    init(viewModel: HomeMovieQuizViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var homeView: HomeMovieQuizView?
    
    override func loadView() {
        super.loadView()
        homeView = HomeMovieQuizView()
        homeView?.delegate = self
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        viewModel?.fetchQuizes()
        viewModel?.fetchQuizOptions()
        playBackgroundMusic()
        homeView?.soundBarView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.clearScore()
        getNewQuiz()
        startTimer()
    }
    
    private func playBackgroundMusic() {
        guard let musicURL = Bundle.main.url(forResource: "MarchaImperial", withExtension: "mp3") else { return }
        playeritem = AVPlayerItem(url: musicURL)
        backgroundMusicPlayer = AVPlayer(playerItem: playeritem)
        backgroundMusicPlayer.volume = 0.1
        backgroundMusicPlayer.play()
        
        backgroundMusicPlayer.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: nil) { [weak self] (time) in
            guard let songDuration = self?.playeritem.duration.seconds else { return }
            let percent = time.seconds / songDuration
            self?.homeView?.soundBarView.soundSlider.setValue(Float(percent), animated: true)
        }
    }
    
    private func getNewQuiz() {
        guard let round = viewModel?.generateRandomQuiz() else { return }
        
        for i in 0 ..< round.options.count {
            guard let buttons = homeView?.buttons else { return }
            buttons[i].setTitle(round.options[i].name, for: .normal)
        }
        
        playQuiz()
    }
    
    private func playQuiz() {
        guard let round = viewModel?.getRound else { return }
        
        homeView?.backView.soundImageView.image = UIImage(named: "movieSound")
        
        if let url = Bundle.main.url(forResource: "quote\(round.quiz.number)", withExtension: "mp3") {
            do {
                quizPlayer = try AVAudioPlayer(contentsOf: url)
                quizPlayer.volume = 1
                quizPlayer.delegate = self
                quizPlayer.play()
            } catch {
                print(error)
            }
        }
    }
    
    private func startTimer() {
        homeView?.timerView.frame = view.frame
        
        UIView.animate(withDuration: 60, delay: 0.0, options: .curveLinear) {
            self.homeView?.timerView.frame.size.width = 0
            self.homeView?.timerView.frame.origin.x = self.view.center.x
        } completion: { [weak self] (success) in
            self?.gameOver()
        }
    }
    
    private func gameOver() {
        guard let score = viewModel?.getScore else { return }
        coordinator?.eventOcurred(with: .pushToDetailMovieVC(score))
        quizPlayer.stop()
    }
    
    private func changeMusicStatus(_ sender: UIButton) {
        if backgroundMusicPlayer.timeControlStatus == .paused {
            backgroundMusicPlayer.play()
            sender.setBackgroundImage(UIImage(named: "pause"), for: .normal)
        } else {
            backgroundMusicPlayer.pause()
            sender.setBackgroundImage(UIImage(named: "play"), for: .normal)
        }
    }
    
    private func showHideSoundBar(_ sender: UIButton) {
        guard let soundBarView = homeView?.soundBarView else { return }
        soundBarView.isHidden = !soundBarView.isHidden
    }
}

extension HomeMovieQuizViewController: HomeMovieQuizViewDelegate {
    func didSoundButtonTapped() {
        playQuiz()
    }
    
    func didPlayPauseButtonTapped(sender: UIButton) {
        changeMusicStatus(sender)
    }
    
    func didMusicButtonTapped(sender: UIButton) {
        showHideSoundBar(sender)
    }
    
    func didSliderSelected(sender: UISlider) {
        backgroundMusicPlayer.seek(to: CMTime(seconds: Double(sender.value) * playeritem.duration.seconds, preferredTimescale: 1))
    }
    
    func didOptionButtonTapped(sender: UIButton) {
        guard let buttonTitle = sender.title(for: .normal) else { return }
        viewModel?.checkAnswer(buttonTitle)
        getNewQuiz()
    }
}

extension HomeMovieQuizViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        homeView?.backView.soundImageView.image = UIImage(named: "movieSoundPause")
    }
}
