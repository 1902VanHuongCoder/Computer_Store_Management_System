<template>
    <div class="flex justify-center items-center min-h-screen bg-gradient-to-r from-blue-secondary to-blue-light p-4">
        <div class="w-full max-w-4xl">
            <div class="bg-white rounded-xl shadow-lg overflow-hidden">
                <div class="flex flex-col md:flex-row">
                    <div class="hidden md:block w-1/2 bg-blue-secondary p-12">
                        <img src="../../assets/img/img-logout.png" class="w-full h-full object-cover rounded-xl"
                            alt="Login illustration" />
                    </div>
                    <div class="w-full md:w-1/2 p-8 md:p-12">
                        <h1 class="text-2xl md:text-3xl font-bold text-center text-gray-800 mb-2">
                            THÊM NHÂN VIÊN
                        </h1>
                        <p class="text-md md:text-lg font-medium text-center text-gray-600 mb-8">
                            Vui lòng điền thông tin để đăng ký!
                        </p>
                        <form @submit.prevent="register" class="space-y-6">
                            <div>
                                <label for="HoTen" class="text-sm font-medium text-gray-700 block mb-2">Họ tên</label>
                                <input type="text" id="HoTen" v-model="HoTen"
                                    class="w-full px-4 py-3 rounded-lg outline-none border-2 border-gray-300 focus:border-blue-secondary focus:ring-blue-secondary transition duration-150 ease-in-out"
                                    placeholder="Nguyễn Văn A" />
                            </div>
                            <div>
                                <label for="NgaySinh" class="text-sm font-medium text-gray-700 block mb-2">Ngày sinh</label>
                                <input type="date" id="NgaySinh" v-model="NgaySinh"
                                    class="w-full px-4 py-3 rounded-lg outline-none border-2 border-gray-300 focus:border-blue-secondary focus:ring-blue-secondary transition duration-150 ease-in-out" />
                            </div>
                            <div>
                                <label for="SoDienThoai" class="text-sm font-medium text-gray-700 block mb-2">Số điện thoại</label>
                                <input type="text" id="SoDienThoai" v-model="SoDienThoai"
                                    class="w-full px-4 py-3 rounded-lg outline-none border-2 border-gray-300 focus:border-blue-secondary focus:ring-blue-secondary transition duration-150 ease-in-out"
                                    placeholder="0123456789" />
                            </div>
                            <div>
                                <label for="ChucVu"
                                    class="text-sm font-medium text-gray-700 block mb-2">Chức vụ</label>
                                <select id="ChucVu"
                                    class="w-full px-4 py-3 cursor-pointer rounded-lg outline-none border-2 border-gray-300 focus:border-blue-secondary focus:ring-blue-secondary transition duration-150 ease-in-out">
                                    <option value="">Chọn chức vụ phù hợp</option>
                                    <option value="Quản trị viên">Quản trị viên</option>
                                    <option value="Nhân viên">Nhân viên</option>
                                </select>
                            </div>
                            <div>
                                <label for="MatKhau" class="text-sm font-medium text-gray-700 block mb-2">Mật khẩu</label>
                                <input type="text" id="MatKhau" v-model="MatKhau"
                                    class="w-full px-4 py-3 rounded-lg outline-none border-2 border-gray-300 focus:border-blue-secondary focus:ring-blue-secondary transition duration-150 ease-in-out"
                                    placeholder="••••••••" />
                            </div>
                            <button type="submit"
                                class="w-full bg-blue-secondary text-white py-3 rounded-lg font-medium hover:bg-blue-dark transition duration-150 ease-in-out">
                                Đăng ký
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import { ref } from 'vue';

const HoTen = ref('');
const NgaySinh = ref('');
const SoDienThoai = ref('');

const register = async () => {
    const newNhanVien = {
        HoTen: HoTen.value,
        NgaySinh: NgaySinh.value,
        SoDienThoai: SoDienThoai.value
    };

    try {
        const response = await fetch('http://localhost:3000/api/nhanvien', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(newNhanVien)
        });

        if (response.ok) {
            alert('Đăng ký thành công!');
            HoTen.value = '';
            NgaySinh.value = '';
            SoDienThoai.value = '';
        } else {
            alert('Đăng ký thất bại!');
        }
    } catch (error) {
        console.error('Error:', error);
        alert('Đã xảy ra lỗi!');
    }
};
</script>

<style scoped>
</style>