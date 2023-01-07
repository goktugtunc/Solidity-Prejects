// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

contract Voting {
    // Değişkenler
    address public owner; // Oyu veren yani sahibinin kimlik adresini aldık
    mapping(uint => Option) public options; //mapping yöntemi ile poizitif olarak oluşturduğumuz Option değişkenini herkese açık options değişkenine bağladık
    uint public totalVotes; //pozitif değer oluşturduk
    uint[] myArray; // Array oluşturduk

    // Oylama seçeneklerini tutan struct
    struct Option { // bir struct oluşturduk
        string name; // option (seçenek) değişkeninin adını tutacak string değişkeni oluşturduk
        uint voteCount; //Oy sayacı değişkeni oluşturduk
    }

    // Constructor function
    constructor(string[] memory optionNames) public { // bir Constructor oluşturduk
        owner = msg.sender; // oyu göndereni owner değişkenine eşitledik
        totalVotes = 0; // toplam oyları ilk başta sıfıra eşitledik


        for (uint i = 0; i < optionNames.length; i++) { // for döngüsü ile oylamanın seçeneklerini teker teker belirliyoruz
            options[i] = Option(optionNames[i], 0); // yukarıda açıklaması yapıldı
        }
    }

    // Oy kullanma işlevi
    function vote(uint optionId) public { // optionId değişkeni oluşturup fonksiyon başlattık
        require(optionId < options.length, "Invalid option."); // girilen seçenek olan seçenek sayısından büyük mü diye kontrol edip büyükse geçersiz seçenek diyoruz
        options[optionId].voteCount++; //votecount değişkenini bir artıyoruz
        totalVotes++; // toplam oyları 1 artırıyoruz
    }

    // Sahibin oylamayı kapatmasını sağlayan modifier
    modifier onlyOwner { // Yalnızca oylamayı başlatanın kullanabileceği bir modifier oluşturduk
        require(msg.sender == owner, "Only the owner can perform this action."); // fonksiyon owner tarafından kullanılırsa oylama biter ancak başkası kullanırsa bir hata mesajı alır
        _;
    }

    // Oylamayı kapatma işlevi
    function closeElection() public onlyOwner {
        selfdestruct(owner);
    }
}