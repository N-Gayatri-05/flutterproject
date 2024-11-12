const mongoose = require('mongoose');

const diaryEntrySchema = new mongoose.Schema({
    title: { type: String, required: true },
    content: { type: String, required: true },
});

module.exports = mongoose.model('DiaryEntry', diaryEntrySchema);
