//
//  ViewController.swift
//  Whats The Weather
//
//  Created by Abhishek Attri on 29/04/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var weatherReport: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func submit(_ sender: Any) {
        
        if let url = URL(string: "https://www.weather-forecast.com/locations/" + textField.text! + "/forecasts/latest") {
        
        let request = NSMutableURLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            Data, response, Error in
            
            var message = ""
            
            if Error != nil {
                print(Error as Any)
            } else {
                if let unwrappedData = Data {
                    let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                    
                   var stringSeparator = "<p class=\"b-forecast__table-description-content\"><span class=\"phrase\">"
                    
                    if let contentArray = dataString?.components(separatedBy: stringSeparator) {
                        
                        if contentArray.count > 1 {
                            stringSeparator = "</span>"
                            
                             let newContentArray = contentArray[1].components(separatedBy: stringSeparator)
                            
                                if newContentArray.count > 1 {
                                    
                                    message = newContentArray[0].replacingOccurrences(of: "&deg;", with: "°")
                                    print(message)
                                }
                            
                        }
                    }
                }
                
            }
            if message == "" {
                message = "The weather couldn't be found. Please try again."
            }
            DispatchQueue.main.sync(execute: {
                self.weatherReport.text = message
            })
        }
        task.resume()
        } else {
            weatherReport.text = "The weather couldn't be found, Please try again"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }


}

