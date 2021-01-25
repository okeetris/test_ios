IFS=' ' read -r -a LOGARRAY <<< $(git log | grep 'Merge:' -m 1)
          changedFiles=$(git diff --name-only ${LOGARRAY[2]} ${LOGARRAY[1]})     
          echo "changedFiles :" $changedFiles
          TRIGGER=false
          for path in $changedFiles
          do
            echo "path : " $path
            IFS='/' read -ra ARRAY <<< "$path"
            if [[ "${ARRAY[0]}" = "apps" ]] || [[ "${ARRAY[0]}" = "packages" ]] || [[ "${ARRAY[0]}" = "package.json" ]]; then
                TRIGGER=true
                echo "##vso[task.setvariable variable=ios;isOutput=true]$TRIGGER"
            fi
          done