// Chrome Extension Settings Diagnostic
// Paste this into the BrowserTools MCP panel console to check settings

console.log('=== BrowserTools MCP Extension Diagnostic ===');

// Check stored settings
chrome.storage.local.get(['browserConnectorSettings'], (result) => {
    console.log('📋 Current Extension Settings:');
    console.log(JSON.stringify(result.browserConnectorSettings || 'No settings found', null, 2));
    
    const settings = result.browserConnectorSettings || {
        serverHost: 'localhost',
        serverPort: 3025
    };
    
    console.log(`🌐 Target Server: ${settings.serverHost}:${settings.serverPort}`);
    
    // Test server connection
    fetch(`http://${settings.serverHost}:${settings.serverPort}/.identity`)
        .then(response => response.json())
        .then(data => {
            console.log('✅ Server Identity Response:');
            console.log(JSON.stringify(data, null, 2));
            if (data.signature === 'mcp-browser-connector-24x7') {
                console.log('🎉 Server signature VALID - connection should work!');
            } else {
                console.log('❌ Server signature INVALID - wrong server type');
            }
        })
        .catch(error => {
            console.log('❌ Server Connection FAILED:');
            console.log(error.message);
            console.log('💡 Make sure middleware server is running on port 3025');
        });
});

console.log('=== End Diagnostic ===');
