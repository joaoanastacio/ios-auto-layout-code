//
//  ViewController.swift
//  AutoLayoutStarter
//
//  Created by Derrick Park on 2019-04-17.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  let mainView: UIView = {
    let main = UIView()
    // important when setting contraints programmatically
    main.translatesAutoresizingMaskIntoConstraints = false
    main.backgroundColor = .green
    return main
  }()
    
  let redView: UIView = {
    let redView = UIView()
    redView.translatesAutoresizingMaskIntoConstraints = false
    redView.backgroundColor = .red
        
    let redSubViewOne = UIView(frame: CGRect(x: 10, y: 10, width: 140, height: 60))
    redSubViewOne.backgroundColor = .orange
        
    let redSubViewTwo = UIView(frame: CGRect(x: 160, y: 10, width: 90, height: 60))
    redSubViewTwo.backgroundColor = .orange
        
    redView.widthAnchor.constraint(equalToConstant: 260).isActive = true
    redView.heightAnchor.constraint(equalToConstant: 80).isActive = true
      
    redView.addSubview(redSubViewOne)
    redView.addSubview(redSubViewTwo)
    return redView
  }()
    
  let blueStackView: UIStackView = {
    let blueStackView = UIStackView(arrangedSubviews: [UIView(), createBlueView(), createBlueView(), createBlueView(), UIView()])
    blueStackView.translatesAutoresizingMaskIntoConstraints = false
    blueStackView.axis = .vertical
    blueStackView.distribution = .equalSpacing
    return blueStackView
  }()
    
  private static func createBlueView() -> UIView {
    let blueView = UIView()
    blueView.translatesAutoresizingMaskIntoConstraints = false
    blueView.backgroundColor = .blue
    blueView.widthAnchor.constraint(equalToConstant: 80).isActive = true
    blueView.heightAnchor.constraint(equalToConstant: 80).isActive = true
    return blueView
  }
    
  let purpleView: UIView = {
    let purple = UIView()
    purple.translatesAutoresizingMaskIntoConstraints = false
    purple.backgroundColor = .purple
    return purple
  }()
    
  let squareButton: UIButton = {
    let butt = UIButton(type: .system)
    butt.setTitle("Square", for: .normal)
    butt.translatesAutoresizingMaskIntoConstraints = false
    butt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    butt.addTarget(self, action: #selector(squareTapped), for: .touchUpInside)
    return butt
  }()
  
  let portraitButton: UIButton = {
    let butt = UIButton(type: .system)
    butt.setTitle("Portrait", for: .normal)
    butt.translatesAutoresizingMaskIntoConstraints = false
    butt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    butt.addTarget(self, action: #selector(portraitTapped), for: .touchUpInside)
    return butt
  }()
  
  let landScapeButton: UIButton = {
    let butt = UIButton(type: .system)
    butt.setTitle("Landscape", for: .normal)
    butt.translatesAutoresizingMaskIntoConstraints = false
    butt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    butt.addTarget(self, action: #selector(landscapeTapped), for: .touchUpInside)
    return butt
  }()
  
  var widthAnchor: NSLayoutConstraint?
  var heightAnchor: NSLayoutConstraint?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
      
    mainView.addSubview(redView)
    mainView.addSubview(purpleView)
    mainView.addSubview(blueStackView)
    view.addSubview(mainView)
    
    setupConstraints()
    setupLayout()
  }
    
  fileprivate func setupConstraints() {
    NSLayoutConstraint.activate([
        redView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
        redView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 16),
        
        blueStackView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
        blueStackView.heightAnchor.constraint(equalTo: mainView.heightAnchor),
        
        purpleView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
        purpleView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -16),
        purpleView.heightAnchor.constraint(equalToConstant: 80),
        purpleView.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.7)
    ])
  }

  fileprivate func setupLayout() {
    mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    widthAnchor = mainView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7, constant: 0)
    widthAnchor?.isActive = true
    
    heightAnchor = mainView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7, constant: 0)
    heightAnchor?.isActive = true
    
    let buttStackView = UIStackView(arrangedSubviews: [
      squareButton, portraitButton, landScapeButton])
    buttStackView.translatesAutoresizingMaskIntoConstraints = false
    buttStackView.axis = .horizontal
    buttStackView.alignment = .center
    buttStackView.distribution = .fillEqually
    
    view.addSubview(buttStackView)
    NSLayoutConstraint.activate([
      buttStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
      buttStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      buttStackView.heightAnchor.constraint(equalToConstant: 50),
      buttStackView.widthAnchor.constraint(equalTo: view.widthAnchor)
      ])
  }

  @objc private func squareTapped() {
    view.layoutIfNeeded()
    UIView.animate(withDuration: 2.0) {
      self.widthAnchor?.isActive = false
      self.widthAnchor? = self.mainView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9)
      self.widthAnchor?.isActive = true
      
      self.heightAnchor?.isActive = false
      self.heightAnchor? = self.mainView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9)
      self.heightAnchor?.isActive = true
      self.view.layoutIfNeeded()
    }
  }
  
  @objc private func portraitTapped() {
    view.layoutIfNeeded()
    UIView.animate(withDuration: 2.0) {
      self.widthAnchor?.isActive = false
      self.widthAnchor? = self.mainView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7)
      self.widthAnchor?.isActive = true
      
      self.heightAnchor?.isActive = false
      self.heightAnchor? = self.mainView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.7)
      self.heightAnchor?.isActive = true
      self.view.layoutIfNeeded()
    }
    
  }
  
  @objc private func landscapeTapped() {
    view.layoutIfNeeded()
    UIView.animate(withDuration: 2.0) {
      self.widthAnchor?.isActive = false
      self.widthAnchor? = self.mainView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.95)
      self.widthAnchor?.isActive = true
      
      self.heightAnchor?.isActive = false
      self.heightAnchor? = self.mainView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.4)
      self.heightAnchor?.isActive = true
      self.view.layoutIfNeeded()
    }
  }
}

