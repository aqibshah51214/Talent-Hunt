import SwiftUI

// MARK: - Country Model
struct Country: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let dialCode: String
    let code: String
    let flag: String
    
    static func flag(for countryCode: String) -> String {
        let base = 127397
        var temp = ""
        for v in countryCode.unicodeScalars {
            temp.unicodeScalars.append(UnicodeScalar(base + Int(v.value))!)
        }
        return String(temp)
    }
}

// MARK: - Country Data Manager
class CountryData {
    static let shared = CountryData()
    
    lazy var allCountries: [Country] = {
        var countries = [Country]()
        for code in NSLocale.isoCountryCodes {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "en_US").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Unknown"
            let flag = Country.flag(for: code)
            let dialCode = countryDialCodes[code] ?? ""
            countries.append(Country(name: name, dialCode: dialCode, code: code, flag: flag))
        }
        return countries.sorted { $0.name < $1.name }
    }()
    
    private let countryDialCodes: [String: String] = [
        "AF": "+93", "AL": "+355", "DZ": "+213", "AS": "+1", "AD": "+376",
        "AO": "+244", "AI": "+1", "AG": "+1", "AR": "+54", "AM": "+374",
        "AW": "+297", "AU": "+61", "AT": "+43", "AZ": "+994", "BS": "+1",
        "BH": "+973", "BD": "+880", "BB": "+1", "BY": "+375", "BE": "+32",
        "BZ": "+501", "BJ": "+229", "BM": "+1", "BT": "+975", "BO": "+591",
        "BA": "+387", "BW": "+267", "BR": "+55", "IO": "+246", "BG": "+359",
        "BF": "+226", "BI": "+257", "KH": "+855", "CM": "+237", "CA": "+1",
        "CV": "+238", "KY": "+1", "CF": "+236", "TD": "+235", "CL": "+56",
        "CN": "+86", "CO": "+57", "KM": "+269", "CG": "+242", "CK": "+682",
        "CR": "+506", "HR": "+385", "CU": "+53", "CY": "+357", "CZ": "+420",
        "DK": "+45", "DJ": "+253", "DM": "+1", "DO": "+1", "EC": "+593",
        "EG": "+20", "SV": "+503", "GQ": "+240", "ER": "+291", "EE": "+372",
        "ET": "+251", "FO": "+298", "FJ": "+679", "FI": "+358", "FR": "+33",
        "GF": "+594", "PF": "+689", "GA": "+241", "GM": "+220", "GE": "+995",
        "DE": "+49", "GH": "+233", "GI": "+350", "GR": "+30", "GL": "+299",
        "GD": "+1", "GP": "+590", "GU": "+1", "GT": "+502", "GN": "+224",
        "GW": "+245", "GY": "+592", "HT": "+509", "HN": "+504", "HK": "+852",
        "HU": "+36", "IS": "+354", "IN": "+91", "ID": "+62", "IR": "+98",
        "IQ": "+964", "IE": "+353", "IL": "+972", "IT": "+39", "JM": "+1",
        "JP": "+81", "JO": "+962", "KZ": "+7", "KE": "+254", "KI": "+686",
        "KW": "+965", "KG": "+996", "LV": "+371", "LB": "+961", "LS": "+266",
        "LR": "+231", "LI": "+423", "LT": "+370", "LU": "+352", "MO": "+853",
        "MK": "+389", "MG": "+261", "MW": "+265", "MY": "+60", "MV": "+960",
        "ML": "+223", "MT": "+356", "MH": "+692", "MQ": "+596", "MR": "+222",
        "MU": "+230", "YT": "+262", "MX": "+52", "MC": "+377", "MN": "+976",
        "ME": "+382", "MS": "+1", "MA": "+212", "MM": "+95", "NA": "+264",
        "NR": "+674", "NP": "+977", "NL": "+31", "AN": "+599"
    ]
}

// MARK: - Country Code Picker View
struct CountryCodePickerView: View {
    @Binding var selectedCountry: Country?
    @Environment(\.presentationMode) var presentationMode
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredCountries) { country in
                    Button(action: {
                        selectedCountry = country
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Text(country.flag)
                            Text(country.name)
                                .foregroundColor(.primary)
                            Spacer()
                            Text(country.dialCode)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .navigationTitle("Select Country")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
    
    private var filteredCountries: [Country] {
        if searchText.isEmpty {
            return CountryData.shared.allCountries
        } else {
            return CountryData.shared.allCountries.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.dialCode.contains(searchText) ||
                $0.code.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}
