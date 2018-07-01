//
//  ViewController.swift
//  Study-ReplayKit
//
//  Created by Takayuki Sei on 2018/07/02.
//  Copyright © 2018年 Takayuki Sei. All rights reserved.
//

import UIKit
import ReplayKit

class ViewController: UIViewController, RPPreviewViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "start", style: .plain, target: self, action: #selector(startRecording))
    }

    @objc func startRecording() {
        let recorder = RPScreenRecorder.shared()
        recorder.startRecording { [unowned self] (error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "stop", style: .plain, target: self, action: #selector(self.stopRecording))

        }
    }
    
    @objc func stopRecording() {
        let recorder = RPScreenRecorder.shared()
        recorder.stopRecording { [unowned self] (preview, error) in
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "start", style: .plain, target: self, action: #selector(self.startRecording))

            guard let preview = preview else {
                return
            }
            
            self.present(preview, animated: true, completion: nil)
        }
    }

    func previewControllerDidFinish(_ previewController: RPPreviewViewController) {
        dismiss(animated: true)
    }
}

