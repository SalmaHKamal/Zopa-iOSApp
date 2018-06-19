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
    var logedUser : User?
    var backImg = UIImage(named: "back")
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChartNoData()
        logedUser = UserDAO.getInstance().getUserByID(userId: CommonMethods.getloggedInUserId())
        cars = Array((logedUser?.cars)!)
        //the entry point for the whole code
        drawDropDownList()
        self.navigationItem.setLeftBarButton(UIBarButtonItem(image: backImg, style: UIBarButtonItemStyle.done, target: self, action: #selector(backHome)), animated: true)
    }
    @objc func backHome(){
        dismiss(animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        if !statisticVM.selectCarFlag {
            carName.text = "you need to select car first"
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
        lineChartView.xAxis.valueFormatter = self
        lineChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
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
            return
        }else{
            self.statisticVM.selectCarFlag = false
            titleView?.action = { [weak self] index in
                print("selected index is : \(index)")
                self?.statisticVM.setSelectedCar(selectedCarIndex: index)
                let oilData = self?.statisticVM.getOilDatesAndPrice()
                self?.oilDates = oilData?.0
                self?.oilPrices = oilData?.1
                if (self?.oilPrices?.count) != 0{
                        self?.setChart(dataPoints: (self?.oilDates!)!, values: (self?.oilPrices!)!)
                        self?.setupOutlets()
                        self?.selectedFlag = true
                        self?.statisticVM.selectCarFlag = true
                    }
                self?.carName.text = (self?.statisticVM.selectedCar?.name)!+" Oil Statistics"

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
        dateFormatter.dateFormat = "MM-dd-yyyy"
        dateFormatter.locale = Locale.init(identifier: "en_GB")
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

