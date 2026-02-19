# AXOR App - Admin Information

**Last Updated:** February 6, 2026

---

## 👤 ADMIN DETAILS

**Email:** a67154512@gmail.com  
**App Name:** AXOR  
**Role:** Owner, Developer, Support

---

## 📧 CONTACT PURPOSES

### **1. Gift Card Redemption (Premium Activation)**

**Email Subject:** `AXOR Premium - Gift Card Redemption`

**Email Body Template:**
```
Hello AXOR Admin,

I would like to redeem my Amazon Gift Card for premium storage.

Gift Card Code: [YOUR AMAZON GIFT CARD CODE]
Registered Email: [YOUR AXOR APP EMAIL]
Requested Storage: [e.g., 10GB, 50GB, 100GB]

Thank you!
```

**Process:**
1. User purchases Amazon Gift Card
2. User sends code via app's "Send Request" button
3. Backend automatically emails admin (a67154512@gmail.com)
4. Admin verifies code on Amazon
5. Admin calculates storage based on amount
6. Admin replies with storage allocation
7. Backend activates premium for user

**Pricing:**
- $1 = 1GB cloud storage per month
- $10 gift card = 10GB/month
- $50 gift card = 50GB/month
- $100 gift card = 100GB/month

---

### **2. Technical Support**

**Email Subject:** `AXOR Support - [Brief Issue Description]`

**Common Issues:**
- Login problems
- Download failures
- Playback issues
- Storage not updating
- Premium not activating
- App crashes

**Include in Email:**
- Device model (e.g., Samsung Galaxy S21)
- Android version (e.g., Android 13)
- App version (e.g., 1.0.0)
- Screenshot of error (if any)
- Steps to reproduce issue

---

### **3. Bug Reports**

**Email Subject:** `AXOR Bug Report - [Bug Name]`

**Template:**
```
Bug Description: [What's wrong?]
Steps to Reproduce:
1. [First step]
2. [Second step]
3. [Result]

Expected Behavior: [What should happen?]
Actual Behavior: [What actually happens?]

Device: [e.g., Pixel 7]
Android Version: [e.g., Android 14]
App Version: [e.g., 1.0.0]

Screenshots: [Attach if available]
```

---

### **4. Feature Requests**

**Email Subject:** `AXOR Feature Request - [Feature Name]`

**Template:**
```
Feature Name: [e.g., Playlist Sharing]

Description: [Detailed explanation of the feature]

Use Case: [Why is this useful?]

Priority: [Low / Medium / High]

Additional Notes: [Any other details]
```

---

### **5. Premium Issues**

**Email Subject:** `AXOR Premium Issue - [Issue Type]`

**Common Issues:**
- Premium not activated after payment
- Storage not showing correctly
- Cloud sync not working
- Download button not appearing
- Subscription expiration questions

---

## 🎁 GIFT CARD REDEMPTION WORKFLOW

### **User Side:**

1. **Purchase Gift Card**
   - Buy Amazon Gift Card (any amount)
   - Minimum: $1 (1GB)
   - Recommended: $10+ (10GB+)

2. **Open AXOR App**
   - Go to Profile
   - Tap "Unlock Premium"
   - Tap "Send Request"

3. **Enter Details**
   - Paste gift card code
   - Confirm email
   - Submit request

4. **Wait for Activation**
   - Backend sends email to admin
   - Admin verifies within 24-48 hours
   - User receives confirmation email
   - Premium activates automatically

### **Admin Side:**

1. **Receive Email**
   - From: AXOR Backend (automated)
   - Subject: "New Premium Request"
   - Contains: User email, gift card code

2. **Verify Code**
   - Go to Amazon
   - Redeem gift card code
   - Check amount received

3. **Calculate Storage**
   - $1 = 1GB/month
   - Example: $25 = 25GB/month

