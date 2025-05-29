// TODO merge with edits in Data/District
import SwiftUI
import UIKit


class DistrictSegmentedControl: UISegmentedControl {
    init() {
        let districts = ["Śródmieście", "Sławinek", "Czechów", "Wieniawa", "Rury"]
        super.init(items: districts)
        self.selectedSegmentIndex = 0
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func selectedDistrict() -> String {
        return titleForSegment(at: selectedSegmentIndex) ?? "Śródmieście"
    }
}
