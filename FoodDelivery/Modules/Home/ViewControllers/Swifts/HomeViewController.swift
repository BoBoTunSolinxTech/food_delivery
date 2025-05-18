
import UIKit
import CoreLocation
class HomeViewController: BaseViewController {

    @IBOutlet weak var tblHome: UITableView!
    @IBOutlet weak var btnNotification: UIButton!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var icLocation: UIImageView!
    @IBOutlet weak var bodyView: UIView!
    @IBOutlet weak var topView: UIView!
    
    // Create a CLLocationManager and assign a delegate
    let locationManager = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = true
        
        setupTableView()
        
        // Request a user’s location once
        self.locationManager.requestAlwaysAuthorization()
        
        getCurrentLocation()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
    }
    
    private func getCurrentLocation() {
        
        DispatchQueue.global().async { [self] in
            if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.startUpdatingLocation()
            }
            
            
        }
        
    }
    
    private func setupTableView() {
        tblHome.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        
        tblHome.registerForCells(cells: [
                                         BannerTableViewCell.self,
                                         CategoryTableViewCell.self,
                                         FavResturantTableViewCell.self,
                                         NearByTitleTableViewCell.self,
                                         ResturantTableViewCell.self])
        self.tblHome.contentInset = UIEdgeInsets(top: 0,left: 0,bottom: UIScreen.main.bounds.height * 0.1,right: 0)
        tblHome.backgroundColor = .clear
        tblHome.separatorStyle = .none
        tblHome.dataSource = self
        tblHome.delegate = self
        tblHome.reloadData()
    }
}

extension HomeViewController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return getBannerCell(indexPath: indexPath)
        case 1:
            return getCategoryCell(indexPath: indexPath)
        case 2:
            return getFavResturantCell(indexPath: indexPath)
        case 3:
            return getNearByCell(indexPath: indexPath)
        case 4:
            return getResturantCell(indexPath: indexPath)
        default:
            return getResturantCell(indexPath: indexPath)
        }
    }
    
    private func getOrderTypeCell(indexPath : IndexPath) -> UITableViewCell {
        let cell = tblHome.dequeReuseCell(type: OrderTypeTableViewCell.self, indexPath: indexPath)
        return cell
    }
    
    private func getBannerCell(indexPath : IndexPath) -> UITableViewCell {
        let cell = tblHome.dequeReuseCell(type: BannerTableViewCell.self, indexPath: indexPath)
        return cell
    }
    
    private func getCategoryCell(indexPath : IndexPath) -> UITableViewCell {
        let cell = tblHome.dequeReuseCell(type: CategoryTableViewCell.self, indexPath: indexPath)
        cell.delegate = self
        return cell
    }
    
    private func getFavResturantCell(indexPath : IndexPath) -> UITableViewCell {
        let cell = tblHome.dequeReuseCell(type: FavResturantTableViewCell.self, indexPath: indexPath)
        cell.delegate = self
        return cell
    }
    private func getNearByCell(indexPath : IndexPath) -> UITableViewCell {
        let cell = tblHome.dequeReuseCell(type: NearByTitleTableViewCell.self, indexPath: indexPath)
        cell.delegate = self
        return cell
    }
    
    private func getResturantCell(indexPath : IndexPath) -> UITableViewCell {
        let cell = tblHome.dequeReuseCell(type: ResturantTableViewCell.self, indexPath: indexPath)
        return cell
    }
}

extension HomeViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        
        let userLocation :CLLocation = locations[0] as CLLocation
        
        let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
                guard let placemark = placemarks?.first else {
                    if let error {
                        print("error in reverseGeocode: \(error)")
                    } else {
                        print("No placemarks found")
                    }

                    return
                }
                
                print("Address :: \(placemark.locality ?? ""), \(placemark.administrativeArea ?? ""), \(placemark.country ?? "")")
                    
//                self.locationValue.text = "\(placemark.locality ?? "Empty Locality"), \(placemark.administrativeArea ?? "Empty administrativeArea"), \(placemark.country ?? "Empty Country")"
                
                self.getAddress(from: locValue, completion: { address in
                    self.lblAddress.text = "Deliver to \n\(address)"
                })
            }
    }
    
    func getAddress(from coordinate: CLLocationCoordinate2D, completion: @escaping (String) -> Void) {
            let geoCoder = CLGeocoder()
            let location = CLLocation.init(latitude: coordinate.latitude, longitude: coordinate.longitude)
            
            geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
                
                // check for errors
                guard let placeMarkArr = placemarks else {
                    completion("")
                    debugPrint(error ?? "")
                    return
                }
                // check placemark data existence
                
                guard let placemark = placeMarkArr.first, !placeMarkArr.isEmpty else {
                    completion("")
                    return
                }
                // create address string
                
                let outputString = [placemark.locality,
                                    placemark.subLocality,
                                    placemark.thoroughfare,
                                    placemark.postalCode,
                                    placemark.subThoroughfare,
                                    placemark.country].compactMap { $0 }.joined(separator: ", ")
                
                completion(outputString)
            })
        }
    
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        // Handle failure to get a user’s location
    }
}

extension HomeViewController: CategoryTableViewCellDelegate, FavResturantTableViewCellDelegate, NearByTitleTableViewCellDelegate {
    func didTapSorting() {
        AppScreens.HomeVC.presentSortingVC.show()
    }
    
    func didTapResturantseeAll() {
        AppScreens.HomeVC.navigateToResturantListVC.show()
    }
    
    func didTapCategorySeeAll() {
        AppScreens.HomeVC.navigateToCategoryVC.show()
    }
    
}
