# Image Search Engine

This is an Image Search Engine using MATLAB developed as a part of [IvLabs](https://github.com/ivlabs) Technoseason 2020 Task, which is the recruitment test of IvLabs.
The search engine takes an image address as input and outputs similar images from the dataset. The search engine uses classical Computer Vision methods.

## Method Used
1. The RGB color histogram of all dataset images is calculated and concatenated to form a feature vector of size 256*3.
2. The RGB color histogram of the input image is calculated in the same way to form a feature vector.
3. The Cosine Similarity test is applied between the input image feature vector and all the dataset image feature vectors.
4. If the Cosine Similarity between the images is greater than or equal to **0.935**(determined experimentally), then the dataset image is shown as an output.
5. If the Cosine Similarity between the images is exactly **1**, ie the image is the same one present in the dataset, it ignores the image.
6. The similarity test runs through all the images and then the program exits.

## Dataset Used
The dataset used in this project is a custom dataset containing 29 images of size 400*166. The images are taken from 4 popular TV Series, namely The Big Bang Theory, HouseMD, The Hobbit and The Simpsons. 

## Contributors
- [Pulkit Mathur](https://github.com/mathurpulkit)
- [Rishabh Verma](https://github.com/RiVer2000)
