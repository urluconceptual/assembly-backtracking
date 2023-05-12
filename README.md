# Assembly x86 Backtracking

The second project implemented for the Computer Architecture course. Recursive backtracking algorithm, implemented in Assembly x86 (AT&amp;T).

## Input
The input received from the keyboard is: n, m and 3\*n elements with values between 0 and n, where the condition 1 ≤ n, m ≤ 30 is met. Starting from the 3*n sequence, with certain fixed points already specified, generate the lexicographically smallest permutation of {1, ..., n}, where each element occurs exactly 3 times, having a distance of minimum m elements between any two equal elements.   
## Output
The answer will be displayed as standard output, as appropriate:  
    => the permutation, if there is at least one that satisfies all conditions  
    => -1, if there is no permutation that satisfies all conditions  

## Example
    For n = 5, m = 1 and sequence of 15 elements:  
    
    1 0 0 0 0 0 3 0 0 0 0 0 0 4 5  

    we have that each element in {1, 2, 3, 4, 5} occurs 3 times, and we want at least m = 1 distance between any two equal elements. The lexicographically smallest permutation, keeping the fixed points, is the following:  
    
    1 2 1 2 1 2 3 4 3 5 3 4 5 4 5
