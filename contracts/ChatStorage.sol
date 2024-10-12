// SPDX-License-Identifier: MIT
pragma solidity 0.8.6;

contract ChatStorage {
    // Contador de mensajes
    uint256 public messagesCounter;

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
    constructor() {
        messagesCounter = 0; // Inicializa el contador de mensajes
    }

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
        return messagesCounter; // Retorna el contador de mensajes
    }

    // Nueva función para obtener todos los mensajes
    function getAllMessages()
        public
        view
        returns (string[] memory, uint256[] memory)
    {
        string[] memory contents = new string[](messagesCounter);
        uint256[] memory timestamps = new uint256[](messagesCounter);

        for (uint256 i = 1; i <= messagesCounter; i++) {
            Message storage message = messages[i];
            contents[i - 1] = message.content; // Guarda el contenido del mensaje
            timestamps[i - 1] = message.timestamp; // Guarda el timestamp del mensaje
        }

        return (contents, timestamps); // Retorna los arrays con contenidos y timestamps
    }
}
