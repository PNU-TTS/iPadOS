//
//  SellVC.swift
//  TTS
//
//  Created by Yujin Cha on 2022/09/04.
//

import UIKit

import Charts
import Then
import SnapKit


extension SellVC {
    static let horizontalInset: CGFloat = 20.0
    static let verticalOffset: CGFloat = 20.0
}

class SellVC: UIViewController {
    struct Input {
        var recBalance: Int
    }
    
    var input: Input
    
    var months: [String]!
    var unitsSold: [Double]!
    let chartLabelSize = CGFloat(15)
    
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
    
    var stackView = UIStackView()
    var averagePriceView: PriceView
    var maxPriceView: PriceView
    var minPriceView: PriceView
    var sellInputView: SellInputView
    
    init(input: Input) {
        self.input = input
        averagePriceView = PriceView(
            input: PriceView.Input(icon: UIImage(systemName: "wonsign.circle.fill"),
                                   amount: 50000,
                                   description: "평균가"))
        maxPriceView = PriceView(
            input: PriceView.Input(icon: UIImage(systemName: "arrow.up.forward.circle.fill"),
                                   amount: 80000,
                                   description: "최고가"))
        minPriceView = PriceView(
            input: PriceView.Input(icon: UIImage(systemName: "arrow.down.right.circle.fill"),
                                   amount: 20000,
                                   description: "최저가"))
        sellInputView = SellInputView(input: SellInputView.Input(recBalance: input.recBalance))
        
        super.init(nibName: nil, bundle: nil)
        setView()
        title = "판매 등록"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SellVC {
    func setView() {
        view.backgroundColor = .white
        
        view.addSubview(stackView)
        view.addSubview(sellInputView)
        
        setStackView()
        setSellInputView()
    }
    
    func setStackView() {
        stackView.addArrangedSubview(averagePriceView)
        stackView.addArrangedSubview(maxPriceView)
        stackView.addArrangedSubview(minPriceView)
        
        stackView.then {
            $0.axis = .vertical
            $0.distribution = .equalSpacing
            $0.alignment = .center
        }.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20.0)
            make.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.5)
            make.width.equalToSuperview().multipliedBy(0.4).inset(10.0)
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        stackView.arrangedSubviews.forEach { priceView in
            priceView.snp.makeConstraints { make in
                make.height.equalToSuperview().multipliedBy(0.3)
                make.width.equalToSuperview().inset(20)
            }
        }
    }
    
    func setSellInputView() {
        sellInputView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.right.equalToSuperview().inset(20.0)
            make.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.5)
            make.width.equalToSuperview().multipliedBy(0.6).inset(10.0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "home"
        
        view.addSubview(viewChart)
        viewChart.addSubview(lineChartView)
        
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        
        
        viewChart.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(20)
            make.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.5)
            make.width.equalToSuperview().offset(-50)
        }
        
        lineChartView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        setChart(dataPoints: months, values: unitsSold)
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

