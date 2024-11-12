const DiaryEntry = require('../models/DiaryEntry');

// Create a new entry
exports.createEntry = async (req, res) => {
    const { title, content } = req.body;
    try {
        const newEntry = new DiaryEntry({ title, content });
        await newEntry.save();
        res.status(201).json(newEntry);
    } catch (err) {
        res.status(500).json({ message: 'Error creating entry', error: err });
    }
};

// Get all entries
exports.getEntries = async (req, res) => {
    try {
        const entries = await DiaryEntry.find();
        res.status(200).json(entries);
    } catch (err) {
        res.status(500).json({ message: 'Error fetching entries', error: err });
    }
};

// Update an entry
exports.updateEntry = async (req, res) => {
    const { id } = req.params;
    const { title, content } = req.body;
    try {
        const updatedEntry = await DiaryEntry.findByIdAndUpdate(id, { title, content, updatedAt: Date.now() }, { new: true });
        if (!updatedEntry) return res.status(404).json({ message: 'Entry not found' });
        res.status(200).json(updatedEntry);
    } catch (err) {
        res.status(500).json({ message: 'Error updating entry', error: err });
    }
};

// Delete an entry
exports.deleteEntry = async (req, res) => {
    const { id } = req.params;
    try {
        const deletedEntry = await DiaryEntry.findByIdAndDelete(id);
        if (!deletedEntry) return res.status(404).json({ message: 'Entry not found' });
        res.status(200).json({ message: 'Entry deleted successfully' });
    } catch (err) {
        res.status(500).json({ message: 'Error deleting entry', error: err });
    }
};
