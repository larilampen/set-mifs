set-mifs
========

Matlab implementation of a feature selection algorithm based on set-wise mutual information

Many variants of the idea of using mutual information (MI) to
determine salience of a feature in a pattern recognition task have
been suggested in literature. They have their limitations, however:
computing MI between pairs of variables does not capture more complex
interactions among groups of variables, whereas computing MI for
subsets of the feature space larger than 2 quickly becomes
computationally intractable.

This algorithm, a quick method to compute MI for groups, effectively
resolves the computational intractability altogether; however, it has
limited applicability to problems with a large number of features for
other reasons.
