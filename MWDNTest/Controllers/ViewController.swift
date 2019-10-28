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
    
    var data: ResponseModel? {
        didSet{
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.setupUI(with: self.data)
            }
        }
    }
    
    @IBAction func requestButton(_ sender: Any) {
        NetworkService.shared.request(Date().convertDateToString(), inputTextView.stringValue, completion: {
            [weak self] result in
            self?.data = result
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setupUI(with data: ResponseModel?) {
        guard let htmlString = data?.html else {return}
        webView.loadHTMLString(htmlString, baseURL: nil)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

