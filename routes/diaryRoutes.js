const express = require('express');
const router = express.Router();
const diaryController = require('../controllers/diaryController');

// Routes for CRUD operations
router.post('/add', diaryController.createEntry);
router.get('/', diaryController.getEntries);
router.put('/:id', diaryController.updateEntry);
router.delete('/:id', diaryController.deleteEntry);

module.exports = router;
