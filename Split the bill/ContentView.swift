import SwiftUI

struct ContentView: View {
    @State private var checkAmount: Double = 200
    @State private var persons: Int = 1
    @State private var tipPercentage: Double = 10
    @State private var theme: String = "light"
    @State private var rounding : String = "nearest"
    @State private var currency: String = "USD"
    var perPerson: Double {
        let pp = checkAmount/Double(persons)
        switch rounding {
            case "nearest":
                return pp.rounded()
            case "up":
                return pp.rounded(.up)
            case "down":
                return pp.rounded(.down)
            default:
                return pp
        }
    }
    var tipAmount: Double {
        checkAmount * tipPercentage / 100
    }
    var finalBillAmount: Double {
        checkAmount + tipAmount
    }
    var body: some View {
        Form {
            Section {
                TextField("Bill", value: $checkAmount, format: .currency(code: currency))
                Picker("Persons", selection: $persons){
                    ForEach(1..<26) {
                        Text("\($0) persons")
                    }
                }
                TextField("Tip (%)", value: $tipPercentage, formatter: NumberFormatter())
            }
            Section {
                Text("Bill: \(checkAmount, specifier: "%.2f") \(currency)")
                Text("Tip: \(tipAmount, specifier: "%.2f") \(currency)")
                Text("Total: \(finalBillAmount, specifier: "%.2f") \(currency)")
            }
            Section(header: Text("Settings")){
                Picker("Theme", selection: $theme) {
                    Text("Light").tag("light")
                    Text("Dark").tag("dark")
                }.pickerStyle(SegmentedPickerStyle())
                Picker("Rounding", selection: $rounding) {
                    Text("Nearest").tag("nearest")
                    Text("Up").tag("up")
                    Text("Down").tag("down")
                }
                Picker("Currency", selection: $currency) {
                    Text("USD").tag("USD")
                    Text("EUR").tag("EUR")
                    Text("GBP").tag("GBP")
                    Text("JPY").tag("JPY")
                    Text("CNY").tag("CNY")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
