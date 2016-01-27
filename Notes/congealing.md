How does Congealing work?
===
<https://people.cs.umass.edu/~elm/papers/PAMI_congeal.pdf> Miller-Learned paper

* Minimisation of misalignment function.
* Reduce the entropy
* Highly non-linear and computationally costly
* Improves locally per pixel, not at a more global level

Spatial transformations = simplest conceptually and most intuitive

> Think of a pixel stack amongst all the images (Pixelwise Entropies)- "We can estimate the entropy, or disorder, of this pixel
process by calculating the entropy of the empirical distribution
of values in the pixel stack"

Work towards as many of the pixel stacks as possible having the lowest possible entropies

* Paper congeals 10 sets of 100 images each from MNIST

---

#### Least Squares Congealing
<http://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=4587573>  = gives a good description of original Congealing & new technique.

* Different measure of misalignment
* Means you can use gradient based optimisation techniques
