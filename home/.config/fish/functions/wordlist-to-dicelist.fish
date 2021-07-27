function wordlist-to-dicelist --argument wordlist dicelist
cat $wordlist | iconv -c -t UTF-8 | grep -x '[[:alpha:]]*' | grep -iv -e '\([[:alpha:]]\)\1\{2,\}' | tr '[:upper:]' '[:lower:]' | sort -R -u > $dicelist
end
