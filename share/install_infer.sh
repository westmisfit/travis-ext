source $TRAVIS_EXT_HOME/$PROJECT_LANGUAGE/vars

function install_macos(){
    # because fbinfer removed the osx download link from https://github.com/facebook/infer/releases
    # so, I have uploaded a copy of infer-osx-v0.1.0.tar.xz to dropbox,
    # then, download it from dropbox
    curl -L -o $HOME/infer-osx-v0.1.0.tar.xz https://s3.amazonaws.com/misfit.sw.stg.epd-team/downloads/infer-osx-v0.1.0.tar.xz
    tar -xJf $HOME/infer-osx-v0.1.0.tar.xz -C $HOME
    ln -s $HOME/infer-osx-v0.1.0 $HOME/infer
}

function install_linux(){
    mkdir -p $HOME/infer
    cd $HOME/infer

    # echo "DEBIAN_FRONTEND=$DEBIAN_FRONTEND"
    # DEBIAN_FRONTEND=noninteractive

    # sudo apt-get update
    # sudo apt-get upgrade
    # sudo apt-get install git openjdk-7-jdk m4 zlib1g-dev python-software-properties build-essential libgmp-dev libmpfr-dev libmpc-dev unzip
    wget https://github.com/ocaml/opam/releases/download/1.2.2/opam-1.2.2-x86_64-Linux -O opam
    chmod +x opam
    ./opam init --comp=4.01.0 -y
    eval `./opam config env`
    ./opam install sawja.1.5 atdgen.1.5.0 javalib.2.3a extlib.1.5.4 -y

    local INFER_VERSION=0.2.0

    curl -L -o infer-${INFER_VERSION}.tar.gz https://github.com/facebook/infer/archive/v${INFER_VERSION}.tar.gz
    tar xzf infer-${INFER_VERSION}.tar.gz
    # ls -al
    ln -s infer-${INFER_VERSION} infer
    cd infer
    make -C infer java
    
    # ls -al
    # ls -al infer/bin/
    # ./update-fcp.sh
    # ls -al $HOME/infer

    # true
}

if [[ ! -f $HOME/infer/infer/infer/bin/infer ]]; then
    if [[ "$TRAVIS_OS_NAME" = "linux" ]]; then
        install_linux
    elif [[ "$TRAVIS_OS_NAME" = "osx" ]]; then
        install_macos
    fi
fi

if which infer ; then
    infer --version
elif [[ -f "$HOME/infer/infer/infer/bin/infer" ]]; then
    echo 'Warning: PATH is not setted for infer, please set PATH=$PAHT:$HOME/infer/infer/infer/bin.'
    $HOME/infer/infer/infer/bin/infer --version
    exit 1
else
    echo 'Error: Install infer failed, can'\''t find infer.'
    find $HOME/infer -name infer
    exit 1
fi