4. **Reply to User**
   - Email user directly
   - Subject: "AXOR Premium Activated"
   - Body: "Your premium subscription is now active with [X]GB storage."

5. **Update Backend**
   - Backend automatically activates premium
   - User sees cloud storage immediately
   - Subscription starts

---

## 💰 PRICING STRUCTURE

### **Free Plan**
- 1GB local storage
- Basic features
- No cloud sync
- Limited to device storage

### **Premium Plan**
- $1 per GB per month
- Cloud storage (Cloudflare R2)
- Unlimited downloads
- Cross-device sync
- Offline mode
- No ads (future)

### **Example Pricing**
- $5/month = 5GB cloud
- $10/month = 10GB cloud
- $25/month = 25GB cloud
- $50/month = 50GB cloud
- $100/month = 100GB cloud

### **Storage Estimates**
- FLAC: ~30MB per song → 33 songs per GB
- MP3: ~10MB per song → 100 songs per GB
- AAC: ~8MB per song → 125 songs per GB

**Example:**
- 10GB = ~330 FLAC songs or ~1000 MP3 songs
- 50GB = ~1650 FLAC songs or ~5000 MP3 songs

---

## 🔐 ADMIN RESPONSIBILITIES

### **Daily Tasks**
- [ ] Check email for gift card redemptions
- [ ] Verify and redeem gift cards
- [ ] Reply to premium activation requests
- [ ] Monitor backend logs for errors

### **Weekly Tasks**
- [ ] Review user feedback
- [ ] Check storage usage across users
- [ ] Monitor Cloudflare R2 costs
- [ ] Update documentation if needed

### **Monthly Tasks**
- [ ] Review premium subscriptions
- [ ] Calculate revenue vs costs
- [ ] Plan feature updates
- [ ] Backup user data from Google Drive

---

## 🛠️ BACKEND ACCESS

### **Railway Dashboard**
- URL: https://railway.app
- Project: AXOR Backend
- Services: API Server

### **Google Drive**
- Folder: AXOR User Data
- Contains: users.json, subscriptions.json, playlists.json

### **Cloudflare R2**
- Bucket: axor-songs
- Contains: Song files (FLAC, MP3, AAC)
- Access: S3-compatible API

---

## 📊 MONITORING

### **Key Metrics to Track**

1. **User Metrics**
   - Total users
   - Free vs Premium
   - Active users (daily/monthly)
   - Churn rate

2. **Storage Metrics**
   - Total storage used
   - Average per user
   - Growth rate
   - Cost per GB

3. **Financial Metrics**
   - Monthly revenue (gift cards)
   - Monthly costs (R2 + Railway)
   - Profit margin
   - Break-even point

4. **Technical Metrics**
   - API response times
   - Error rates
   - Uptime percentage
   - Download speeds

---

## 🚨 EMERGENCY CONTACTS

**If Admin Unavailable:**
- Backup Email: [Set up backup email]
- Phone: [Optional]
- Alternative Contact: [Optional]

**Critical Issues:**
- Server down
- Data loss
- Security breach
- Payment issues

---

## 📝 NOTES

### **Legal Considerations**
- Gift cards are non-refundable (stated in privacy policy)
- Premium is subscription-based (monthly)
- User can cancel anytime
- No automatic renewals (manual gift card redemption)

### **Customer Service**
- Be professional and friendly
- Respond within 24-48 hours
- Provide clear instructions
- Follow up on issues

### **Privacy**
- Never share user data
- Keep gift card codes confidential
- Secure all communications
- Follow GDPR guidelines (if applicable)

---

## 📞 QUICK REFERENCE

**Admin Email:** a67154512@gmail.com  
**App Name:** AXOR  
**Package:** com.example.axor_app  
**Version:** 1.0.0  

**Support Hours:** 24-48 hour response time  
**Payment Method:** Amazon Gift Cards only  
**Pricing:** $1 per GB per month  

---

**All user communications should reference this email: a67154512@gmail.com**
