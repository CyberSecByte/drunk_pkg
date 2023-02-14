#!/bin/bash

echo "[!]: Cleaner has been started!"

remove_leftovers() {
    iam=$1

    cd $@

    set +e
    echo " "
    echo "[*]: Moving $iam pkgs to proper place"
    mv */*pkg.t* ../../pkgs/$iam/ &> /dev/null
    set -e
    echo "[*]: Cleaning up $iam"

    rm -rf */pkg/ */src/ */*pkg* */*xz* */*tar.gz */*tar.bz2 */*.zip */*/ */*tgz */*tar.zst */*sign* */*sig* */*asc*

    cd ..
}

remove_kde_leftovers() {
    iam=$1

    echo " "
    echo " "
    echo "[!]: Start of kde cleanup ( prepare for log spam )"
    echo " "

    cd $@

    # kde 1/2
    for usual in frameworks graphics kdevelop libraries multimedia network other plasma sdk system utilities
    do
        cd $usual

        set +e
        echo " "
        echo "[*]: Moving $iam pkgs to proper place from $usual"
        mv */*pkg.t* ../../../pkgs/$iam/ &> /dev/null
        set -e
        echo "[*]: Cleaning up $iam in $usual"

        rm -rf */pkg/ */src/ */*pkg* */*xz* */*tar.gz */*tar.bz2 */*.zip */*/ */*tgz */*tar.zst */*sign* */*sig* */*asc*

        cd ..
    done

    # kde 2/2
    cd neon
    # As neon has its own sub-category of packages then we need to do all of it again
    for usual in extras
    do
        echo " "
        echo "[*]: Moving $iam pkgs to proper place from $usual"

        set +e
        mv */*/*pkg.t* ../../../pkgs/$iam/ &> /dev/null
        set -e
        rm -rf */*/pkg/ */*/src/ */*/*pkg* */*/*xz* */*/*tar.gz */*/*tar.bz2 */*/*.zip */*/*/ */*/*tgz */*/*tar.zst */*/*sign* */*/*sig* */*/*asc*
    done
}

set -e

remove_leftovers core
remove_leftovers cross_tools
remove_leftovers extra
remove_leftovers extra32
remove_leftovers games
remove_leftovers layers
remove_leftovers pentest
remove_leftovers perl
remove_leftovers proprietary
remove_leftovers python
remove_leftovers server
remove_leftovers xfce
remove_leftovers gnome
remove_kde_leftovers kde

echo " "
echo "[*]: Done"
