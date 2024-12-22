## Improving Local Minimal Intensity Prior-based Algorithms for Blind Image Deblurring

VE556 Project

Author: Wentao Chen, Keyi Deng, Yifei Sun, and Zhaochen Yu

### Directory Breakdown
#### multi\_scale\_prior

The directory contains essential files for the extension **Combining PMP of Different Scales**. The key changes are in deblur\_tv\_pmpr.m.

#### adaptive
The directory contains essential files for the extension **Adaptive Kernel Size Selection**. The key changes are in main\_eccv12.m.

#### roughness\_reg
The directory contains essential files for the extension **Quadratic Roughness Regularization**. The key changes are in estimate\_psf.m.

#### l1norm\_reg
The directory contains essential files for the extension **Application of $l_1$-norm**. The key changes are in deblur\_tv\_pmpr.m.

#### BlurryImages
The directory contains the original 48 blurry images.

#### results\_eccv12\_final
The directory is empty and outputs (if any) will be saved here.

### How to Run the Code
Enter one of the extension directories in MATLAB, and run the main_eccv12.m file. Outputs will be saved in results\_eccv12\_final directory.

### How to Evaluate the Results
Refer to [Köhler et al. website](https://webdav.tuebingen.mpg.de/pixel/benchmark4camerashake/src_files/Instructions_authors.html) to obtain the file for evaluation. The data required for evaluation is excessively large to include here.