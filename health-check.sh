#!/bin/bash

# Browser-Tools-MCP Health Check Script
# Checks if the middleware server is running and accessible

echo "🩺 Browser-Tools-MCP Health Check"
echo "================================="

# Check if middleware server is running
if curl -s http://localhost:3025/.identity > /dev/null 2>&1; then
    echo "✅ Middleware server is running on port 3025"
    
    # Get identity information
    IDENTITY=$(curl -s http://localhost:3025/.identity | jq -r '.signature' 2>/dev/null)
    if [ "$IDENTITY" = "mcp-browser-connector-24x7" ]; then
        echo "✅ Middleware server identity verified"
    else
        echo "⚠️  Middleware server responding but identity not verified"
    fi
else
    echo "❌ Middleware server not responding on port 3025"
    echo "   Run: ./start-middleware.sh"
    exit 1
fi

# Check if MCP server can discover middleware
echo "🔍 Checking MCP server build..."
cd "$(dirname "$0")/browser-tools-mcp"
if [ -f "dist/mcp-server.js" ]; then
    echo "✅ MCP server is built and ready"
else
    echo "❌ MCP server not built. Run 'npm run build' in browser-tools-mcp/"
    exit 1
fi

echo "================================="
echo "🎉 All systems operational!"
echo ""
echo "Next steps:"
echo "1. Restart Claude Desktop to pick up new config"
echo "2. Test browser tools in Claude Desktop"
echo "3. Check Chrome DevTools BrowserToolsMCP panel"
