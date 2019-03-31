//
//  ViewController.swift
//  BitcoinPriceTracker
//
//  Created by ADG RIT 18 on 31/03/19.
//  Copyright © 2019 ADG RIT 18. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var segmentOutlet: UISegmentedControl!
    @IBOutlet weak var Label: UILabel!
    struct Prices: Decodable {
        let bpi: [String: Bpi]
    }
    
    struct Bpi: Decodable {
        let code: String?
        let rate_float: Double?
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getPrice()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func segmentControl(_ sender: Any) {
    }
    @IBAction func Price(_ sender: Any) {
        getPrice()
    }
    func getPrice() {
        let url = URL(string: "https://api.coindesk.com/v1/bpi/currentprice/INR.json")
        URLSession.shared.dataTask(with: url!) { (data,response,error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            if let data = data {
                let price = try? JSONDecoder().decode(Prices.self, from: data)
                let bpi = price?.bpi
                _ = bpi!["USD"]!.code
                let rateUSD = bpi!["USD"]!.rate_float!
                let rateINR = bpi!["INR"]!.rate_float!
                                DispatchQueue.main.async {
                                    if self.segmentOutlet.selectedSegmentIndex == 0 {
                        self.Label.text = "\(rateUSD)"
                    }
                    else {
                        self.Label.text = "\(rateINR)"

                    }
                                    }
            }
    }

        .resume()
}

}
