//
//  StatisticsVC.swift
//  MyCarVersionTwo
//
//  Created by Sayed Abdo on 6/13/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import Charts
import Dropdowns

class StatisticsRefuelVC: UIViewController , IAxisValueFormatter{
 
    @IBOutlet weak var avgCost: UILabel!
    @IBOutlet weak var totalCost: UILabel!
    @IBOutlet weak var avgConsumption: UILabel!
    @IBOutlet weak var carName: UILabel!
    @IBOutlet weak var lineChartView: BarChartView!
    let statisticVM = StatisticsVM.shared
    
    var refDates : [String]?
    var refPrices : [Double]?
    var refAmount : [Double]?
    
    var selectedFlag : Bool = false
    var noCarsFlag : Bool = false
    var cars = [Car]()
    var logedUser : User?
    var backImg = UIImage(named: "back")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("from statistics did load")
        setupChartNoData()
        print("after setup chart")
        logedUser = UserDAO.getInstance().getUserByID(userId: CommonMethods.getloggedInUserId())
        cars = Array((logedUser?.cars)!)
        print("after get cars")
        //the entry point for the whole code
        drawDropDownList()
        print("after dropdown")
        self.navigationItem.setLeftBarButton(UIBarButtonItem(image: backImg, style: UIBarButtonItemStyle.done, target: self, action: #selector(backHome)), animated: true)
    }
    @objc func backHome(){
        dismiss(animated: true, completion: nil)
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
        
        for i in 0...dataPoints.count - 1 {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i] , data: refDates  as AnyObject)
            dataEntries.append(dataEntry)
        }
        let barChartDataSet = BarChartDataSet(values: dataEntries, label: "Amounts")
        let barChartData = BarChartData(dataSet: barChartDataSet)
        
        lineChartView.xAxis.valueFormatter = self
        lineChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
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
            print("from draw dropdown fuel \(cars.count)")
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
                let refData = self?.statisticVM.getRefeulDatesAndPrice()
                self?.refDates = refData?.0
                self?.refPrices = refData?.1
                self?.refAmount = refData?.2
                if (self?.refPrices?.count) != 0{
                    self?.setChart(dataPoints: (self?.refDates!)!, values: (self?.refPrices!)!)
                    print("test dates \((self?.refDates!)!)")
                    self?.setupOutlets()
                    self?.selectedFlag = true
                    self?.statisticVM.selectCarFlag = true
                }
                self?.carName.text = (self?.statisticVM.selectedCar?.name)!+" Refuel Statistics"
                
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
        dateFormatter.dateFormat = "MM-dd-yyyy"
        dateFormatter.locale = Locale.init(identifier: "en_GB")
        print("date format \((refDates![0]))")
        guard let lastDate = dateFormatter.date(from: refDates![0]) else {
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


