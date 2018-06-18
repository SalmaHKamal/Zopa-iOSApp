//
//  StatisticsWashVC.swift
//  MyCarVersionTwo
//
//  Created by Sayed Abdo on 6/18/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import Charts
import UIDropDown
import Dropdowns

class StatisticsWashVC: UIViewController , IAxisValueFormatter {

    @IBOutlet weak var avgCost: UILabel!
    @IBOutlet weak var totalCost: UILabel!
    @IBOutlet weak var totalTimes: UILabel!
    @IBOutlet weak var carName: UILabel!
    @IBOutlet weak var lineChartView: BarChartView!
    
    let statisticVM = StatisticsVM.shared
    
    var washDates : [String]?
    var washPrices : [Double]?
    
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
            let washData = self.statisticVM.getRefeulDatesAndPrice()
            self.washDates = washData.0
            self.washPrices = washData.1
            self.setChart(dataPoints: (self.washDates!), values: (self.washPrices!))
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
extension StatisticsWashVC{
    
    func setupChartNoData()  {
        lineChartView.noDataText = "no Washes added"
        lineChartView.noDataTextColor = .red
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return washDates![Int(value)]
    }
    func setChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0...dataPoints.count-1 {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i] , data: washDates  as AnyObject)
            dataEntries.append(dataEntry)
        }
        let barChartDataSet = BarChartDataSet(values: dataEntries, label: "Prices")
        let barChartData = BarChartData(dataSet: barChartDataSet)
        lineChartView.xAxis.valueFormatter = self
        lineChartView.data = barChartData
    }
}

// Mark: - DropDown methods
extension StatisticsWashVC{
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
                let washData = self?.statisticVM.getRefeulDatesAndPrice()
                self?.washDates = washData?.0
                self?.washPrices = washData?.1
                self?.setChart(dataPoints: (self?.washDates!)!, values: (self?.washPrices!)!)
                self?.setupOutlets()
                self?.selectedFlag = true
                self?.statisticVM.selectCarFlag = true
            }
        }
        navigationItem.titleView = titleView
    }
}


// Mark: - calculations methods
extension StatisticsWashVC{
    
    func calcTotalCost()-> Double{
        var totalCost : Double = 0.0
        for pr in washPrices! {
            totalCost += pr
        }
        return totalCost
    }
    func calcTotalTimes()-> Int{
        return (washPrices?.count)!
    }
    
    func calcDateDiff()-> Double{
        let dateFormatter = DateFormatter()
        let currentDate = Date()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let lastDate = dateFormatter.date(from: (washDates?[0])!) else {
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

extension StatisticsWashVC{
    
}
