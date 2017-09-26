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
    
    private let fmgr = FileManager.default
    
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
    
    //Session dataTask
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
    
    // Session downloadTask
    @IBAction func doTest5(_ sender: Any) {
        let url = URL(string: "http://www.iii.org.tw")
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.downloadTask(with: url!) {
            (url2, response, error) in
            print("----------")
            print(url2!)
            do{
                let cont = try String(contentsOf: url2!)
                print("----------")
                print(cont)
            }catch{
                
            }
            
            
        }
        task.resume()
        
    }
    
    @IBAction func doTest6(_ sender: Any) {
        let url = URL(string: "http://data.coa.gov.tw/Service/OpenData/ODwsv/ODwsvAttractions.aspx")
        
        do{
            let data = try Data(contentsOf: url!)
//            let cont = String(data: data, encoding: String.Encoding.utf8)
//            print(cont!)
            
            if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments){
                // json is-a Any
                // json as! [[String:String]] => because Data Source
                for row in json as! [[String:String]] {
                    // row => [String:String]
                    print("\(row["Name"]!) : \(row["Tel"]!)")
                }
            }
        }catch{
            
        }
    }
    
    
    @IBAction func doTest7(_ sender: Any) {
        let url = URL(string: "http://pdfmyurl.com/?url=http://www.gamer.com.tw")   // return URL?
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // 以下為一個任務
        let task = session.downloadTask(with: url!) {
            (url, response, error) in
            guard error == nil else{return}
            
            do{
                let targetURL = URL(fileURLWithPath: NSHomeDirectory() + "/Documents/brad.pdf")
                try self.fmgr.copyItem(at: url!, to: targetURL)
                print("download success")
            }catch{
                print("copy failure")
            }
                
        }
        task.resume()
        
        
        
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(NSHomeDirectory())
    }

}

