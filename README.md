# bash-ext-arrays
Bash arrays that support multiple dimensions

## Usage
To use this script, source it from one of your scripts (or even from the shell). Once sourced, you can use the arrays like this:

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

## Planned features
   * Currently, due to compatibility concerns, the arrays can only be indexed. Associative arrays are planned for a future version.
