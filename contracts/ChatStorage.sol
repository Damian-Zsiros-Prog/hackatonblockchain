// SPDX-License-Identifier: MIT
pragma solidity 0.8.6;

contract ChatStorage {
    uint256 public messagesCounter = 0;

    // Estructura para representar un mensaje
    struct Message {
        uint256 id; // Identificador del mensaje
        address sender; // Dirección del remitente
        string content; // Contenido del mensaje
        uint256 timestamp; // Marca de tiempo del mensaje
    }

    // Evento que se emite cuando se envía un mensaje
    event MessageSent(
        uint256 indexed id, // ID del mensaje
        address indexed sender, // Dirección del remitente
        string content, // Contenido del mensaje
        uint256 timestamp // Marca de tiempo del mensaje
    );

    // Mapeo para almacenar los mensajes por ID
    mapping(uint256 => Message) public messages;

    // Constructor
    constructor() {}

    // Función para enviar un mensaje
    function sendMessage(string memory _content) public {
        messagesCounter++; // Incrementa el contador de mensajes
        messages[messagesCounter] = Message(
            messagesCounter,
            msg.sender,
            _content,
            block.timestamp
        ); // Crea un nuevo mensaje
        emit MessageSent(
            messagesCounter,
            msg.sender,
            _content,
            block.timestamp
        ); // Emitir evento de mensaje enviado
    }

    // Función para obtener un mensaje por su ID
    function getMessage(
        uint256 _id
    ) public view returns (address, string memory, uint256) {
        Message memory _message = messages[_id];
        return (_message.sender, _message.content, _message.timestamp); // Retorna el remitente, contenido y timestamp del mensaje
    }

    // Función para obtener la cantidad total de mensajes
    function getMessageCount() public view returns (uint256) {
        // Retorna el contador de mensajes
        return messagesCounter;
    }

    // Opcional: función para obtener el contador como un entero en formato string
    function getMessageCountAsString() public view returns (string memory) {
        return uintToString(messagesCounter); // Convierte a string (si es necesario)
    }

    // Función auxiliar para convertir uint a string
    function uintToString(
        uint256 _value
    ) internal pure returns (string memory) {
        if (_value == 0) {
            return "0";
        }
        uint256 temp = _value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        uint256 index = digits - 1;
        temp = _value;
        while (temp != 0) {
            buffer[index--] = bytes1(uint8(48 + (temp % 10)));
            temp /= 10;
        }
        return string(buffer);
    }
}
