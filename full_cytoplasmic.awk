BEGIN { FS=OFS="\t" }
{
    nxt = $0
    prt()
}
END {
    prt()
}

function prt() {
    if ( cur ~ /Cytoplasmic/ ) {
        if ( pre ~ /Transmembrane/ || pre ~ /Intramembrane/ ) {
            $0 = cur
            $4 -= 23
            print
        }

        if ( nxt ~ /Transmembrane/ || pre ~ /Intramembrane/ ) {
            $0 = cur
            $5 += 23
            print
        }
    }

    pre = cur
    cur = nxt
    nxt = ""
}
