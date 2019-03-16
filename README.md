# Tool Detection and Operative Skill Assessment in Surgical Videos Using Region-Based Convolutional Neural Networks

By Amy Jin, Serena Yeung, Jeffrey Jopling, Jonathan Krause, Dan Azagury, Arnold Milstein, Li Fei-Fei
Stanford University

### Abstract

Half of all surgical complications are estimated to be preventable, many of which are attributed to poor individual and team performance. Yet, surgeons often receive inadequate training and feedback on their performance, as the manual assessment process is time-consuming and requires expert supervision. We introduce a deep learning approach to track and recognize surgical instruments in cholecystectomy videos, which enables us to gain rich insight into tool movements and usage patterns to efficiently and accurately analyze surgical skill. We approach this task of tool detection and localization by leveraging region-based convolutional neural networks, and we collect a new dataset, m2cai16-tool-locations, extending the existing m2cai16-tool dataset with spatial bounds of tools. We then apply our model over time to extract tool usage timelines, motion heat maps, and tool trajectory maps, which we validate as effective performance indicators, demonstrating the ability of spatial tool detection to facilitate operative skill assessment.

### Citation

    @article{jin2018tool,
        title={Tool Detection and Operative Skill Assessment in Surgical Videos Using Region-Based Convolutional Neural Networks},
        author={Jin, Amy and Yeung, Serena and Jopling, Jeffrey and Krause, Jonathan and Azagury, Dan and Milstein, Arnold and Fei-Fei, Li},
        journal={IEEE Winter Conference on Applications of Computer Vision},
        year={2018}
    }

### Links

* [Paper](http://arxiv.org/abs/1802.08774)
* [Data](http://ai.stanford.edu/~syyeung/resources/m2cai16-tool-locations.zip)

## Labeling

* `BoundingBoxes.m` is the annotation interface that was used to label each frame with the bounding box coordinates of tools present along with their classes.
* `annotstruct2xml.m` is the script that converts the struct created in the annotation process to an `.xml` file.

## Tool detection

### Setting up the dataset

* The dataset can be found under `faster_rcnn/datasets/VOCdevkit/VOC2007`, within which there are three subdirectories, `Annotations`, `ImageSets`, and `JPEGImages`. The folder `m2cai16-tool-locations` on this GitHub contains the same files.
    - `Annotations` contains the frame-level `.xml` files. In the Stanford filesystem, they were retrieved from `/data2/home/ajin/faster_rcnn/datasets/VOCdevkit/VOC2007/Annotations-m2cai16-MoreAnnotations2-7-27-2017`.
    - Under `ImageSets` are two more folders called `Layout` and `Main`.
        * `Layout` contains `.txt` files for each tool class, including the binary annotations for tool presence for each frame for train, trainval, val, and test. In the Stanford filesystem, they were retrieved from `/data2/home/ajin/faster_rcnn/datasets/VOCdevkit/VOC2007/ImageSets/Layout-RemovedBackgroundClass-10-31-2016`.
        * `Main` contains four files: `test.txt`, `train.txt`, `trainval.txt`, and `val.txt`, specifying which frames should be used for training, validation, and testing. In the Stanford filesystem, they were retrieved from `/data2/home/ajin/faster_rcnn/datasets/VOCdevkit/VOC2007/ImageSets/Main-m2cai16-MoreAnnotations2-7-27-2017`.
        * `JPEGImages` needs to be populated. It should contain the `.jpg` image for each frame and its flipped version. In the Stanford filesystem, they were retrieved from `/data2/home/ajin/faster_rcnn/datasets/VOCdevkit/VOC2007/JPEGImages-m2cai16-MoreAnnotations2-7-27-2017`.

### The final trained models / other things that are too big for GitHub (not all are needed for training)

Not all files were transferrable due to disk quota and GitHub repo size limitations. Thus, if needed, the directories with missing components on this GitHub and their corresponding Stanford filesystem links are listed below.

* fetch_data: `/data2/home/ajin/faster_rcnn/fetch_data/output/faster_rcnn_final/faster_rcnn_VOC0712_vgg_16layers/`
* output: `/data2/home/ajin/faster_rcnn/output/faster_rcnn_final`
    - Latest model can be found under `faster_rcnn_VOC2007_vgg_16layers-m2cai16-MoreAnnotations2-8-13-2017`
* test_input_aj: all the input frames are organized by video number here `/data2/home/ajin/faster_rcnn/test_input_aj/m2cai16-tool`
* test_output_aj (should start out as an empty directory / not necessary for training): the resulting frame-by-frame detection output `.jpg` frames go here
    - See sample output frames under `data2/home/ajin/faster_rcnn/test_output_aj/m2cai16-tool`
    
### Training a model with VGG net

For some reason, MATLAB doesn’t like just `run script_faster_rcnn_VOC2007_VGG16.m`, so execute `run experiments/script_faster_rcnn_VOC2007_VGG16.m` from within the `faster_rcnn` directory instead.

## Metrics

The code for generating the assessment metrics for each test video, including tool usage timelines, trajectory maps, and heat maps, can be found under `Metrics` on this GitHub.
* `input_csv` contains sample output `.csv` files for each of the `m2cai16-tool` test videos with which the metrics are generated.  
* `ground-truth-timeline-compare-with-moving-average.ipynb` contains the code that generates tool usage timelines for each video.
* `trajectory.ipynb` contains the code that generates tool trajectory maps for the clipping phase of laparoscopic cholecystectomies.
* `csvtoheatmap.m` within the directory `heatmap` contains the code that generates heat maps reflecting motion economy for a procedure.

## Contact

[mailto](mailto:amyjin713@gmail.com)


