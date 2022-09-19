// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.10;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import {StringUtils} from "../libraries/StringUtils.sol";
import {Base64} from "../libraries/Base64.sol";
import "hardhat/console.sol";

contract Domains is ERC721URIStorage {
    // Magic given to us by OpenZeppelin to help us keep track of tokenIds.
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    string public tld;

    // We'll be storing our NFT images on chain as SVGs
    string svgPartOne =
        '<svg width="1051" height="995" fill="none" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" clip-rule="evenodd" d="M203.647 759.035c11.638 42.915 38.883 81.228 71.258 113.571 33.276 33.244 72.533 60.744 107.552 81.045l.41.238.432.198c118.97 54.633 230.295 50.683 319.643 9.105 89.17-41.492 155.74-120.127 186.043-213.608 19.052-58.771 39.602-158.53.287-351.579a9.98 9.98 0 0 0-1.603-3.738c-45.932-126.661-87.31-225.166-148.449-291.897C676.788 34.226 594.6 0 469.472 0 343.176 0 241.645 57.563 178.551 148.265c-62.802 90.282-87.157 212.804-61.111 343.07-17.866 1.211-34.17 6.068-46.379 12.955C18.656 533.852-3.727 591.271.502 645.774c2.921 37.645 17.867 74.613 41.759 101.155 23.989 26.65 57.393 43.093 96.339 38.009 18.6-1.798 43.468-10.366 65.047-25.903Zm-8.677-599.35c-59.489 85.52-83.175 202.794-57.696 328.833.206 1.021.249 2.036.147 3.019 27.086 2.399 55.522 13.711 77.573 38.872 3.64 4.153 3.224 10.471-.93 14.111-4.153 3.64-10.471 3.224-14.111-.929-35.226-40.195-91.092-37.661-119.066-21.881-44.253 24.964-64.205 74.049-60.445 122.517 2.615 33.697 16.029 66.375 36.683 89.321 20.52 22.796 47.78 35.672 79.036 31.538l.186-.024.185-.018c15.165-1.431 37.208-8.863 56.304-22.875 18.957-13.91 34.193-33.664 37.73-59.524.748-5.472 5.791-9.301 11.263-8.553 5.472.749 9.301 5.791 8.553 11.263-3.44 25.148-15.641 45.248-31.134 60.542a9.953 9.953 0 0 1 2.925 4.924c9.898 39.475 35.082 75.882 66.867 107.636 31.596 31.565 69.163 57.979 103.037 77.653 113.864 52.157 218.881 47.824 302.427 8.949 83.831-39.008 146.761-113.123 175.456-201.643 17.813-54.948 38.189-150.49.301-338.522a10.694 10.694 0 0 1-.193-.492C823.484 275.668 783.05 179.815 724.474 115.88 666.657 52.774 590.345 20 469.472 20 349.769 20 254.351 74.32 194.97 159.685Z" fill="#000"/><path d="M137.274 488.518c-25.479-126.039-1.793-243.313 57.696-328.833C254.351 74.321 349.769 20 469.472 20c120.873 0 197.185 32.774 255.002 95.88 58.576 63.935 99.01 159.788 145.594 288.522.061.167.125.331.193.492 37.888 188.032 17.512 283.574-.301 338.522-28.695 88.52-91.625 162.635-175.456 201.643-83.546 38.875-188.563 43.208-302.427-8.949-33.874-19.674-71.441-46.088-103.037-77.653-31.785-31.754-56.969-68.161-66.867-107.636a9.953 9.953 0 0 0-2.925-4.924c15.493-15.294 27.694-35.394 31.134-60.542.748-5.472-3.081-10.514-8.553-11.263-5.472-.748-10.515 3.081-11.263 8.553-3.537 25.86-18.773 45.614-37.73 59.524-19.096 14.012-41.139 21.444-56.304 22.875l-.185.018-.186.024c-31.256 4.134-58.517-8.742-79.036-31.538-20.654-22.946-34.068-55.624-36.683-89.321-3.76-48.468 16.192-97.553 60.445-122.517 27.974-15.78 83.84-18.314 119.066 21.881 3.64 4.153 9.958 4.569 14.111.929 4.154-3.64 4.57-9.958.93-14.111-22.051-25.161-50.487-36.473-77.573-38.872.102-.983.059-1.998-.147-3.019Z" fill="#FFE780"/><path d="M164.972 667c10.5-51.5-23-71-51-71" stroke="#000" stroke-width="20" stroke-linecap="round"/><path d="M567.687 577c9.594 40.283 30.866 81.008 76.617 94.915 43.624 5.671 97.677-15.89 126.168-58.915-43.014-100.846-151.991-107.567-202.785-36Z" fill="#FFA4D4"/><path d="M561.147 533.342c.99 13.535 2.945 28.565 6.54 43.658 50.794-71.567 159.771-64.846 202.785 36 36.821-55.602 37-139 37-139s-2.041-41.93-39-48c-9.1-1.494-20.541 3.692-34.48 10.01-12.218 5.539-26.356 11.948-42.52 15.49-10.028 2.198-19.47-2.579-30.13-7.974-5.969-3.021-12.32-6.234-19.37-8.526-30.164-9.804-65.662-9.111-80.5 46.001 0 0-.609 5.49-.965 14.633a341.596 341.596 0 0 0 .64 37.708Z" fill="#C5C5FF"/><path d="m644.304 671.915-2.908 9.567.795.242.824.107 1.289-9.916Zm-82.832-190.914-9.656-2.6-.199.737-.084.759 9.939 1.104Zm246-7.001 10 .022.001-.254-.013-.254-9.988.486Zm-37 139 8.338 5.522-8.338-5.522Zm-79-161.5-2.141-9.768 2.141 9.768Zm77-25.5-1.62 9.868 1.62-9.868Zm-126.5 9-3.091 9.51 3.091-9.51Zm-74.285 142-9.728 2.317 9.728-2.317Zm93.655-133.474 4.515-8.923-4.515 8.923Zm72.65-7.516 4.128 9.108-4.128-9.108Zm-172.845 97.332-9.973.729 9.973-.729Zm-.64-37.708 9.992.388-9.992-.388ZM807.472 474c-10-.021-10-.023-10-.025v-.001.031l-.001.144-.009.636a166.8 166.8 0 0 1-.064 2.586 279.211 279.211 0 0 1-.506 9.849 352.916 352.916 0 0 1-3.975 33.781c-4.555 27.243-13.504 60.387-30.782 86.478l16.675 11.043c19.542-29.511 29.093-65.867 33.833-94.224a373.031 373.031 0 0 0 4.203-35.718c.305-4.474.461-8.069.541-10.566a188.518 188.518 0 0 0 .083-3.681l.002-.216V474.027c0-.003 0-.005-10-.027Zm-45.337 133.479c-26.313 39.735-76.571 59.715-116.541 54.519l-2.579 19.833c47.278 6.146 105.124-16.994 135.795-63.309l-16.675-11.043Zm4.717-171.611c14.172 2.328 21.645 11.274 25.882 20.56 2.146 4.702 3.355 9.322 4.019 12.802a52.83 52.83 0 0 1 .62 4.055 32.404 32.404 0 0 1 .112 1.221l.001.019-.001-.012v-.011l-.001-.008c0-.003 0-.008 9.988-.494s9.988-.49 9.988-.495l-.001-.01-.001-.023a4.115 4.115 0 0 1-.003-.057l-.01-.161a53.72 53.72 0 0 0-.193-2.165 72.61 72.61 0 0 0-.854-5.611c-.873-4.572-2.484-10.814-5.469-17.353-6.022-13.197-18.05-28.25-40.836-31.993l-3.241 19.736ZM571.128 483.6c6.895-25.609 17.899-36.366 28.581-40.666 11.265-4.535 24.923-3.055 39.172 1.576l6.182-19.02c-15.915-5.173-35.088-8.248-52.822-1.11-18.318 7.374-32.482 24.518-40.425 54.021l19.312 5.199Zm208.543 125.477c-22.737-53.305-63.499-82.772-106.317-88.639-42.696-5.851-86.29 11.982-113.822 50.774l16.31 11.576c23.261-32.775 59.553-47.365 94.797-42.535 35.123 4.813 70.357 29.129 90.635 76.671l18.397-7.847ZM638.881 444.51c6.205 2.017 11.892 4.875 17.945 7.938l9.031-17.845c-5.883-2.977-12.898-6.547-20.794-9.113l-6.182 19.02Zm17.945 7.938c9.781 4.95 22.625 11.924 36.787 8.82l-4.282-19.536c-5.895 1.292-11.933-1.288-23.474-7.129l-9.031 17.845Zm36.787 8.82c17.334-3.799 32.374-10.649 44.507-16.15l-8.257-18.215c-12.302 5.576-25.538 11.543-40.532 14.829l4.282 19.536Zm44.507-16.15c7.113-3.224 12.936-5.851 18.068-7.549 5.188-1.717 8.485-2.059 10.664-1.701l3.241-19.736c-6.922-1.137-13.896.367-20.188 2.45-6.348 2.1-13.215 5.226-20.042 8.321l8.257 18.215ZM557.959 579.317c9.905 41.588 32.599 86.712 83.437 102.165l5.817-19.135c-40.666-12.361-60.515-48.687-69.798-87.664l-19.456 4.634Zm-6.785-45.246c1.019 13.933 3.038 29.513 6.785 45.246l19.456-4.634c-3.443-14.453-5.334-28.934-6.294-42.07l-19.947 1.458Zm10.298-53.07-9.939-1.103v.002l-.001.003v.007a.401.401 0 0 0-.003.022l-.007.066-.024.228a190.914 190.914 0 0 0-.345 3.883 287.942 287.942 0 0 0-.639 11.136l19.985.777c.173-4.428.406-7.955.593-10.353a170.695 170.695 0 0 1 .3-3.387l.016-.151a.285.285 0 0 0 .003-.03l.001-.002-.001.001v.003l-9.939-1.102Zm-10.958 14.244a351.644 351.644 0 0 0 .66 38.826l19.947-1.458a331.64 331.64 0 0 1-.622-36.591l-19.985-.777Zm96.699 167.102c-28.063-8.53-46.071-28.32-57.692-52.585-11.713-24.458-16.629-52.926-18.4-77.149l-19.947 1.458c1.859 25.436 7.075 56.695 20.309 84.33 13.327 27.827 35.082 52.494 69.913 63.081l5.817-19.135Z" fill="#000"/><path d="M491.472 431.5c-5.5-57.041-106-50.5-103.5 6.5M1040.97 392.041C1035.47 335 946.973 335 954.46 397.5" stroke="#000" stroke-width="20" stroke-linecap="round"/><circle cx="216.472" cy="243" r="22" fill="#000"/><circle cx="216.472" cy="243" r="22" fill="#000"/><circle cx="178.472" cy="373" r="22" fill="#000"/><circle cx="178.472" cy="373" r="22" fill="#000"/><circle cx="266.472" cy="340" r="22" fill="#000"/><circle cx="266.472" cy="340" r="22" fill="#000"/><text transform="rotate(19.14 -159.136 875.337)" fill="#000" stroke="#000" xml:space="preserve" style="white-space:pre" font-family="Chalkboard" font-size="80" letter-spacing="0em"><tspan x="0" y="78.889">';
    string svgPartTwo = "</tspan></text></svg>";

    mapping(string => address) public domains;
    mapping(string => string) public records;
    mapping(string => string) public doodleIDs;

    // We make the contract "payable" by adding this to the constructor
    constructor(string memory _tld)
        payable
        ERC721("Dood Name Service", "DOOD")
    {
        tld = _tld;
        console.log("%s name service deployed", _tld);
    }

    // This function will give us the price of a domain based on length
    function price(string calldata name) public pure returns (uint256) {
        uint256 len = StringUtils.strlen(name);
        require(len > 0);
        if (len == 3) {
            return 5 * 10**17; // 5 MATIC = 5 000 000 000 000 000 000 (18 decimals). We're going with 0.5 Matic cause the faucets don't give a lot
        } else if (len == 4) {
            return 3 * 10**17; // To charge smaller amounts, reduce the decimals. This is 0.3
        } else {
            return 1 * 10**17;
        }
    }

    function register(string calldata name) public payable {
        require(domains[name] == address(0));

        uint256 _price = price(name);
        require(msg.value >= _price, "Not enough Matic paid");

        // Combine the name passed into the function  with the TLD
        string memory _name = string(abi.encodePacked(name, ".", tld));
        // Create the SVG (image) for the NFT with the name
        string memory finalSvg = string(
            abi.encodePacked(svgPartOne, _name, svgPartTwo)
        );
        uint256 newRecordId = _tokenIds.current();
        uint256 length = StringUtils.strlen(name);
        string memory strLen = Strings.toString(length);

        console.log(
            "Registering %s.%s on the contract with tokenID %d", // TODO: question: where does %s and %s and %d come from? what does s represent vs d?
            name,
            tld,
            newRecordId
        );

        // Create the JSON metadata of our NFT. We do this by combining strings and encoding as base64
        string memory json = Base64.encode(
            abi.encodePacked(
                '{"name": "',
                _name,
                '", "description": "A domain on the Dood name service", "image": "data:image/svg+xml;base64,',
                Base64.encode(bytes(finalSvg)),
                '","length":"',
                strLen,
                '"}'
            )
        );

        string memory finalTokenUri = string(
            abi.encodePacked("data:application/json;base64,", json)
        );

        console.log(
            "\n--------------------------------------------------------"
        );
        console.log("Final tokenURI", finalTokenUri);
        console.log(
            "--------------------------------------------------------\n"
        );

        _safeMint(msg.sender, newRecordId);
        _setTokenURI(newRecordId, finalTokenUri);
        domains[name] = msg.sender;

        _tokenIds.increment();
    }

    // This will give us the domain owners' address
    function getAddress(string calldata name) public view returns (address) {
        return domains[name];
    }

    function setRecord(string calldata name, string calldata record) public {
        // Check that the owner is the transaction sender
        require(domains[name] == msg.sender);
        records[name] = record;
    }

    function getRecord(string calldata name)
        public
        view
        returns (string memory)
    {
        return records[name];
    }

    function setDoodleID(string calldata name, string calldata doodleID)
        public
    {
        // Check that the owner is the transaction sender
        require(domains[name] == msg.sender);
        doodleIDs[name] = doodleID;
    }

    function getDoodleID(string calldata name)
        public
        view
        returns (string memory)
    {
        return doodleIDs[name];
    }
}
