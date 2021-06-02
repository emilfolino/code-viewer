mkdir files

rsync -a -e "ssh -i /home/efo/.ssh/dbwebb.pub" efostud@ssh.student.bth.se:~$1/dbwebb-kurser/$2/me/$3/ files/

FILE="export/$2$3$1.html"

$(>$FILE)

echo $(cat includes/header.html) >> $FILE

cd files

for f in *; do
    echo "<h2>$f</h2>" >> "../$FILE"
    echo "<button class='handle' data-drawer='$f'>Open</button>" >> "../$FILE"
    echo "<div class='drawer' id='$f'>" >> "../$FILE"

    cd $f

    for ff in *; do
        if [[ $ff == *.py ]]
        then
            echo "<h4>$ff</h4>" >> "../../$FILE"
            echo "<pre><code class='language-python'>" >> "../../$FILE"
            echo "$(cat $ff)" >> "../../$FILE"
            echo "</code></pre>" >> "../../$FILE"
        fi
    done

    cd ..

    echo "</div>" >> "../$FILE"
done

cd ..

echo $(cat includes/footer.html) >> $FILE

rm -rf files
