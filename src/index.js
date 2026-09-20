const express = require('express');
const router = require('./router');

const app = express();
const PORT = process.env.PORT || 3000;

app.disable('x-powered-by');
app.use(router);

app.get('/', (req, res) => {
  res.send('🚀 Deployment Successful! Welcome to the Node.js API.');
});

if (require.main === module) {
  app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
  });
}

module.exports = app;
