//
//  StatisticsVC.swift
//  MyCarVersionTwo
//
//  Created by Sayed Abdo on 6/13/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import Charts

class StatisticsVC: UIViewController , IAxisValueFormatter{
 
    @IBOutlet weak var avgCost: UILabel!
    @IBOutlet weak var totalCost: UILabel!
    @IBOutlet weak var avgConsumption: UILabel!
    @IBOutlet weak var carName: UILabel!
    @IBOutlet weak var lineChartView: BarChartView!
//    @IBOutlet weak var pieChartView: PieChartView!
    let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
    let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setChart(dataPoints: months, values: unitsSold)
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return months[Int(value)]
    }
    
    
    func setChart(dataPoints: [String], values: [Double]) {
            var dataEntries: [BarChartDataEntry] = []
            
                    for i in 0...dataPoints.count-1 {
                        let dataEntry = BarChartDataEntry(x: Double(i), y: values[i] , data: months  as AnyObject)
                        dataEntries.append(dataEntry)
                    }
            let barChartDataSet = BarChartDataSet(values: dataEntries, label: "Units Sold")
            let barChartData = BarChartData(dataSet: barChartDataSet)
//            lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
            lineChartView.xAxis.valueFormatter = self
            lineChartView.data = barChartData
        }
}

extension StatisticsVC{
   
    
//
//    func setChart(dataPoints: [String], values: [Double]) {
//
//        var dataEntries: [PieChartDataEntry] = []
//
//        for i in 0..<dataPoints.count {
//            let dataEntry = PieChartDataEntry(value: 0)
//
//             = values[i]
//            dataEntrydataEntry.value.label = dataPoints[i]
//            dataEntries.append(dataEntry)
//        }
//        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Units Sold")
//        let pieChartData = PieChartData(dataSet: pieChartDataSet)
//        pieChartView.data = pieChartData
//
//        var colors: [UIColor] = []
//        for i in 0..<dataPoints.count {
//            let red = Double(arc4random_uniform(256))
//            let green = Double(arc4random_uniform(256))
//            let blue = Double(arc4random_uniform(256))
//            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
//            colors.append(color)
//        }
//        pieChartDataSet.colors = colors
//        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "Units Sold")
//        //        let lineChartData = LineChartData(xVals: dataPoints, dataSet: lineChartDataSet)
//        let lineChartData = LineChartData(dataSet: lineChartDataSet)
//        lineChartView.data = lineChartData
//
//    }
    
    
}

