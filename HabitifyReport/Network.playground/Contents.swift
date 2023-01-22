import UIKit
import PlaygroundSupport
import Charts

//
//PlaygroundPage.current.needsIndefiniteExecution = true
//
//
//let headers = ["Authorization": "ecd31dc107e5473d06dd8d2f1142993e0963c22ea25e26e8de8e7764c8f1b462"]
//
//let dateFormatter = DateFormatter()
//dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
//
//let now = Date()
//print(dateFormatter.string(from: now))
//
//let url = URL(string: "https://api.habitify.me/logs/:")!
//var request = URLRequest(url: url)
//request.allHTTPHeaderFields = headers
//request.cachePolicy = .useProtocolCachePolicy
//
//let task = URLSession.shared.dataTask(with: request) { data, response, error in
//
//  guard let data = data, error == nil else { return }
//
//  print(String(data: data, encoding: .utf8) ?? "Unable to decode to string")
//}
//
//task.resume()
//
//func customSort<T:Comparable>(x: T, y: T) -> Bool {
//    return x < y
//}
//var foo = ["blah", "zoo"]
//foo.sorted(by: customSort)

//
//
//class Foo {
//    var bar: String = "cars"
//}
//
//var thing = Foo()
//
//let closure = { [thing] in
//    print("I love \(thing.bar)")
//}
//
//thing.bar = "airplanes"
//
//closure()

