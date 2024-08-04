//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "./Address.sol";

abstract contract Initializable {
    uint8 private _initialized;

    bool private _initializing;

    event Initialized(uint8 version);

    modifier initializer(){
        bool isTopLevelCall = !_initializing;
        require((isTopLevelCall && _initialized < 1) || (!Address.isContract(address(this)) && _initialized == 1), "Initialization contract is already initialized");


        _initialized = 1;

        if(isTopLevelCall){
            _initializing = true;
        }
        _;
        if(isTopLevelCall){
            _initializing = false;
            emit Initialized(1);
        }
    }

    modifier reinitializer(uint8 version) {
        require(!_initializing && _initialized<version, "Initializable: contract is already initialized");

        _initialized = version;
        _initializing = true;
        _;
        _initializing = false;
        emit Initialized((version));
    }
}