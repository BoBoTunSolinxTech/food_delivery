
import UIKit
import FSPagerView
import Kingfisher
class BannerTableViewCell: BaseTableViewCell {

    @IBOutlet weak var pagerView: FSPagerView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setupUI() {
        super.setupUI()
        
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.layer.cornerRadius = 10
        pagerView.clipsToBounds = true
        pagerView.isInfinite = true
        pagerView.automaticSlidingInterval = 5.0
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
}


extension BannerTableViewCell: FSPagerViewDelegate , FSPagerViewDataSource {
    // MARK:- FSPagerView DataSource
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return 5
        }
       
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        //cell.imageView?.kf.setImage(with: URL(string: "image"), placeholder: UIImage(named: "ic_placeholder"))
        cell.imageView?.image = UIImage(named: "img_sample")
        cell.imageView?.contentMode = .scaleToFill
        
        return cell
    }
    
}
