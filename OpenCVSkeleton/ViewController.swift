//
//  ViewController.swift
//  OpenCVSkeleton
//
//  Created by Kaz Namba on 2019/10/21.
//  Copyright © 2019 Kaz Namba. All rights reserved.
//

import UIKit

class ViewController: UIViewController, HandlerDelegate {

    @IBOutlet weak var cameraView: UIImageView!
    
    let openCV = OpenCVWrapper()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        openCV.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        openCV.createCamera(withParentView: cameraView)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        openCV.start()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        openCV.stop()
    }
    
    func didProcessed() {
        NSLog("[didProcessed]")
    }
    
}
