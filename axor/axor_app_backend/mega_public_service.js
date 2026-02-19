const { File } = require('megajs');

/**
 * MEGA Public Folder Service
 * Uses public folder link - NO authentication needed!
 * Much more reliable than authenticated access
 */
class MegaPublicService {
  constructor(publicFolderUrl) {
    this.publicFolderUrl = publicFolderUrl;
    this.folder = null;
    this.connected = false;
  }

  /**
   * Load public folder (no login needed!)
   */
  async loadFolder() {
    try {
      console.log('🔐 Loading MEGA public folder...');
      console.log(`📂 URL: ${this.publicFolderUrl}`);
      
      // Load public folder directly - File.fromURL handles the full URL
      this.folder = File.fromURL(this.publicFolderUrl);
      
      // Wait for folder to load
      await new Promise((resolve, reject) => {
        const timeout = setTimeout(() => {
          reject(new Error('Timeout loading folder'));
        }, 30000);
        
        this.folder.loadAttributes((error) => {
          clearTimeout(timeout);
          if (error) {
            reject(error);
          } else {
            resolve();
          }
        });
      });
      
      this.connected = true;
      console.log('✅ Public folder loaded successfully');
      console.log(`📁 Folder name: ${this.folder.name || 'Music'}`);
      
      return true;
    } catch (error) {
      console.error('❌ Failed to load public folder:', error.message);
      console.error('💡 Make sure the URL is correct and the folder is public');
      this.connected = false;
      return false;
    }
  }

  /**
   * List all FLAC files in the public folder
   */
  async listFiles() {
    if (!this.connected) {
      throw new Error('Folder not loaded. Call loadFolder() first.');
    }

    try {
      console.log('🔍 Scanning public folder for FLAC files...');
      
      const songs = [];
      let count = 0;

      // Get all children (files) in the folder
      const children = this.folder.children || [];
      
      console.log(`📂 Found ${children.length} items in folder`);
      
      for (const file of children) {
        if (file.name && file.name.endsWith('.flac')) {
          count++;
          
          // Generate public download link
          let link;
          try {
            link = await file.link({ noKey: false });
          } catch (error) {
            console.log(`⚠️  Could not generate link for ${file.name}, using file object`);
            link = null;
          }
          
          songs.push({
            id: `mega_public_${file.nodeId || count}`,
            name: file.name,
            size: file.size,
            megaUrl: link,
            megaFile: file
          });

          if (count <= 5) {
            console.log(`✅ ${count}. ${file.name} (${(file.size / 1024 / 1024).toFixed(1)} MB)`);
          }
        }
      }

      if (count > 5) {
        console.log(`   ... and ${count - 5} more files`);
      }

      console.log(`\n🎵 Found ${songs.length} FLAC files in public folder`);
      return songs;
      
    } catch (error) {
      console.error('❌ Error listing files:', error.message);
      console.error('Stack:', error.stack);
      return [];
    }
  }

  /**
   * Get download stream for a file
   */
  async streamFile(megaFile) {
    try {
      return megaFile.download();
    } catch (error) {
      console.error('❌ Error streaming file:', error.message);
      throw error;
    }
  }

  /**
   * Check if connected
   */
  isConnected() {
    return this.connected;
  }
}

module.exports = MegaPublicService;
