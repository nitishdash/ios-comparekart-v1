//
//  ViewController.swift
//  CompareKart-v1
//
//  Created by Nitish Dash on 16/04/17.
//  Copyright © 2017 Nitish Dash. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import Charts


class ViewController: UIViewController , ChartViewDelegate {
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var lowestPriceLabel: UILabel!
    @IBOutlet weak var trackingSinceLabel: UILabel!

    @IBOutlet weak var lowestPriceOnLabel: UILabel!
    @IBOutlet weak var currentPriceLabel: UILabel!
    @IBOutlet weak var lineChartView: LineChartView!
    
    let months = ["Jan" , "Feb", "Mar", "Apr", "May", "June", "July", "August", "Sept", "Oct", "Nov", "Dec"]
    
    let dollars1 = [1453.0,2352,5431,1442,5451,6486,1173,5678,9234,1345,9411,2212]
    
    var priceData = [0.00]
    
    var datesData = [""]
    
    var lowestPrice = 0.00
    var lowestPriceOn = ""
 
    var currentPrice = 0.00
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
//        http://localhost/laravel/blog/public/api/product?pid=MOBEQHMGED7F9CZ2        
        
        self.priceData.removeAll()
        
        self.datesData.removeAll()
        
        
        Alamofire.request("http://192.168.83.1/laravel/blog/public/api/product?pid=MOBEQHMGED7F9CZ2").responseJSON { response in
            
            if let value = response.result.value {
                let json = JSON(value)
                
                print(json)
                
                 let count: Int? = json["trackingDetails"].array?.count   //check for the maximum count in json array
                
                var min = 0.00  //trash variable for checking minimum price

                
                for index in 0...count!-1 {
                    
                    if index == 0 {
                        min = json["trackingDetails"][0]["price"].doubleValue
                    }
                    
                    //determining lowest price of product :P No ALGO!
                    if min>json["trackingDetails"][index]["price"].doubleValue {
                        min=json["trackingDetails"][index]["price"].doubleValue
                        
                        self.lowestPriceOn = json["trackingDetails"][index]["date"].stringValue
                    }
                    
                    self.priceData.append(json["trackingDetails"][index]["price"].doubleValue)
                    
                    self.datesData.append(json["trackingDetails"][index]["Name"].stringValue)
                    
                }
                
                //set the product name
                self.productNameLabel.text=json["productDetails"][0]["title"].stringValue
                
                
                
                
                let str=json["productDetails"][0]["dateOfAddition"].stringValue
                
                
                let index = str.index(str.startIndex, offsetBy: 10)
                
                
                
                
                self.trackingSinceLabel.text=str.substring(to: index)
                
                
                
                let index2 = self.lowestPriceOn.index(str.startIndex, offsetBy: 10)
                
                
                self.lowestPriceOnLabel.text = "on: "+self.lowestPriceOn.substring(to: index2)
                
                
                self.currentPrice = json["trackingDetails"][0]["mrp"].doubleValue
                self.lowestPrice = min
                
                self.currentPriceLabel.text = String(self.currentPrice)
                
                
                self.lowestPriceLabel.text = String(self.lowestPrice)
                
                // 1
                self.lineChartView.delegate = self
                // 2
                self.lineChartView.chartDescription?.text = "Tap node for details"
                // 3
                self.lineChartView.chartDescription?.textColor = UIColor.black
                self.lineChartView.gridBackgroundColor = UIColor.clear
                // 4
                self.lineChartView.noDataText = "No data provided"
                // 5
                self.setChartData(months: self.datesData)
                
                
                
                

            }
        }
        
        
        
        

        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setChartData(months : [String]) {
        
        // 1 - creating an array of data entries
        var yVals1 : [ChartDataEntry] = [ChartDataEntry]()
        
        for i in 0..<datesData.count {
            yVals1.append(ChartDataEntry(x: Double(i), y: priceData[i]))
        }
        
        // 2 - create a data set with our array
        let set1: LineChartDataSet = LineChartDataSet(values: yVals1, label: "First Set")
        
        //            let set2: LineChartDataSet = LineChartDataSet(values: yVals2, label: "Second Set")
        
        set1.axisDependency = .left // Line will correlate with left axis values
        set1.setColor(UIColor.red.withAlphaComponent(0.5)) // our line's opacity is 50%
        set1.setCircleColor(UIColor.red) // our circle will be dark red
        set1.lineWidth = 2.0
        set1.circleRadius = 6.0 // the radius of the node circle
        set1.fillAlpha = 65 / 255.0
        set1.fillColor = UIColor.red
        set1.highlightColor = UIColor.gray
        set1.drawCircleHoleEnabled = true
        
        //3 - create an array to store our LineChartDataSets
        var dataSets : [LineChartDataSet] = [LineChartDataSet]()
        dataSets.append(set1)
        
        //4 - pass our months in for our x-axis label value along with our dataSets
        let data: LineChartData = LineChartData(dataSets: dataSets)
        data.setValueTextColor(UIColor.blue)
        
        //5 - finally set our data
        self.lineChartView.data = data
        
        //6 - add x-axis label
        let xaxis = self.lineChartView.xAxis
        xaxis.valueFormatter = MyXAxisFormatter(months)
        
    }



}


class MyXAxisFormatter: NSObject, IAxisValueFormatter {
    
    let months: [String]
    
    init(_ months: [String]) {
        self.months = months
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return months[Int(value)]
}
}
//    class MyXAxisFormatter: NSObject, IAxisValueFormatter {
//        
//        let dates: [String]
//        
//        init(_ dates: [String]) {
//            self.dates = dates
//        }
//        
//        func stringForValue(_ value: Double, axis: AxisBase?) -> String {
//            return dates[Int(value)]
//        }
//    
//    
//}
