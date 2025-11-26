# My first PowerShell profile
Features:
- Shows when terminal is running with  elevated privileges.
- Shows current working directory
- Shows current user
- Detects git repos (but not branches, TODO)
- Easter Eggs

The way this script is architectured is very poor. It serves as a demo of how the Terminal prompt can be decorated.

Future profiles should build the entire string into a variable first, then print it to the terminal second.
This way the code can be modularised much better.
Other programming languages can be incorporated into the script to provide an alternative way of decorating
the prompt.

I created this profile because I didn't want to download "Oh My Posh" without knowing how it works.