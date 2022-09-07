//
//  HomeViewController.swift
//  TTS
//
//  Created by 안현주 on 2022/08/30.
//

import UIKit
import Charts
import Then
import SnapKit
import RxSwift

class HomeVC: UIViewController {
    
    var months: [String]!
    var unitsSold: [Double]!
    let chartLabelSize = CGFloat(15)
    
    private var viewModel = AllTransVM()
    private var disposeBag = DisposeBag()
    
    lazy var viewChart = UIView()
    lazy var lineChartView = LineChartView().then {
//        $0.backgroundColor = .lightGray
        $0.noDataText = "데이터가 없습니다."
        $0.noDataFont = .systemFont(ofSize: 20)
        $0.noDataTextColor = .darkGray
        $0.doubleTapToZoomEnabled = false
        $0.legend.enabled = false

        $0.xAxis.labelPosition = .bottom    // X축 레이블 위치 조정
        $0.xAxis.labelFont = .boldSystemFont(ofSize: chartLabelSize)
        $0.xAxis.labelTextColor = .gray
        $0.xAxis.drawGridLinesEnabled = false
//        $0.xAxis.axisLineColor = .black
        $0.rightAxis.enabled = false        // 오른쪽 축 제거
        
        
        let yAxis = $0.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: chartLabelSize)
        yAxis.labelTextColor = .gray
        yAxis.setLabelCount(8, force: false)
        yAxis.axisLineColor = .white
        yAxis.labelPosition = .outsideChart
        yAxis.labelXOffset = -5
        
        let ll = ChartLimitLine(limit: 10.0, label: "average")
        ll.labelPosition = .leftTop
        ll.drawLabelEnabled = true
        ll.lineColor = .gray
//        ll.lineDashLengths = CGFloat(2)
        ll.lineDashPhase = CGFloat(2)
        ll.valueTextColor = .gray
        $0.leftAxis.addLimitLine(ll)
        
//        $0.animate(xAxisDuration: 2)

    }
    
    lazy var allTransactionHeader = TransactionHeader()
    lazy var allTransactionsTable = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        
        self.view.backgroundColor = .white
        self.title = "home"
        
        setView()
    }
    
    func setView() {
        
        [viewChart, allTransactionHeader, allTransactionsTable].forEach {
            view.addSubview($0)
        }
        setChartView()
        setAllTransactionsTable()
        setChart(dataPoints: months, values: unitsSold)
        setBinding()
    }
    
    func setChartView() {
        viewChart.addSubview(lineChartView)
        
        viewChart.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.height.equalTo(500)
            make.width.equalToSuperview().offset(-50)
        }
        
        lineChartView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setAllTransactionsTable() {
        
        allTransactionHeader.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10.0)
            make.top.equalTo(viewChart.snp.bottom).offset(30.0)
        }
        
        allTransactionsTable.then {
            $0.axis = .vertical
            $0.spacing = 1.0
            $0.backgroundColor = .lightGray.withAlphaComponent(0.5)
        }.snp.makeConstraints { make in
            make.left.right.equalTo(allTransactionHeader)
            make.top.equalTo(allTransactionHeader.snp.bottom)
        }
    }
    
    func setBinding() {
        let output = viewModel.transform()
        
        output.transactions.subscribe(onNext: { transactions in
            transactions.forEach { transaciton in
                self.allTransactionsTable.addArrangedSubview(TransactionCell(input: transaciton))
            }
        }).disposed(by: disposeBag)
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        // 데이터 생성
        print(dataPoints)
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            print(dataEntry)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: "판매량").then {
            $0.drawCirclesEnabled = false
            $0.colors = [.systemBlue]
            $0.lineWidth = 2
            $0.mode = .linear
            $0.fill = ColorFill(color: .systemBlue)
            $0.fillAlpha = 0.5
            $0.drawFilledEnabled = true
            $0.drawHorizontalHighlightIndicatorEnabled = false
            $0.highlightColor = .systemRed
        }
        
        // 데이터 삽입
        let chartData = LineChartData(dataSet: chartDataSet)
        chartData.setDrawValues(false)      // value 표시 유무
        
        lineChartView.data = chartData
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints) // X축 레이블 포맷 지정
        lineChartView.xAxis.setLabelCount(dataPoints.count-1, force: false)
    }
}
//
//extension HomeViewController: ChartViewDelegate {
//    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
//        print(entry)
//    }
//}
