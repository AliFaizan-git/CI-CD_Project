const express = require('express');
const router = express.Router();
const controller = require('./controller');

router.get('/posts', controller.getPosts);

router.get('/', (req, res) => {
  res.send('🚀 Deployment Successful! Welcome to the Node.js API.');
});

module.exports = router;
