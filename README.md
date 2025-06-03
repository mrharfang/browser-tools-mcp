# Browser Tools MCP - Enhanced Fork 🚀

[![Model Context Protocol](https://img.shields.io/badge/MCP-Compatible-blue)](https://modelcontextprotocol.io)
[![TypeScript](https://img.shields.io/badge/TypeScript-007ACC?logo=typescript&logoColor=white)](https://www.typescriptlang.org/)
[![Chrome Extension](https://img.shields.io/badge/Chrome-Extension-4285F4?logo=googlechrome&logoColor=white)](https://developer.chrome.com/docs/extensions/)

A powerful Model Context Protocol (MCP) server that enables AI assistants to interact with web browsers and perform advanced web automation tasks. **This fork adds video downloading capabilities** and enhanced functionality to the original browser-tools-mcp.

## 🆕 Fork Enhancements

This fork adds the following features to the original browser-tools-mcp:

### 📹 Video Download Tool
- **Download videos from any supported website** using the `downloadVideo` tool
- **Smart URL detection** - automatically uses current tab URL or accepts custom URLs
- **Quality selection** - defaults to 720p but supports various quality options
- **Background downloads** - non-blocking downloads with progress tracking
- **Organized storage** - saves to `~/VideoGrabs/` directory by default
- **Comprehensive error handling** - detailed feedback for troubleshooting

### 🛠️ Technical Improvements
- Enhanced TypeScript configurations
- Additional dependencies: `ytdl-core`, `fs-extra`
- Improved error handling and user feedback
- Better console logging for debugging

## 🔧 Quick Setup

1. **Install dependencies:**
   ```bash
   # Install browser-tools-server dependencies
   cd browser-tools-server
   npm install

   # Install MCP server dependencies
   cd ../browser-tools-mcp
   npm install
   ```

2. **Build both components:**
   ```bash
   # Build browser-tools-server
   cd browser-tools-server
   npm run build

   # Build MCP server
   cd ../browser-tools-mcp
   npm run build
   ```

3. **Configure Claude Desktop:**
   Add to your `claude_desktop_config.json`:
   ```json
   {
     "mcpServers": {
       "browser-tools": {
         "command": "node",
         "args": ["/Users/rickbarraza/dev/mcp/browser-tools-mcp/browser-tools-mcp/build/mcp-server.js"],
         "env": {
           "BROWSER_WS_ENDPOINT": "ws://localhost:8080"
         }
       }
     }
   }
   ```

4. **Start the browser server:**
   ```bash
   cd browser-tools-server
   npm start
   ```

5. **Install Chrome extension:**
   - Open Chrome → Extensions → Developer mode
   - Load unpacked → Select `chrome-extension` folder

## 🎯 Available Tools

### Original Tools
- **screenshot** - Capture webpage screenshots
- **getPageContent** - Extract text content from pages
- **navigate** - Navigate to URLs
- **click** - Click elements on pages
- **type** - Input text into form fields
- **scroll** - Scroll pages
- **waitForElement** - Wait for elements to appear

### 🆕 New: Video Download Tool
```typescript
downloadVideo({
  url?: string,        // Optional: defaults to current tab URL
  quality?: string,    // Optional: defaults to "720p"
  outputDir?: string   // Optional: defaults to "~/VideoGrabs/"
})
```

**Example usage:**
- `downloadVideo()` - Downloads video from current tab in 720p to ~/VideoGrabs/
- `downloadVideo({ url: "https://youtube.com/watch?v=...", quality: "1080p" })`

## 📁 Project Structure

```
browser-tools-mcp/
├── browser-tools-server/     # Backend server with Puppeteer
│   ├── browser-connector.ts  # 🆕 Enhanced with video download endpoint
│   ├── package.json         # 🆕 Added ytdl-core, fs-extra
│   └── ...
├── browser-tools-mcp/       # MCP server implementation
│   ├── mcp-server.ts        # 🆕 Added downloadVideo tool
│   ├── package.json         # 🆕 Updated dependencies
│   └── ...
├── chrome-extension/        # Chrome extension for browser control
└── docs/                    # Documentation
```

## 🎬 Video Download Feature Details

The video download functionality is implemented across two components:

### Backend (browser-tools-server)
- **Endpoint:** `POST /download-video`
- **Technology:** ytdl-core for video extraction
- **Storage:** fs-extra for file system operations
- **Progress:** Real-time console logging

### MCP Interface (browser-tools-mcp)
- **Tool name:** `downloadVideo`
- **Smart defaults:** 720p quality, ~/VideoGrabs/ directory
- **Error handling:** Comprehensive validation and feedback
- **User feedback:** Emoji-rich status messages

## 🔗 Original Project

This is a fork of the original [browser-tools-mcp](https://github.com/modelcontextprotocol/create-python-server) project. The original project provides excellent browser automation capabilities, and this fork extends it with video downloading functionality.

### Changes from Original
- ✅ Added video downloading with ytdl-core
- ✅ Enhanced error handling and user feedback
- ✅ Improved TypeScript configurations
- ✅ Added comprehensive documentation
- ✅ Organized file structure with clear separation of concerns

## 🛡️ Requirements

- **Node.js** 18+ 
- **Chrome/Chromium** browser
- **Claude Desktop** (for MCP integration)
- **Internet connection** (for video downloads)

## 🚀 Usage Examples

### Download from Current Tab
```
Just ask Claude: "Download the video from this page"
```

### Download with Specific Quality
```
Ask Claude: "Download this YouTube video in 1080p quality"
```

### Download to Custom Directory
```
Ask Claude: "Download this video to my Desktop folder"
```

## 🤝 Contributing

This fork welcomes contributions! Feel free to:
- Report bugs or suggest features via Issues
- Submit Pull Requests for improvements
- Enhance documentation
- Add support for additional video platforms

## 📜 License

This project maintains the same license as the original browser-tools-mcp project.

## 🙏 Acknowledgments

- Original browser-tools-mcp developers for the excellent foundation
- Model Context Protocol team for the MCP specification
- ytdl-core maintainers for robust video downloading capabilities

---

**🔧 Fork maintained by:** [@rickbarraza](https://github.com/rickbarraza)  
**📅 Enhanced:** January 2025  
**🌟 Original:** [browser-tools-mcp](https://github.com/modelcontextprotocol/create-python-server)
