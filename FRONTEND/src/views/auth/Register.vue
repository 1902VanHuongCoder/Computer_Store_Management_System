<template>
    <div
        class="relative flex justify-center items-center min-h-screen bg-gradient-to-r from-blue-secondary to-blue-light p-4">
        <div class="w-full max-w-4xl">
            <div class="bg-white rounded-xl shadow-lg overflow-hidden">
                <div class="flex flex-col md:flex-row">
                    <div class="hidden md:block w-1/2 bg-blue-secondary p-12">
                        <img src="../../assets/img/img-logout.png" class="w-full h-full object-cover rounded-xl"
                            alt="Login illustration" />
                    </div>
                    <div class="w-full md:w-1/2 p-8 md:p-12">
                        <h1 class="text-2xl md:text-3xl font-bold text-center text-gray-800 mb-2">
                            ĐĂNG KÝ TÀI KHOẢN
                        </h1>
                        <p class="text-md md:text-lg font-medium text-center text-gray-600 mb-8">
                            Vui lòng điền thông tin để đăng ký!
                        </p>
                        <form @submit.prevent="register" class="space-y-6" method="POST">
                            <div>
                                <label for="HoTen" class="text-sm font-medium text-gray-700 block mb-2">Họ tên</label>
                                <input type="text" id="HoTen" v-model="HoTen"
                                    class="w-full px-4 py-3 rounded-lg outline-none border-2 border-gray-300 focus:border-blue-secondary focus:ring-blue-secondary transition duration-150 ease-in-out"
                                    placeholder="Nguyễn Văn A" />
                            </div>
                            <div>
                                <label for="NgaySinh" class="text-sm font-medium text-gray-700 block mb-2">Ngày
                                    sinh</label>
                                <input type="date" id="NgaySinh" v-model="NgaySinh"
                                    class="w-full px-4 py-3 rounded-lg outline-none border-2 border-gray-300 focus:border-blue-secondary focus:ring-blue-secondary transition duration-150 ease-in-out" />
                            </div>
                            <div>
                                <label for="SoDienThoai" class="text-sm font-medium text-gray-700 block mb-2">Số điện
                                    thoại</label>
                                <input type="text" id="SoDienThoai" v-model="SoDienThoai"
                                    class="w-full px-4 py-3 rounded-lg outline-none border-2 border-gray-300 focus:border-blue-secondary focus:ring-blue-secondary transition duration-150 ease-in-out"
                                    placeholder="0123456789" />
                            </div>
                            <div>
                                <label for="ChucVu" class="text-sm font-medium text-gray-700 block mb-2">Chức vụ</label>
                                <select id="ChucVu" v-model="ChucVu"
                                    class="w-full px-4 py-3 cursor-pointer rounded-lg outline-none border-2 border-gray-300 focus:border-blue-secondary focus:ring-blue-secondary transition duration-150 ease-in-out">
                                    <option value="">Chọn chức vụ phù hợp</option>
                                    <option value="Quản trị viên">Quản trị viên</option>
                                    <option value="Nhân viên">Nhân viên</option>
                                </select>
                            </div>
                            <div>
                                <label for="MatKhau" class="text-sm font-medium text-gray-700 block mb-2">Mật
                                    khẩu</label>
                                <input type="password" id="MatKhau" v-model="MatKhau"
                                    class="w-full px-4 py-3 rounded-lg outline-none border-2 border-gray-300 focus:border-blue-secondary focus:ring-blue-secondary transition duration-150 ease-in-out"
                                    placeholder="••••••••" />
                            </div>
                            <button type="submit"
                                class="w-full bg-blue-secondary text-white py-3 rounded-lg hover:bg-blue-primary font-medium hover:bg-blue-dark transition duration-150 ease-in-out hover:scale-105">
                                Đăng ký
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <transition name="slide-fade" mode="out-in">
            <div v-if="notification.message"
                :class="`fixed top-4 right-4 p-5 bg-white shadow-lg rounded-lg z-10 flex items-center space-x-2 
                        ${notification.type === 'success' ? 'border-l-8 border-blue-primary text-blue-primary' : 'border-l-8 border-red-500 text-red-600'}`">
                <p class="text-[18px] font-semibold">{{ notification.message }}</p>
            </div>
        </transition>
    </div>
</template>

<script setup>
import { ref } from 'vue';
import axios from "axios";
import { useRouter } from 'vue-router';

const router = useRouter();
const HoTen = ref('');
const NgaySinh = ref('');
const SoDienThoai = ref('');
const ChucVu = ref('');
const MatKhau = ref('');
const notification = ref({ message: '', type: '' });
const showMessage = (message, type) => {
    notification.value = { message, type };
    setTimeout(() => {
        notification.value.message = '';
    }, 3000);
};
const register = async () => {
    if (!HoTen.value.trim() || !NgaySinh.value.trim() || !SoDienThoai.value.trim() || !ChucVu.value.trim() || !MatKhau.value.trim()) {
        return showMessage('Vui lòng nhập đầy đủ thông tin!', 'error');
    }

    if (MatKhau.value.length < 6) {
        return showMessage('Mật khẩu phải tối thiểu 6 kí tự!', 'error');
    }

    const phonePattern = /^(0[3|5|7|8|9])+([0-9]{8})$/;
    if (!phonePattern.test(SoDienThoai.value.trim())) {
        return showMessage('Số điện thoại không đúng định dạng! Vui lòng nhập số điện thoại hợp lệ.', 'error'); 
    }

    try {
        const newNhanVien = {
            HoTen: HoTen.value,
            NgaySinh: NgaySinh.value,
            SoDienThoai: SoDienThoai.value,
            ChucVu: ChucVu.value,
            MatKhau: MatKhau.value
        };

        const response = await axios.post('http://localhost:3000/api/nhanvien', newNhanVien);

        showMessage('Đăng ký tài khoản thành công!', 'success');

        setTimeout(() => {
            router.push('/login');
        }, 2000);
    }  catch (error) {
        console.error('Error:', error);
        showMessage(error.response?.data?.error || 'Có lỗi xảy ra, vui lòng thử lại!', 'error'); // Cập nhật thông báo lỗi
    }
};
</script>

<style scoped>
.slide-fade-enter-active,
.slide-fade-leave-active {
    transition: all 0.5s ease;
}

.slide-fade-enter,
.slide-fade-leave-to {
    transform: translateX(100%);
    opacity: 0;
}
</style>