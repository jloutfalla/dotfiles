#!/bin/sh

# Generate a random number

if [ -e "/dev/urandom" ]
then

    result=$(hexdump -n 2 -e '/2 "%u"' /dev/urandom)
    echo "$result"

elif [ -e "/dev/random" ]
then

    result=$(hexdump -n 2 -e '/2 "%u"' /dev/random)
    echo "$result"

else

    python_exec=$(ls -l "$(command -v python)")
    if echo "$python_exec" | grep -E -q "python3.*$"
    then

        python -c "import random; import sys; print(random.randint(1, sys.maxsize))"
    
    else

        python -c "import random; import sys; print random.randint(1, sys.maxint)"

    fi

fi

