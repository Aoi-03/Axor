const { Storage } = require('megajs');

/**
 * MEGA Cloud Storage Service
 * Uses megajs library - works on any Node.js server (deployment-ready)
 * No system dependencies required - perfect for Heroku, AWS, Vercel, etc.
 */
class MegaService {
  constructor(email, password) {
    this.email = email;
    this.password = password;
    this.storage = null;
    this.connected = false;
  }

  /**
   * Login to MEGA account
   */
  async login() {
    try {
      console.log('Connecting to MEGA Cloud...');
      
      this.storage = await new Storage({
        email: this.email,
        password: this.password,
        autoload: true,
        autologin: true
      }).ready;
      
      this.connected = true;
      console.log('Connected to MEGA successfully');
      console.log(`Account: ${this.email}`);
      
      return true;
    } catch (error) {
      console.error('MEGA login failed:', error.message);
      console.error('Check your email and password in .env file');
      this.connected = false;
      return false;
    }
  }

  /**
   * List all FLAC files in a specific folder
   */
  async listFiles(folderName = 'AxorMusic') {
    if (!this.connected) {
      throw new Error('Not connected to MEGA. Call login() first.');
    }

    try {
      console.log(`🔍 Scanning MEGA folder: /${folderName}`);
      
      // Find the folder in root
      const folder = this.storage.root.children.find(f => f.name === folderName && f.directory);
      
      if (!folder) {
        console.log(`⚠️  Folder "/${folderName}" not found.`);
        console.log('📁 Available folders:');
        this.storage.root.children.forEach(f => {
          if (f.directory) console.log(`   - ${f.name}`);
        });
        console.log('\n💡 Create folder in MEGA: https://mega.nz');
        return [];
      }

      const songs = [];
      let count = 0;

      // Scan all files in folder
      for (const file of folder.children) {
        if (file.name.endsWith('.flac') && !file.directory) {
          count++;
          
          // Generate download link (cached for 24 hours)
          const link = await file.link();
          
          songs.push({
            id: `mega_${file.nodeId}`,
            name: file.name,
            size: file.size,
            megaNodeId: file.nodeId,
            megaUrl: link,
            megaFile: file // Keep reference for streaming
          });

          if (count <= 5) {
            console.log(`✅ ${count}. ${file.name} (${(file.size / 1024 / 1024).toFixed(1)} MB)`);
          }
        }
      }

      if (count > 5) {
        console.log(`   ... and ${count - 5} more files`);
      }

      console.log(`\n🎵 Found ${songs.length} FLAC files in MEGA`);
      return songs;
      
    } catch (error) {
      console.error('❌ Error listing MEGA files:', error.message);
      return [];
    }
  }

  /**
   * Get download URL for a specific file
   */
  async getDownloadUrl(nodeId) {
    if (!this.connected) {
      throw new Error('Not connected to MEGA');
    }

    try {
      const file = this.storage.files[nodeId];
      if (!file) {
        throw new Error('File not found');
      }
      
      // Generate link with retry logic
      let retries = 3;
      while (retries > 0) {
        try {
          const link = await file.link({ noKey: false });
          return link;
        } catch (error) {
          retries--;
          if (retries === 0) throw error;
          console.log(`⚠️  Retry getting download URL (${retries} left)...`);
          await new Promise(resolve => setTimeout(resolve, 1000));
        }
      }
    } catch (error) {
      console.error('❌ Error getting download URL:', error.message);
      throw error;
    }
  }

  /**
   * Stream file from MEGA (returns readable stream)
   */
  async streamFile(nodeId) {
    if (!this.connected) {
      throw new Error('Not connected to MEGA');
    }

    try {
      const file = this.storage.files[nodeId];
      if (!file) {
        throw new Error('File not found');
      }
      
      // Returns a readable stream
      return file.download();
    } catch (error) {
      console.error('❌ Error streaming file:', error.message);
      throw error;
    }
  }

  /**
   * Get file metadata
   */
  getFileInfo(nodeId) {
    if (!this.connected) {
      throw new Error('Not connected to MEGA');
    }

    const file = this.storage.files[nodeId];
    if (!file) {
      return null;
    }

    return {
      name: file.name,
      size: file.size,
      nodeId: file.nodeId,
      directory: file.directory
    };
  }

  /**
   * Check if connected
   */
  isConnected() {
    return this.connected;
  }

  /**
   * Logout from MEGA
   */
  async logout() {
    if (this.storage) {
      this.storage.close();
      this.connected = false;
      console.log('✅ Disconnected from MEGA');
    }
  }
}

module.exports = MegaService;
