import './App.css';

import { ethers, Contract, BigNumber } from 'ethers';

import { useState } from 'react';
import NavBar from './NavBar';

const { abi } = require('./artifacts/contracts/BlockHead.json');

//LATEST RINKEBY 0x61E8ee7458Cb3aC7398c024689607de3FC073D41
//LATEST RINKEBY 0xd6ACa905E045c0A7c91493e16bD7728DF2B8C16d
const blockHeadsAddress = '0xd6ACa905E045c0A7c91493e16bD7728DF2B8C16d';

//eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJkaWQ6ZXRocjoweDc3ZTlBQzc2OUIzNkQ2M0E4RWJmNTgzRGNjMjc4QWZhZmI3NTY4NjUiLCJpc3MiOiJuZnQtc3RvcmFnZSIsImlhdCI6MTY0NjgyNDA2MzM5NSwibmFtZSI6IkJsb2NrSGVhZHMifQ._cBQ13lhThp41TgZquK76bVzOSgK-_IOkuOIzGmobH0

function App() {
    const [accounts, setAccounts] = useState([]);
    const [mintAmount, setMintAmount] = useState(1);
    const isConnected = Boolean(accounts[0]);

    async function handleMint() {
        if (window.ethereum) {
            const provider = new ethers.providers.Web3Provider(window.ethereum);
            const signer = provider.getSigner();
            const contract = new Contract(blockHeadsAddress, abi, signer);

            try {
                const response = await contract.mint({
                    value: ethers.utils.parseEther(
                        (0.1 * mintAmount).toString(),
                    ),
                });
                console.log(response);
            } catch (err) {
                console.log(`err: ${err}`);
            }
        }
    }

    async function getCollectibles() {
        if (window.ethereum) {
            const provider = new ethers.providers.Web3Provider(window.ethereum);
            const signer = provider.getSigner();
            const contract = new Contract(blockHeadsAddress, abi, signer);

            try {
                const response = await contract.test();
                console.log(response);
            } catch (err) {
                console.log(`err: ${err}`);
            }
        }
    }

    const handleMintAmountChange = (amt) => {
        if (mintAmount <= 1 && amt === -1) return;
        if (mintAmount >= 4 && amt === 1) return;
        setMintAmount(mintAmount + amt);
    };

    return (
        <div className='App'>
            <NavBar accounts={accounts} setAccounts={setAccounts} />
            <div>
                <h1>Block Heads</h1>
                <p>This is a rugpull project.</p>

                {isConnected ? (
                    <div>
                        <div>
                            <button
                                onClick={() => {
                                    handleMintAmountChange(-1);
                                }}
                            >
                                -
                            </button>
                            <div>{mintAmount}</div>
                            <button
                                onClick={() => {
                                    handleMintAmountChange(1);
                                }}
                            >
                                +
                            </button>
                        </div>
                        <button onClick={handleMint}>Mint!</button>
                        <button onClick={getCollectibles}>Test</button>
                    </div>
                ) : (
                    <div>Connect your wallet to mint a Block Head!</div>
                )}
            </div>
        </div>
    );
}

export default App;
