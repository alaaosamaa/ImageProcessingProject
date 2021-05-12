# ImageProcessingProject
MATLAB
Load image and add noise the remove it to see the effect of filters

My project consists of 3 tabs.
Tab 1 contains:

- 'Browse' button to browse any image and check if it is corrupted or if the user choose any non-image file it will give him an error.

- 'Show Histogram' button to calculate the histogram for the image.

- 'Histogram Equalization' button to equalize the histogram and show it and the equalized image.

- Sobel and Laplace filters, user can choose between them and enter either the alpha or threshold values then press apply button to apply the filter. With all the validation checks.

Tab 2 contains:

- Fourier transform and grayscale image.

- Add Salt& Pepper noise: user should enter the percentage of noise then press apply button if the user did not enter any value the default value will be applied. With all the validation checks.

- Remove Salt& Pepper noise: user should enter the Size of the filter then press apply button if the user did not enter any value the default value will be applied. With all the validation checks.

Tab 3 contains:

- Add periodic noise: the user should enter nx and ny then choose sin or cos the press 'Apply' button to apply the noise and display the noisy image and its fourier. If the user did not enter any value the default value will be applied. With all the validation checks.

- Remove periodic noise: there are 3 options for the user Notch, Band-reject and Mask filters. For notch and Notch, Band-reject the user can't enter any values. For the mask filter, user should choose 'Mask' option then press apply button then follow the instructions to select two points. . With all the validation checks.
