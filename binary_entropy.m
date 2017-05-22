function h = binary_entropy(x)
    h = - x * log2(x) - (1-x) * log2(1-x);
end