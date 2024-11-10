<template>
    <div class="relative flex justify-center items-center min-h-screen bg-gradient-to-r from-blue-secondary to-blue-light p-4">
        <div class="w-full max-w-4xl">
            <div class="bg-white rounded-xl shadow-lg overflow-hidden">
                <div class="flex flex-col md:flex-row">
                    <div class="w-full md:w-1/2 p-8 md:p-12">
                        <h1 class="text-2xl md:text-3xl font-bold text-center text-gray-800 mb-2">ĐĂNG NHẬP ADMIN</h1>
                        <p class="text-md md:text-lg font-medium text-center text-gray-600 mb-8">
                            Vui lòng điền thông tin để đăng nhập!
                        </p>
                        <form action="" @submit.prevent="login" method="POST" class="space-y-6">
                            <div>
                                <label for="SoDienThoai" class="text-sm font-medium text-gray-700 block mb-2">Số điện
                                    thoại</label>
                                <input type="text" id="SoDienThoai" v-model="SoDienThoai"
                                    class="w-full px-4 py-3 rounded-lg outline-none border-2 border-gray-300 focus:border-blue-secondary focus:ring-blue-secondary transition duration-150 ease-in-out"
                                    placeholder="0123456789" />
                            </div>
                            <div>
                                <label for="MatKhau" class="text-sm font-medium text-gray-700 block mb-2">Mật
                                    khẩu</label>
                                <input type="password" id="MatKhau" v-model="MatKhau"
                                    class="w-full px-4 py-3 rounded-lg outline-none border-2 border-gray-300 focus:border-blue-secondary focus:ring-blue-secondary transition duration-150 ease-in-out"
                                    placeholder="••••••••" />
                            </div>
                            <button type="submit"
                                class="w-full bg-blue-secondary text-white rounded-lg py-3 px-4 font-semibold hover:bg-blue-primary transition duration-300 ease-in-out transform hover:scale-105">
                                Đăng nhập
                            </button>
                        </form>
                    </div>
                    <div class="hidden md:block w-1/2 bg-blue-secondary p-12">
                        <img src="../../assets/img/img-login.png" class="w-[500px] h-full object-cover rounded-xl"
                            alt="Login illustration">
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
const SoDienThoai = ref('');
const MatKhau = ref('');
const notification = ref({ message: '', type: '' });
const showMessage = (message, type) => {
    notification.value = { message, type };
    setTimeout(() => {
        notification.value.message = '';
    }, 3000);
};
const login = async () => {

    try {
        const login = {
            SoDienThoai: SoDienThoai.value,
            MatKhau: MatKhau.value
        };

        const response = await axios.post('http://localhost:3000/api/nhanvien/login', login);
        const { HoTen, ChucVu } = response.data.data;
        localStorage.setItem('hoTen', HoTen);
        localStorage.setItem('chucVu', ChucVu);
        showMessage('Đăng nhập tài khoản thành công!', 'success');

        setTimeout(() => {
            router.push('/');
        }, 2000);
    }  catch (error) {
        showMessage(error.response?.data?.error || 'Có lỗi xảy ra, vui lòng thử lại!', 'error');
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