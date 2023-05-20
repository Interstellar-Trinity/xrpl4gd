# ToweRPG_Server

Process the game logic for ToweRPG. Can be roughly segmented into several broad categories. Gameplay, Databasing and XRPL Integrations.

## Gameplay
Placeholder to describe core gameplay systems and client/server communication

## Databasing
Placeholder for describing the usage of our database solution

## XRPL Integrations

### Player Sign In
Placeholder for XUMM wallet sign in flow

### Listening to the XRPL
The server automatically establishes a websocket connection via the "placeholder" script. This websocket is specifically listening for interations with the issuer wallet so the game server can track the state of NFTs as they are minted and offered to the player

### Minting NFTs

The flow for minting an NFT and then transferring it to the player is initiated by a player action on the client, but is generally orchestrated by the server. All the txn sumbissions to the XRPL are handled by the ToweRPG_Backend repo. In this case, the server calls the /mintAndOffer endpoint. Once the NFT is minted and offered, the server picks up the Offer via websocket and sends a formatted NFTokenOfferAccept request to the player's XUMM wallet to finish the transfer.

Once a minted NFT is moved to the player's wallet, separate websocket logic will fire to provision whatever new functionality was provided by the NFT
