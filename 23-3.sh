################################################ Things which should be modified per release
export WORKING_BRANCH=master
export RELEASE=2023-3
export BUILD_TYPE='debug' #Available options [debug | optimized]
################################################

############################################### set SCHRODINGER and SCHRODINGER_SRC
export SCHRODINGER_SRC=$BASE_FOLDER/src
export SCHRODINGER=$BASE_FOLDER/$RELEASE
###############################################

###############################################To get things working
export GIT_SSH=ssh  # This is required on Windows because by default git uses plink.
export SCHRODINGER_BUILD_FROM_SRC=1
#export INTEL_LICENSE_FILE=28518@ns4.schrodinger.com:28518@ns3.schrodinger.com
export WAFCACHE=/tmp/$USER/.wafcache # Useful to keep all temporary files generated by WAF at single place.
export PATH=$QTDIR/bin:$PATH
export LD_LIBRARY_PATH=$QTDIR/lib:$LD_LIBRARY_PATH
export PATH=$PATH:$SCHRODINGER/utilities
export SCHRODINGER_IFORT_2022_0_BUILD=1

CONSOLE_OPTION=''
if [[ $OSTYPE == "darwin"* ]]; then
   CONSOLE_OPTION='-console'
fi
PREMAKE_OPTION='-g'
if [[ $BUILD_TYPE == "optimized" ]]; then
    PREMAKE_OPTION='-official'
fi

if [[ $OSTYPE == "msys" ]]; then
    alias rbt="winpty rbt"
    export GIT_EDITOR=notepad
fi

###############################################

###############################################
#Change branch of all repositories to current release branch
pushd $PWD
for repository in "$SCHRODINGER_SRC"/*
do
 cd "$repository"
 echo "Changing branch for $repository ..."
 git checkout "$WORKING_BRANCH"
done
popd
###############################################

#Source build environment
. $SCHRODINGER_SRC/mmshare/build_env -b
