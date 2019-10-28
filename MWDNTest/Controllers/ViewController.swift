//
//  ViewController.swift
//  MWDNTest
//
//  Created by Богдан Воробйовський on 27.10.2019.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Cocoa
import WebKit

class ViewController: NSViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var inputTextView: NSTextField!
    
    var timeInterval: TimeInterval?
    
    var data: ResponseModel? {
        didSet{
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.setupUI(with: self.data)
            }
            DispatchQueue.global(qos: .utility).async { [weak self] in
                guard let self = self else { return }
                self.runShell(for: self.data)
                self.saveToTemp()
            }
            
        }
    }
    
    @IBAction func requestButton(_ sender: Any) {
        NetworkService.shared.request(Date().convertDateToString(), inputTextView.stringValue, completion: {
            [weak self] result in
            self?.data = result
            }, timeIntervalCompletion: {
                [weak self] result in
                self?.timeInterval = result
                print(result)
        })
    }
    
    
    private func setupUI(with data: ResponseModel?) {
        guard let htmlString = data?.html else {return}
        webView.loadHTMLString(htmlString, baseURL: nil)
    }
    
    private func runShell(for data: ResponseModel?){
        guard let arguments = data?.sh else {return}
        let task = Process()
        task.launchPath = "/bin/bash"
        task.arguments = ["-c", arguments]
        task.launch()
    }
    
    private func saveToTemp() {
        guard let num = data?.num, let ans = data?.ans, let timeDelta = timeInterval else {return}
        if timeDelta > Double(num) {
            print("Time interval \(timeDelta) > \(Double(num)) ")
            DispatchQueue.global(qos: .utility).async {
                StorageService.shared.writeData(data: ans)
            }
        }
        else {
            print("false \(timeDelta) < \(Double(num))")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

