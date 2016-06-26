# bash-ext-arrays
Bash arrays that support multiple dimensions

## Usage
To use multi-dimensional arrays, source this file from one of your bash scripts (or even from your interactive shell). Once sourced, you can use the arrays like this:

```
# Initialize array
array multid

# Set values
multid [2][1] = Canis
multid [0][0] = Lupus
multid [0][3] = Familiaris

# Use the values in place of normal variables
echo "This animal is a $(multid [2][1])"

# If you just want to print the value on the screen you can just use
# this instead of echo-ing
multid [0][0]
```

## Issues
Due to the fact that these arrays are not native, I could not find any way to make the syntaxis like that of the normal arrays. Suggestions are welcome.

## Planned features
   * Currently, due to compatibility concerns, the arrays can only be indexed. Associative arrays are planned for a future version.
