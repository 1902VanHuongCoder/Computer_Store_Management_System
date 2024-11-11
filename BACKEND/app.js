const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const chitietphieuxuatRoutes = require('./routes/chitietphieuxuatRoutes');
const nhanvienRoutes = require('./routes/nhanvienRoutes');
const nhasanxuatRoutes = require('./routes/nhasanxuatRoutes');
const nhacungcapRoutes = require('./routes/nhacungcapRoutes');
const loaithietbiRoutes = require('./routes/loaithietbiRoutes');
const khachhangRoutes = require('./routes/khachhangRoutes');
const thietbiRoutes = require('./routes/thietbiRoutes');
const phieunhapRoutes = require('./routes/phieunhapRoutes');
const chitietphieunhapRoutes = require('./routes/chitietphieunhapRoutes');
const phieuxuatRoutes = require('./routes/phieuxuatRoutes');

const app = express();
app.use(cors());

app.use(bodyParser.json());

app.use('/api/chitietphieuxuat', chitietphieuxuatRoutes);
app.use('/api/phieuxuat', phieuxuatRoutes);
app.use('/api/nhanvien', nhanvienRoutes);
app.use('/api/nhasanxuat', nhasanxuatRoutes);
app.use('/api/nhacungcap', nhacungcapRoutes);
app.use('/api/loaithietbi', loaithietbiRoutes);
app.use('/api/khachhang', khachhangRoutes);
app.use('/api/thietbi', thietbiRoutes);
app.use('/api/phieunhap', phieunhapRoutes);
app.use('/api/chitietphieunhap', chitietphieunhapRoutes);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});