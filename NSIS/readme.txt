* install.nsi - NSIS script is used to build installer without embedded blockchain block data

* install_with_blocks.nsi - NSIS script is used to build installer with blockchain data included.
Having blockchain data significantly increases the installer size but speeds up the wallet sync with the network

Before building install_with_blocks.ns, please create a folder named "blockchainfix". Get a copy of "blocks" and "chain" state folders from %appdata%/BitCrystal_V20 and put them inside "blockchainfix". This way the installer will have the latest blockchain data embedded into it.