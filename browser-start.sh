#!/bin/bash

# Browser-Tools-MCP Compound Startup Script
# Starts both middleware server and MCP server for Rick's local fork

# Silent mode option - set to 1 to suppress output
SILENT_MODE=${1:-0}

log() {
    if [ "$SILENT_MODE" = "0" ]; then
        echo "$1"
    fi
}

log "🚀 Starting Browser-Tools-MCP Compound Servers..."
log "==============================================="

# Set the base directory to Rick's local fork
BASE_DIR="$HOME/dev/mcp/browser-tools-mcp"

# Check if base directory exists
if [ ! -d "$BASE_DIR" ]; then
    log "❌ Error: Browser-tools-mcp directory not found at $BASE_DIR"
    exit 1
fi

# Function to cleanup processes on exit
cleanup() {
    log "🛑 Shutting down servers..."
    kill $MIDDLEWARE_PID 2>/dev/null
    kill $MCP_PID 2>/dev/null
    log "✅ Cleanup complete"
    exit 0
}

# Set trap for cleanup on script exit
trap cleanup EXIT INT TERM

# Start the middleware server (browser-tools-server)
log "🔧 Starting Browser-Tools Middleware Server..."
cd "$BASE_DIR/browser-tools-server"

# Check if npm start is available, fallback to direct node command
if npm run start > /dev/null 2>&1 &
then
    MIDDLEWARE_PID=$!
    log "✅ Middleware server started (PID: $MIDDLEWARE_PID)"
else
    log "📋 npm start failed, trying direct node command..."
    if [ -f "dist/browser-connector.js" ]; then
        node dist/browser-connector.js > /dev/null 2>&1 &
        MIDDLEWARE_PID=$!
        log "✅ Middleware server started via node (PID: $MIDDLEWARE_PID)"
    else
        log "❌ Error: browser-connector.js not found. Run 'npm run build' first."
        exit 1
    fi
fi

# Wait a moment for middleware to initialize
sleep 2

# Start the MCP server
log "🔗 Starting Browser-Tools MCP Server..."
cd "$BASE_DIR/browser-tools-mcp"

if [ -f "dist/mcp-server.js" ]; then
    node dist/mcp-server.js &
    MCP_PID=$!
    log "✅ MCP server started (PID: $MCP_PID)"
else
    log "❌ Error: mcp-server.js not found. Run 'npm run build' first."
    kill $MIDDLEWARE_PID
    exit 1
fi

log "==============================================="
log "🎉 Both servers are running!"
log "📊 Middleware Server PID: $MIDDLEWARE_PID"
log "🔗 MCP Server PID: $MCP_PID"
log ""
log "🌐 Open Chrome DevTools and check BrowserToolsMCP panel"
log "🎯 Claude Desktop should now detect browser-tools-mcp"
log ""
log "💡 Press Ctrl+C to stop both servers"
log "==============================================="

# Keep script running and wait for both processes
wait

