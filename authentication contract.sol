// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Registration {

    address owner;  //The address of owner is TA.

    constructor() {
        owner=msg.sender;
   }
    
    struct UserList{
        bool tag; //The user’s authorization status
        string pvk; //The vehicle’s public key
        uint256 timestamp; //The vehicle’s registration timestamp

    } 
    mapping(string => UserList) private IDtoUserinfo; //PID to its user list 
    function CreateUser(string memory PID, bool tag, string memory pvk) public {
        require(msg.sender==owner);
        UserList memory newUserList = UserList(tag,pvk,block.timestamp);
        IDtoUserinfo[PID] = newUserList;
    }

      
    function UpdateUser (string memory PID, bool tag) public {
        require(msg.sender==owner);
        IDtoUserinfo[PID].tag = tag;
        //IDtoUserinfo[PID].pvk = pvk;
        IDtoUserinfo[PID].timestamp = block.timestamp;
    }
    function QueryUser(string memory PID) public view returns (bool tag, string memory pvk, uint256 timestamp){

        return (IDtoUserinfo[PID].tag, IDtoUserinfo[PID].pvk, IDtoUserinfo[PID].timestamp);

    }


    struct TXList{
        bool tag;
        string pvk; //The vehicle’s public key
        string R; //The vehicle’s temporary public key
        string sg; //Signature
        string phi;//Time epoch
        string PID2;//The receiver pseudonym identity
        uint256 sgtime; //Timestamp for signature
        string z1; //Schnorr signature result z1
        string z2; //Schnorr signature result z2

    }   
    
    mapping(string => TXList)  SGList; //PID to its user list 
     mapping(string => TXList)  C; //Consenus authentication

   
     
 
    function AddTX (string memory PID, string memory pvk, string memory R, string memory sg,uint256 sgtime) public {
        require(msg.sender==owner);
        SGList[PID].pvk = pvk;
        SGList[PID].R = R;
        SGList[PID].sg = sg;
        SGList[PID].sgtime = sgtime;

    }
    function QueryTX(string memory PID) public view returns ( string memory pvk, string memory sg,uint256 sgtime){

        return ( SGList[PID].pvk, SGList[PID].sg, SGList[PID].sgtime);

    }

    function AddCon (string memory PID, bool tag, string memory phi, string memory PID2, string memory z1, string memory z2) public {
        require(msg.sender==owner);
        C[PID].tag = tag;
        C[PID].phi = phi;
        C[PID].PID2 = PID2;
        C[PID].z1 = z1;
        C[PID].z2 = z2;
    }

    function QueryCon(string memory PID) public view returns ( bool tag, string memory phi, string memory PID2, string memory z1, string memory z2){

        return ( C[PID].tag, C[PID]. phi, C[PID].PID2, C[PID].z1, C[PID].z2);

    }


}