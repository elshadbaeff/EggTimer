//
//  ViewController.swift
//  EggTimer
//
//  Created by Elshad Babaev on 02.08.2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    let eggTimes = ["Soft": 100, "Medium": 200, "Hard": 300]
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "How do u like your eggs?"
        label.tintColor = .black
        label.font = .systemFont(ofSize: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let myProgressBar: UIProgressView = {
        let progress = UIProgressView()
        progress.progressTintColor = UIColor(red: 255/255, green: 204/255, blue: 0/255, alpha: 1)
        progress.trackTintColor = .darkGray
        progress.progressViewStyle = .bar
        progress.contentMode = .scaleToFill
        progress.semanticContentAttribute = .unspecified
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    
    let firstEggButton: UIButton = {
        let button = UIButton()
        button.setTitle("Soft", for: .normal)
        button.setImage(UIImage(named: "soft_egg"), for: .normal)
        button.backgroundColor = .none
        button.addTarget(self, action: #selector(cooking), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let secondEggButton: UIButton = {
        let button = UIButton()
        button.setTitle("Medium", for: .normal)
        button.setImage(UIImage(named: "medium_egg"), for: .normal)
        button.backgroundColor = .none
        button.addTarget(self, action: #selector(cooking), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let thirdEggButton: UIButton = {
        let button = UIButton()
        button.setTitle("Hard", for: .normal)
        button.setImage(UIImage(named: "hard_egg"), for: .normal)
        button.backgroundColor = .none
        button.addTarget(self, action: #selector(cooking), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 203/255, green: 242/255, blue: 252/255, alpha: 1)
        view.addSubview(firstEggButton)
        view.addSubview(secondEggButton)
        view.addSubview(thirdEggButton)
        view.addSubview(myProgressBar)
        view.addSubview(titleLabel)
        myProgressBar.progress = 0
        
        NSLayoutConstraint.activate([
            firstEggButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            firstEggButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            firstEggButton.heightAnchor.constraint(equalToConstant: 150),
            firstEggButton.widthAnchor.constraint(equalToConstant: 111),
            
            secondEggButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            secondEggButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondEggButton.heightAnchor.constraint(equalToConstant: 150),
            secondEggButton.widthAnchor.constraint(equalToConstant: 111),
            
            thirdEggButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            thirdEggButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            thirdEggButton.heightAnchor.constraint(equalToConstant: 150),
            thirdEggButton.widthAnchor.constraint(equalToConstant: 111),
            
            myProgressBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myProgressBar.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            myProgressBar.heightAnchor.constraint(equalToConstant: 8),
            myProgressBar.widthAnchor.constraint(equalToConstant: 350),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
            
            
            
            
            
        ])
    }
    
    @objc func cooking(sender: UIButton) {
        
        timer.invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!

        myProgressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness

        timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(updateTimer), userInfo:nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            myProgressBar.progress = Float(secondsPassed) / Float(totalTime)
            print(Float(secondsPassed) / Float(totalTime))
        } else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
    
    
    
}

