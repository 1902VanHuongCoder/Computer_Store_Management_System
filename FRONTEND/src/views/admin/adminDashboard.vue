<script setup>
import { ref, onMounted, computed } from "vue";
import axios from "axios";
import navbar from '@/components/navbar.vue';
import sidebar from '@/components/sidebar.vue';

const devices = ref("");
const searchQuery = ref("");
const notification = ref({
    message: "",
    type: ""
});

const showMessage = (message, type) => {
    notification.value = { message, type };
    setTimeout(() => {
        notification.value.message = '';
    }, 3000);
}; 
const getDevices = async () => {
    try {
        const response = await axios.get("http://localhost:3000/api/thietbi");
        devices.value = response.data;
    } catch (error) {
        console.error('Lỗi khi lấy dữ liệu:', error);
    }
};

const deleteDevices = async (maThietBi) => {
    const confirmDelete = confirm("Bạn có chắc chắn muốn xóa thiết bị này không?");
    if (!confirmDelete) return;
    try {
        const response = await axios.delete(`http://localhost:3000/api/thietbi/${maThietBi}`);
        devices.value = devices.value.filter(device => device.MaNhanVien !== maThietBi);
        showMessage('Thiết bị đã được xóa thành công!', 'success');
        await getDevices();
    } catch (error) {
        showMessage(error.response?.data?.error || 'Có lỗi xảy ra, vui lòng thử lại!', 'error');
    }
}

const filteredDevices = computed(() => {
    if (!searchQuery.value) {
        return devices.value;
    }
    return devices.value.filter(device =>
        device.TenThietBi.toLowerCase().includes(searchQuery.value.toLowerCase())
    );
});

const formatCurrency = (value) => {
    const formattedValue = value * 1000;
    return formattedValue.toLocaleString('vi-VN') + ' ' + 'VNĐ';
};

onMounted(() => {
    getDevices();
});
</script>

<template>
    <div class="bg-gray-200 font-sans w-full min-h-screen">
        <div class="flex gap-3">
            <sidebar />
            <div class="flex flex-col gap-5 w-full p-3 overflow-auto">
                <navbar />
                <div class="text-center pt-4 pb-2">
                    <h2 class="font-bold text-blue-primary text-[20px]">DANH SÁCH THIẾT BỊ</h2>
                </div>
                <div class="relative flex justify-center gap-4 max-w-xl">
                    <input type="text" v-model="searchQuery"
                        class="items-center w-full p-3 bg-white border-2 border-gray-400 text-[14px] font-semibold tracking-wider text-black rounded-lg focus:outline-none"
                        placeholder="Tìm kiếm thiết bị ..." />
                    <i
                        class="fa-solid fa-magnifying-glass absolute top-3 right-4 font-bold text-[25px] text-blue-primary"></i>
                </div>
                <div class="bg-white rounded-xl">
                    <div id="all_products" class="overflow-auto">
                        <table class="w-full border-collapse whitespace-nowrap text-center text-sm text-gray-500">
                            <thead class="">
                                <tr>
                                    <th scope="col" class="px-6 py-4 font-semibold text-gray-900">Mã thiết bị</th>
                                    <th scope="col" class="px-6 py-4 font-semibold text-gray-900">Tên thiết bị</th>
                                    <th scope="col" class="px-6 py-4 font-semibold text-gray-900">Giá thành</th>
                                    <th scope="col" class="px-6 py-4 font-semibold text-gray-900">Số lượng</th>
                                    <th scope="col" class="px-6 py-4 font-semibold text-gray-900">Mã NSX</th>
                                    <th scope="col" class="px-6 py-4 font-semibold text-gray-900">Mã Loại</th>
                                    <th scope="col" class="px-6 py-4 font-semibold text-gray-900">Mã nhà cung cấp</th>
                                    <th scope="col" class="px-6 py-4 font-semibold text-gray-900">Thông số</th>
                                    <th scope="col" class="px-6 py-4 font-semibold text-gray-900">Điều chỉnh</th>
                                </tr>
                            </thead>
                            <tbody class="w-full">
                                <tr class="border-t border-slate-500" v-for="device in filteredDevices"
                                    :key="device.MaThietBi">
                                    <th class="px-6 py-4 font-medium text-gray-900">{{ device.MaThietBi }}</th>
                                    <td class="px-6 py-4 whitespace-nowrap overflow-hidden text-ellipsis">{{
                                        device.TenThietBi }}
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap overflow-hidden text-ellipsis">{{
                                        formatCurrency(device.GiaThanh)
                                        }}</td>
                                    <td class="px-6 py-4 whitespace-nowrap overflow-hidden text-ellipsis">{{
                                        device.SoLuong }}</td>
                                    <td class="px-6 py-4 whitespace-nowrap overflow-hidden text-ellipsis">{{
                                        device.MaNSX }}</td>
                                    <td class="px-6 py-4 whitespace-nowrap overflow-hidden text-ellipsis">{{
                                        device.MaLoai
                                        }}</td>
                                    <td class="px-6 py-4 whitespace-nowrap overflow-hidden text-ellipsis">{{
                                        device.MaNhaCungCap }}</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-ellipsis overflow-hidden max-w-48">
                                        <p class="overflow-hidden text-ellipsis whitespace-nowrap">{{
                                            device.ThongSoKT }}</p>
                                    </td>
                                    <td class="flex justify-center items-center gap-2 px-7 py-7 flex-col">
                                        <a :href="`/editProduct/${device.MaThietBi}`"
                                            class="inline-block bg-blue-primary text-white font-medium py-2 px-4 rounded-md transition-all duration-300 hover:bg-blue-secondary whitespace-nowrap">Sửa
                                            thiết bị</a>
                                        <form @submit.prevent="deleteDevices(device.MaThietBi)">
                                            <button type="submit"
                                                class="inline-block text-white font-medium bg-[#DC143C] py-2 px-4 mb-4 rounded-md transition-all duration-300 hover:bg-[#B22222] whitespace-nowrap">Xóa
                                                thiết bị</button>
                                        </form>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
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
        </div>
    </div>
</template>

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