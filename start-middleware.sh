#!/bin/bash

# Browser-Tools Middleware Server Startup Script
# Only starts the middleware server - Claude Desktop handles the MCP server

echo "🚀 Starting Browser-Tools Middleware Server..."
echo "============================================="

# Set the base directory to Rick's local fork
BASE_DIR="$HOME/dev/mcp/browser-tools-mcp"

# Check if base directory exists
if [ ! -d "$BASE_DIR" ]; then
    echo "❌ Error: Browser-tools-mcp directory not found at $BASE_DIR"
    exit 1
fi

# Function to cleanup processes on exit
cleanup() {
    echo "🛑 Shutting down middleware server..."
    kill $MIDDLEWARE_PID 2>/dev/null
    echo "✅ Cleanup complete"
    exit 0
}

# Set trap for cleanup on script exit
trap cleanup EXIT INT TERM

# Start the middleware server (browser-tools-server)
echo "🔧 Starting Browser-Tools Middleware Server..."
cd "$BASE_DIR/browser-tools-server"

# Check if npm start is available, fallback to direct node command
if npm run start &
then
    MIDDLEWARE_PID=$!
    echo "✅ Middleware server started (PID: $MIDDLEWARE_PID)"
else
    echo "📋 npm start failed, trying direct node command..."
    if [ -f "dist/browser-connector.js" ]; then
        node dist/browser-connector.js &
        MIDDLEWARE_PID=$!
        echo "✅ Middleware server started via node (PID: $MIDDLEWARE_PID)"
    else
        echo "❌ Error: browser-connector.js not found. Run 'npm run build' first."
        exit 1
    fi
fi

echo "============================================="
echo "🎉 Middleware server is running!"
echo "📊 Middleware Server PID: $MIDDLEWARE_PID"
echo ""
echo "🌐 Open Chrome DevTools and check BrowserToolsMCP panel"
echo "🎯 Claude Desktop will connect to this middleware server"
echo ""
echo "💡 Press Ctrl+C to stop the server"
echo "============================================="

# Keep script running and wait for the process
wait
