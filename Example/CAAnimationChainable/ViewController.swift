//
//  ViewController.swift
//  CAAnimationChainable
//
//  Created by 19640477 on 03/25/2024.
//  Copyright (c) 2024 19640477. All rights reserved.
//

import UIKit
import CAAnimationChainable

class ViewController: UIViewController {

    lazy private var _view: UIView = self.initView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.initUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self._view.animaChain.add(anima: .rotate(angle: .pi * 2,
                                                 repeatCount: .infinity)).run()
    }
}

private extension ViewController {
    func initUI() {
        self.view.addSubview(self._view)
    }
    
    func initView() -> UIView {
        let view: UIView = .init(frame: .init(x: 100, y: 100, width: 50, height: 50))
        view.backgroundColor = .red
        return view
    }
}
