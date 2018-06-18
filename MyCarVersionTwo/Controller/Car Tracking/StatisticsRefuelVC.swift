//
//  StatisticsVC.swift
//  MyCarVersionTwo
//
//  Created by Sayed Abdo on 6/13/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import Charts
import UIDropDown
import Dropdowns

class StatisticsRefuelVC: UIViewController , IAxisValueFormatter{
 
    @IBOutlet weak var avgCost: UILabel!
    @IBOutlet weak var totalCost: UILabel!
    @IBOutlet weak var avgConsumption: UILabel!
    @IBOutlet weak var carName: UILabel!
    @IBOutlet weak var lineChartView: BarChartView!
//    @IBOutlet weak var pieChartView: PieChartView!
//    let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
//    let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0]
    let statisticVM = StatisticsVM.shared
    
    var refDates : [String]?
    var refPrices : [Double]?
    var refAmount : [Double]?
    
    var selectedFlag : Bool = false
    var noCarsFlag : Bool = false
    var cars = [Car]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("from statistics did load")
        setupChartNoData()
        print("after setup chart")
        cars = CommonMethods.getAllCarsForUser()
        print("after get cars")
        //the entry point for the whole code
        drawDropDownList()
        print("after dropdown")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if !statisticVM.selectCarFlag {
            carName.text = "you need to select car first"
        }else{
            let refData = self.statisticVM.getRefeulDatesAndPrice()
            self.refDates = refData.0
            self.refPrices = refData.1
            self.refAmount = refData.2
            self.setChart(dataPoints: self.refDates!, values: (self.refAmount!))
            self.setupOutlets()
        }
    }
    func setupOutlets()  {
        self.avgConsumption.text = String(calcAVGConsumption())
        self.totalCost.text = String(calcTotalCost())
        self.avgCost.text = String(calcAVGCost())
        self.carName.text = statisticVM.selectedCar?.name
    }
}

// Mark: - Chart methods
extension StatisticsRefuelVC{
    
    func setupChartNoData()  {
        lineChartView.noDataText = "no refuels  added"
        lineChartView.noDataTextColor = .red
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return refDates![Int(value)]
    }
    func setChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0...dataPoints.count-1 {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i] , data: refDates  as AnyObject)
            dataEntries.append(dataEntry)
        }
        let barChartDataSet = BarChartDataSet(values: dataEntries, label: "Amounts")
        let barChartData = BarChartData(dataSet: barChartDataSet)
        //            lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        lineChartView.xAxis.valueFormatter = self
        lineChartView.data = barChartData
    }
}

// Mark: - DropDown methods
extension StatisticsRefuelVC{
    func drawDropDownList(){
        var items : [String] = [String]()
        if cars.count != 0 {
            for i in cars {
                items.append(i.name)
            }
        }
        else {
            items.append("")
            noCarsFlag = true
        }
        
        let titleView = TitleView(navigationController: navigationController!, title: "choose car", items: items)
        if noCarsFlag {
            self.title = "add cars first"
        }else{
            titleView?.action = { [weak self] index in
                print("selected index is : \(index)")
                self?.statisticVM.setSelectedCar(selectedCarIndex: index)
                let refData = self?.statisticVM.getRefeulDatesAndPrice()
                self?.refDates = refData?.0
                self?.refPrices = refData?.1
                self?.refAmount = refData?.2
                self?.setChart(dataPoints: (self?.refDates!)!, values: (self?.refPrices!)!)
                self?.setupOutlets()
                self?.selectedFlag = true
                self?.statisticVM.selectCarFlag = true
            }
        }
        navigationItem.titleView = titleView
    }
    
    
}


// Mark: - calculations methods
extension StatisticsRefuelVC{
    
    func calcTotalCost()-> Double{
        var totalCost : Double = 0.0
        for pr in refPrices! {
            totalCost += pr
        }
        return totalCost
    }
    func calcTotalConsumption()-> Double{
        var totalAmount : Double = 0.0
        for am in refAmount! {
            totalAmount += am
        }
        return totalAmount
    }
    
    func calcDateDiff()-> Double{
        let dateFormatter = DateFormatter()
        let currentDate = Date()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let lastDate = dateFormatter.date(from: (refDates?[0])!) else {
            fatalError("ERROR: Date conversion failed due to mismatched format.")
        }
        let diff = currentDate.interval(ofComponent: .day, fromDate: lastDate)
        print("date difference is \(diff)")
        return diff
    }
    
    func calcAVGConsumption() -> Double {
        return calcTotalConsumption()/calcDateDiff()
    }
    func calcAVGCost() -> Double {
        return calcTotalCost()/calcDateDiff()
    }
   
}

extension StatisticsRefuelVC{
   
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

