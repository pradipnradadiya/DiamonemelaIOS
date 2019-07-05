import UIKit

class ImageFullVC: UIViewController {

    @IBOutlet weak var pagaControl: UIPageControl!
    @IBOutlet weak var gridFullImage: UICollectionView!
    var sliderImage: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  
}

extension ImageFullVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
            return CGSize(width: self.gridFullImage.frame.width, height: self.gridFullImage.frame.height)
       
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.pagaControl.numberOfPages=self.sliderImage.count
        return self.sliderImage.count
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
            self.pagaControl.currentPage = indexPath.row
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = self.gridFullImage.dequeueReusableCell(withReuseIdentifier: "FullImageCell", for: indexPath) as! FullImageCell
        
        cell.slider = [self.sliderImage[indexPath.row]]
        
        
       
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       
        
    }
    
}
