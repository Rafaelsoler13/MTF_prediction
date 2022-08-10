BEGIN { FS=OFS="\t" }
{
    nxt = $0
    prt()
}
END {
    prt()
}

function prt() {
    if ( cur ~ /Extracellular/ ) {
        if ( pre ~ /Transmembrane/ || pre ~ /Intramembrane/ ) {
            $0 = cur
            $4 -= 12
            print
        }

        if ( nxt ~ /Transmembrane/ || pre ~ /Intramembrane/ ) {
            $0 = cur
            $5 += 12
            print
        }
    }

    pre = cur
    cur = nxt
    nxt = ""
}
