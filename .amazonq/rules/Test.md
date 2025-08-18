
// Rules for the application

// 1. Security Rules
const securityRules = {
  // Only authenticated users can access the app
  requireAuth: true,
  
  // Password requirements
  passwordRules: {
    minLength: 8,
    requireUppercase: true, 
    requireLowercase: true,
    requireNumbers: true,
    requireSpecialChars: true
  },
  
  // Session timeout after 30 minutes of inactivity
  sessionTimeout: 30 * 60 * 1000
};

// 2. Data Validation Rules
const validationRules = {
  // Input field validation
  textFields: {
    minLength: 2,
    maxLength: 100,
    allowSpecialChars: false
  },
  
  // Email validation
  email: {
    required: true,
    pattern: /^[^\s@]+@[^\s@]+\.[^\s@]+$/
  },
  
  // Phone number validation
  phone: {
    required: true,
    pattern: /^\+?[\d\s-]{10,}$/
  }
};

// 3. Business Logic Rules
const businessRules = {
  // Operating hours
  operatingHours: {
    start: '09:00',
    end: '17:00',
    timezone: 'UTC'
  },
  
  // Rate limiting
  rateLimit: {
    maxRequests: 100,
    timeWindow: 60 * 1000 // 1 minute
  },
  
  // Data retention
  dataRetention: {
    userDataDays: 365,
    logDataDays: 90,
    tempDataHours: 24
  }
};

// 4. Error Handling Rules
const errorRules = {
  maxRetries: 3,
  retryDelay: 1000, // milliseconds
  logErrors: true,
  notifyAdmin: true
};

// Export all rules
module.exports = {
  securityRules,
  validationRules,
  businessRules,
  errorRules
};