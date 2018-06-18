//
//  StatisticsOilVC.swift
//  MyCarVersionTwo
//
//  Created by Sayed Abdo on 6/18/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import Charts
import UIDropDown
import Dropdowns

class StatisticsOilVC: UIViewController , IAxisValueFormatter {

    @IBOutlet weak var avgCost: UILabel!
    @IBOutlet weak var totalCost: UILabel!
    @IBOutlet weak var totalTimes: UILabel!
    @IBOutlet weak var carName: UILabel!
    @IBOutlet weak var lineChartView: BarChartView!
    let statisticVM = StatisticsVM.shared
    
    var oilDates : [String]?
    var oilPrices : [Double]?
    
    var selectedFlag : Bool = false
    var noCarsFlag : Bool = false
    var cars = [Car]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("from OIL statistics did load")
        setupChartNoData()
        print("after OIL setup chart")
        cars = CommonMethods.getAllCarsForUser()
        print("after OIL get cars")
        //the entry point for the whole code
        drawDropDownList()
        print("after OIL dropdown")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if !statisticVM.selectCarFlag {
            carName.text = "you need to select car first"
        }else{
            let oilData = self.statisticVM.getOilDatesAndPrice()
            self.oilDates = oilData.0
            self.oilPrices = oilData.1
            self.setChart(dataPoints: (self.oilDates!), values: (self.oilPrices!))
            self.setupOutlets()
        }
        
    }
    func setupOutlets()  {
        self.totalTimes.text = String(calcTotalTimes())
        self.totalCost.text = String(calcTotalCost())
        self.avgCost.text = String(calcAVGCost())
        self.carName.text = statisticVM.selectedCar?.name
    }
}

// Mark: - Chart methods
extension StatisticsOilVC{
    
    func setupChartNoData()  {
        lineChartView.noDataText = "no Oil added"
        lineChartView.noDataTextColor = .red
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return oilDates![Int(value)]
    }
    func setChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0...dataPoints.count-1 {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i] , data: oilDates  as AnyObject)
            dataEntries.append(dataEntry)
        }
        let barChartDataSet = BarChartDataSet(values: dataEntries, label: "Prices")
        let barChartData = BarChartData(dataSet: barChartDataSet)
        //            lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        lineChartView.xAxis.valueFormatter = self
        lineChartView.data = barChartData
    }
}

// Mark: - DropDown methods
extension StatisticsOilVC{
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
                let oilData = self?.statisticVM.getRefeulDatesAndPrice()
                self?.oilDates = oilData?.0
                self?.oilPrices = oilData?.1
                self?.setChart(dataPoints: (self?.oilDates!)!, values: (self?.oilPrices!)!)
                self?.setupOutlets()
                self?.selectedFlag = true
                self?.statisticVM.selectCarFlag = true
            }
        }
        navigationItem.titleView = titleView
    }
    
    
}


// Mark: - calculations methods
extension StatisticsOilVC{
    
    func calcTotalCost()-> Double{
        var totalCost : Double = 0.0
        for pr in oilPrices! {
            totalCost += pr
        }
        return totalCost
    }
    func calcTotalTimes()-> Int{
        return (oilDates?.count)!
    }
    
    func calcDateDiff()-> Double{
        let dateFormatter = DateFormatter()
        let currentDate = Date()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let lastDate = dateFormatter.date(from: (oilDates?[0])!) else {
            fatalError("ERROR: Date conversion failed due to mismatched format.")
        }
        let diff = currentDate.interval(ofComponent: .day, fromDate: lastDate)
        print("date difference is \(diff)")
        return diff
    }
    func calcAVGCost() -> Double {
        return calcTotalCost()/calcDateDiff()
    }
    
}

extension StatisticsOilVC {
    
}
