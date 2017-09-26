//
//  ViewController.swift
//  MyApp15
//
//  Created by user22 on 2017/9/26.
//  Copyright © 2017年 Brad Big Company. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var q1 = DispatchQueue(label: "tw.org.iii.queue.q1", qos: DispatchQoS.background, attributes: DispatchQueue.Attributes.concurrent)
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBAction func doTest1(_ sender: Any) {
        let url = URL(string: "http://www.iii.org.tw")
        do {
            let content = try String(contentsOf: url!)
            print(content)
            
            //label.text = String
        }catch{
            
        }
    }
    
    @IBAction func doTest2(_ sender: Any) {
        let url = URL(string: "http://i2.cdn.cnn.com/cnnnext/dam/assets/170908160636-nk-icbm-5-large-tease.jpg")
        do{
            let data = try Data(contentsOf: url!)
            let img = UIImage(data: data)
            imgView.image = img
            print("OK")
        }catch{
            print("XX")
        }
        
    }
    
    @IBAction func doTest3(_ sender: Any) {
        q1.async {
            self.test3()
        }
    }
    
    private func test3(){
        let url = URL(string: "http://htmlcolorcodes.com/assets/images/html-color-codes-color-tutorials-hero-00e10b1f.jpg")
        do{
            let data = try Data(contentsOf: url!)
            let img = UIImage(data: data)
            
            DispatchQueue.main.async {
                self.imgView.image = img
            }
            
            print("OK")
        }catch{
            print("XX")
        }
    }
    
    @IBAction func doTest4(_ sender: Any) {
        let url = URL(string: "http://www.pchome.com.tw")
        
//        let config = URLSessionConfiguration.default    // 存 Cache
        let config = URLSessionConfiguration.ephemeral  // 不存 Cache

        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url!) {
            (data, response, error) in
            
            guard error == nil else {return}
            
            if let cont = String(data: data!, encoding: String.Encoding.utf8){
                print(cont)
            }
        }
        task.resume()
        
    }
    
    @IBAction func doTest5(_ sender: Any) {
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(NSHomeDirectory())
    }

}

