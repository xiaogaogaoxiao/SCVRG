# Stochastic Composition Optimization

These codes provide implementations of solvers for large-scale finite-sum composition optimization problems using an accelerated stochastic compositional variance reduced gradient. 

# About

We propose an accelerated stochastic compositional variance reduced gradient method for optimizing the sum of a composition function and a convex nonsmooth function. We provide an \textit{incremental first-order oracle} (IFO) complexity analysis for the proposed algorithm and show that it is provably faster than all the existing methods. Indeed, we show that our method achieves an asymptotic IFO complexity of O((m+n)log(1/eps)+1/eps^3) where $m$ and $n$ are the number of inner/outer component functions, improving the best-known results of O(m+n+(m+n)^{2/3}/eps^2\right)$ for convex composition problem. Experiment results on sparse mean-variance optimization with 21 real-world financial datasets confirm that our method outperforms other competing methods.

# Codes

Implementations in MATLAB are provided, including sparse mean-variance optimization with 21 US Research Returns datasets from the Center for Research in Security Prices (CRSP) website2, e.g., three large 100-porfolio datasets and 18 medium datasets for Developed Market Factors and Returns. 

# References

T. Lin, C. Fan, M. Wang, M. I. Jordan. Improved Oracle Complexity for Stochastic Compositional Variance Reduced Gradient. Arxiv Priprint. https://arxiv.org/abs/1806.00458
