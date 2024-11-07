const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const chitietphieuxuatRoutes = require('./routes/chitietphieuxuatRoutes');
const nhanvienRoutes = require('./routes/nhanvienRoutes');
const nhasanxuatRoutes = require('./routes/nhasanxuatRoutes');
const nhacungcapRoutes = require('./routes/nhacungcapRoutes');

const app = express();
app.use(cors());

app.use(bodyParser.json());

app.use('/api/chitietphieuxuat', chitietphieuxuatRoutes);
app.use('/api/nhanvien', nhanvienRoutes);
app.use('/api/nhasanxuat', nhasanxuatRoutes);
app.use('/api/nhacungcap', nhacungcapRoutes);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});