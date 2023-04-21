# Set the field separator (FS) and output field separator (OFS) to a tab character
BEGIN { FS=OFS="\t" }

# For each line of input, do the following:
{
    # Assign the current line of input to the variable "nxt"
    nxt = $0
    # Call the function "prt()"
    prt()
}

# After all lines have been processed, call the "prt()" function one final time
END {
    prt()
}

# Define the "prt()" function
function prt() {
    # Check if the variable "cur" contains the string "Cytoplasmic"
    if ( cur ~ /Cytoplasmic/ ) {
        # Split "pre" by tabs
        split(pre,a,"\t")
        # If "pre" contains "Transmembrane" or "Intramembrane" in the 3rd column, 
        if ( a[3] == "Transmembrane" || a[3] == "Intramembrane") {
            # Assign the value of "cur" to the current line ($0), 
            # Subtract half of the previous TMD from the 4th field ($4), 
            $0 = cur
            $4 -= int(( (a[5]+1)-(a[4]) )/2)
            # Print the modified line
            print
        }
        # Split "nxt" by tabs
        split(nxt,b,"\t")
        # If "nxt" contains "Transmembrane" or "Intramembrane" in the 3rd column,  
        if ( b[3] == "Transmembrane" || b[3] == "Intramembrane") {
            # Assign the value of "cur" to the current line ($0), 
            # Add half of the next TMD from the 4th field ($5)
            $0 = cur
            $5 += int(( (b[5]+1)-(b[4]) )/2)
            # Print the modified line
            print
        }
        # If both "pre" and "nxt" contain "Transmembrane" or "Intramembrane" in the 3rd column, 
        if (( a[3] == "Transmembrane" || a[3] == "Intramembrane" ) && ( b[3] == "Transmembrane" || b[3] == "Intramembrane" )) {
            # Assign the value of "cur" to the current line ($0), 
            # Subtract half of the previous TMD from the 4th field ($4), 
            # Add half of the next TMD from the 4th field ($5)
            $0 = cur
            $4 -= int(( (a[5]+1)-(a[4]) )/2)
            $5 += int(( (b[5]+1)-(b[4]) )/2)
            # Print the modified line
            print
        }
    }
    # Assign the current line of input to "cur"
    pre = cur
    cur = nxt
    # Assign the next line of input to "nxt"
    nxt = ""
}