/*


let s="""
{"errors":[],"message":"Success","data":[{"id":"-NKEyQJkiSoPHuP2ZmZU","value":35,"created_date":"2022-12-26T19:47:20.000Z","unit_type":"min","habit_id":"2B6B164F-121E-47AC-B574-F861324F5591"},{"id":"-NKFELo-OieAU8vdHno_","value":30,"created_date":"2022-12-26T20:10:10.877Z","unit_type":"min","habit_id":"2B6B164F-121E-47AC-B574-F861324F5591"},{"id":"-NKFHyowOqAZ4KfDnT5E","value":15,"created_date":"2022-12-26T21:02:01.760Z","unit_type":"min","habit_id":"2B6B164F-121E-47AC-B574-F861324F5591"},{"id":"-NKG0TtYx52YQjqY6SOk","value":30,"created_date":"2022-12-27T00:05:54.712Z","unit_type":"min","habit_id":"2B6B164F-121E-47AC-B574-F861324F5591"},{"id":"-NKG0acwy99oAXkclKG6","value":30,"created_date":"2022-12-27T00:40:49.000Z","unit_type":"min","habit_id":"2B6B164F-121E-47AC-B574-F861324F5591"},{"id":"-NKGWdLi1ndjyg9qhGjB","value":30,"created_date":"2022-12-27T02:30:43.780Z","unit_type":"min","habit_id":"2B6B164F-121E-47AC-B574-F861324F5591"},{"id":"-NKGfU746jWeFaqO4vrU","value":30,"created_date":"2022-12-27T03:06:41.817Z","unit_type":"min","habit_id":"2B6B164F-121E-47AC-B574-F861324F5591"},{"id":"-NKMpsT9UaN2AsLd381r","value":60,"created_date":"2022-12-27T08:26:54.000Z","unit_type":"min","habit_id":"2B6B164F-121E-47AC-B574-F861324F5591"},{"id":"-NKKeYmfRfr5XkP13nUm","value":15,"created_date":"2022-12-27T22:18:15.000Z","unit_type":"min","habit_id":"2B6B164F-121E-47AC-B574-F861324F5591"},{"id":"-NKKlVT1Vw7jxTCiY8qB","value":30,"created_date":"2022-12-27T22:18:36.441Z","unit_type":"min","habit_id":"2B6B164F-121E-47AC-B574-F861324F5591"},{"id":"-NKO0vGsPyeYVYzZ9N2V","value":30,"created_date":"2022-12-28T13:59:11.000Z","unit_type":"min","habit_id":"2B6B164F-121E-47AC-B574-F861324F5591"},{"id":"-NKO_hGs-icaMA4oF8iY","value":30,"created_date":"2022-12-28T16:35:31.000Z","unit_type":"min","habit_id":"2B6B164F-121E-47AC-B574-F861324F5591"},{"id":"-NKOpYZG5VZsZlV1Rlfi","value":10,"created_date":"2022-12-28T17:44:46.000Z","unit_type":"min","habit_id":"2B6B164F-121E-47AC-B574-F861324F5591"},{"id":"-NKOwTMZWBlFEU2ZQNTz","value":30,"created_date":"2022-12-28T17:44:57.932Z","unit_type":"min","habit_id":"2B6B164F-121E-47AC-B574-F861324F5591"},{"id":"-NKP9hzdD30tSkkRxI9e","value":30,"created_date":"2022-12-28T19:17:14.000Z","unit_type":"min","habit_id":"2B6B164F-121E-47AC-B574-F861324F5591"},{"id":"-NKPqOuVf78YGVqV397l","value":10,"created_date":"2022-12-28T22:28:07.000Z","unit_type":"min","habit_id":"2B6B164F-121E-47AC-B574-F861324F5591"},{"id":"-NKPza_e8KYVth5nMvg8","value":30,"created_date":"2022-12-28T22:38:15.311Z","unit_type":"min","habit_id":"2B6B164F-121E-47AC-B574-F861324F5591"},{"id":"-NKVFQsLlxNPGwAQxDtG","value":10,"created_date":"2022-12-28T23:39:56.000Z","unit_type":"min","habit_id":"2B6B164F-121E-47AC-B574-F861324F5591"},{"id":"-NKVJnrtXl-5lMte3dwM","value":15,"created_date":"2022-12-28T23:59:03.000Z","unit_type":"min","habit_id":"2B6B164F-121E-47AC-B574-F861324F5591"},{"id":"-NKVRQeOYzNyWUSAgwAR","value":15,"created_date":"2022-12-29T00:32:20.000Z","unit_type":"min","habit_id":"2B6B164F-121E-47AC-B574-F861324F5591"},{"id":"-NKVWhzvudXcWLsgtxWo","value":10,"created_date":"2022-12-29T00:55:26.000Z","unit_type":"min","habit_id":"2B6B164F-121E-47AC-B574-F861324F5591"},{"id":"-NKRLgEX6bofNTwrw5NC","value":30,"created_date":"2022-12-29T05:28:47.120Z","unit_type":"min","habit_id":"2B6B164F-121E-47AC-B574-F861324F5591"},{"id":"-NKWpaBp8mSRwJXskyJ8","value":60,"created_date":"2022-12-29T07:01:55.000Z","unit_type":"min","habit_id":"2B6B164F-121E-47AC-B574-F861324F5591"},{"id":"-NKX2Zk6jonrSUhg1qzp","value":45,"created_date":"2022-12-29T08:02:57.000Z","unit_type":"min","habit_id":"2B6B164F-121E-47AC-B574-F861324F5591"},{"id":"-NKWVcu8RpdHteiUgdqu","value":90,"created_date":"2022-12-30T05:30:22.259Z","unit_type":"min","habit_id":"2B6B164F-121E-47AC-B574-F861324F5591"},{"id":"-NKXMm9jESnj5d5BNesl","value":30,"created_date":"2022-12-30T09:31:15.000Z","unit_type":"min","habit_id":"2B6B164F-121E-47AC-B574-F861324F5591"},{"id":"-NK_UuhosVkP9zp8jQ4R","value":60,"created_date":"2022-12-31T00:05:19.000Z","unit_type":"min","habit_id":"2B6B164F-121E-47AC-B574-F861324F5591"},{"id":"-NKa4MiuyXRJi7b36Lnd","value":35,"created_date":"2022-12-31T02:49:19.000Z","unit_type":"min","habit_id":"2B6B164F-121E-47AC-B574-F861324F5591"},{"id":"-NKbT6RoyUoZi174J4eI","value":90,"created_date":"2022-12-31T09:17:00.000Z","unit_type":"min","habit_id":"2B6B164F-121E-47AC-B574-F861324F5591"},{"id":"-NKvQ1BDRJcHwUT-FH1U","value":540,"created_date":"2023-01-04T06:15:50.000Z","unit_type":"min","habit_id":"2B6B164F-121E-47AC-B574-F861324F5591"},{"id":"-NKzO-tEHpuvdg_Or2XO","value":30,"created_date":"2023-01-04T23:59:05.943Z","unit_type":"min","habit_id":"2B6B164F-121E-47AC-B574-F861324F5591"},{"id":"-NL2p7rXmqtikF8RPfWQ","value":60,"created_date":"2023-01-05T21:27:00.000Z","unit_type":"min","habit_id":"2B6B164F-121E-47AC-B574-F861324F5591"},{"id":"-NL3dEIlQCgp3W2slu9t","value":120,"created_date":"2023-01-06T01:14:37.790Z","unit_type":"min","habit_id":"2B6B164F-121E-47AC-B574-F861324F5591"},{"id":"-NL4dCXKfz7ziHMCwmM3","value":120,"created_date":"2023-01-06T05:54:07.000Z","unit_type":"min","habit_id":"2B6B164F-121E-47AC-B574-F861324F5591"},{"id":"-NL5LWPsAwRpFhb_wMqk","value":120,"created_date":"2023-01-06T09:12:04.000Z","unit_type":"min","habit_id":"2B6B164F-121E-47AC-B574-F861324F5591"},{"id":"-NL7p9ss-YLQanEcWT31","value":240,"created_date":"2023-01-06T20:45:13.012Z","unit_type":"min","habit_id":"2B6B164F-121E-47AC-B574-F861324F5591"},{"id":"-NLJUw8V8QVjmAQgfjSd","value":480,"created_date":"2023-01-08T03:07:50.000Z","unit_type":"min","habit_id":"2B6B164F-121E-47AC-B574-F861324F5591"},{"id":"-NLKhKVxMPZeOOVja7Cz","value":180,"created_date":"2023-01-08T08:46:04.000Z","unit_type":"min","habit_id":"2B6B164F-121E-47AC-B574-F861324F5591"},{"id":"-NLJV4IW03x-tsTE8iSG","value":480,"created_date":"2023-01-09T03:08:33.000Z","unit_type":"min","habit_id":"2B6B164F-121E-47AC-B574-F861324F5591"},{"id":"-NLPsnbnmfHNv040VScn","value":600,"created_date":"2023-01-09T08:54:14.000Z","unit_type":"min","habit_id":"2B6B164F-121E-47AC-B574-F861324F5591"},{"id":"-NLUtK_vTdw3Ckx-Em7E","value":600,"created_date":"2023-01-10T08:14:00.000Z","unit_type":"min","habit_id":"2B6B164F-121E-47AC-B574-F861324F5591"},{"id":"-NLmC6ISc99EBpcWzK39","value":720,"created_date":"2023-01-11T08:00:00.000Z","unit_type":"min","habit_id":"2B6B164F-121E-47AC-B574-F861324F5591"},{"id":"-NLmCCLPe1kxilTG2tK9","value":300,"created_date":"2023-01-12T08:00:00.000Z","unit_type":"min","habit_id":"2B6B164F-121E-47AC-B574-F861324F5591"},{"id":"-NLmCJlhtjJrLRpglFRh","value":300,"created_date":"2023-01-13T08:00:00.000Z","unit_type":"min","habit_id":"2B6B164F-121E-47AC-B574-F861324F5591"}],"version":"v1.2","status":true}
"""

let data = s.data(using: .utf8)!
let j = try! JSONDecoder().decode(HabitLogsJson.self, from: data)

let logs = j.logs!
let graphData = logs.map { (dt: $0.createdDate, val: $0.value) }

var lineChartEntry  = [ChartDataEntry]() //this is the Array that will eventually be displayed on the graph.

let startDate = graphData[0].0

struct DataPoint {
    let dt: Int
    var val: Int
}

var cd = graphData.map { datum -> DataPoint in
    let dt = datum.dt
    let v = datum.val

    let comp  = Calendar.current.dateComponents([.day], from: startDate, to: dt)

//    let m = comp.month!
    let d = comp.day!

    return DataPoint(dt: d, val: v)
}

cd = cd.reduce([], {result,v -> [DataPoint] in
    var arr = result
    if let last = arr.last, last.dt == v.dt {
        arr[arr.count-1].val += v.val
    } else {
        arr.append(v)
    }
    return arr
})


for i in 0..<cd.count {

    let value = ChartDataEntry(x: Double(cd[i].dt), y: Double(cd[i].val)/60.0)
    lineChartEntry.append(value) // here we add it to the data set
}

let line1 = LineChartDataSet(entries: lineChartEntry, label: "Hours") //Here we convert lineChartEntry to a LineChartDataSet

line1.colors = [NSUIColor.blue] //Sets the colour to blue

let chartData = LineChartData() //This is the object that will be added to the chart

chartData.append(line1) //Adds the line to the dataSet

let chartView = LineChartView()
chartView.data = chartData

let xAxis = chartView.xAxis

class MyFormatter: AxisValueFormatter {
    func stringForValue(_ value: Double,
                        axis: AxisBase?) -> String {
        let dt = Calendar.current.date(byAdding: .day, value: Int(value), to: startDate)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd"
        let result = dateFormatter.string(from: dt)

        return result
    }

}
xAxis.valueFormatter = MyFormatter()

chartView.frame=CGRect(x:0, y:0, width: 800, height:600)
PlaygroundSupport.PlaygroundPage.current.liveView=chartView


*/


Date().trimToDay().endOfDay()
