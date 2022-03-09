import React from 'react';

export default function NavBar({ accounts, setAccounts }) {
    const isConnected = Boolean(accounts[0]);

    async function connectAccount() {
        if (window.ethereum) {
            const accounts = await window.ethereum.request({
                method: 'eth_requestAccounts',
            });

            setAccounts(accounts);
        }
    }
    return (
        <div>
            {/*Left Side*/}
            <div>Some Link</div>
            {/*Right Side*/}
            <div>Mint</div>
            {/*Connect*/}
            {isConnected ? (
                <p>Connected</p>
            ) : (
                <button onClick={connectAccount}>Connect Wallet</button>
            )}
        </div>
    );
}
