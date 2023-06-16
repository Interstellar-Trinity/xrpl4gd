# Xrpl4gd

This plugin provides an in-engine way for developers to start integrating their games with the XRP Ledger. The XRP Ledger (XRPL) is a high throughput, low fee cryptocurrency network. It supports most fuctions game developers would find desireable to integrate with their games such as payments, custom tokens, and NFTs. The plugin abstracts away much of the complexity surrounding connecting to the XRPL and gives Godot developers a set of simple tools that can be used for the most common integration patterns. The plugin supports several crypto wallets both smartphone and in-browser.

## Dev Onboarding

## Features:

### Player Wallets:

#### XUMM

##### Setup -

#### CROSSMARK

##### Setup -

#### Gem Wallet

### Ledger Utilities:

### Wallet Info
Pulls down general info about the player wallet. Can be used to check to make sure the player has enough funds 

### Get NFTs
If a game is making use of NFTs as items, the game server will need to reach out to the player's wallet to check for all the items in the player's inventory. Get NFTs accepts a wallet address and an issuer address and returns a list of all the matching NFTIDs and their respective URIs. Devs can loop through this list to provision items based on what is in the player's wallet.

### Check For NFT
NFTs can be used for exclusive access to content or other scarce items. If the NFTID is already known, this function will get its information from the player wallet or return null if the player doesn't own that specific NFT. 

# ToweRPG_Server

Process the game logic for ToweRPG. Can be roughly segmented into several broad categories. Gameplay, Databasing and XRPL Integrations. The xrpl4gd plugin and the backend for the demo will eventually be split out into different repos.

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
