<script setup>
import { ref, onMounted, computed } from "vue";
import axios from "axios";
import navbar from '@/components/navbar.vue';
import sidebar from '@/components/sidebar.vue';

const typeDevices = ref([]);
const nameTypeDevice = ref("");
const unitOfCalculation = ref("");
const note = ref(""); 
const searchQuery = ref("");
const notification = ref({ message: '', type: '' });
const showMessage = (message, type) => {
    notification.value = { message, type };
    setTimeout(() => {
        notification.value.message = '';
    }, 3000);
};  

const addTypeDevices = async () => {
    if (!nameTypeDevice.value.trim() || !unitOfCalculation.value.trim()) {
        return showMessage('Vui lòng nhập đầy đủ thông tin!', 'error'); 
    }

    try {
        const newTypeDevice = {
            TenLoai: nameTypeDevice.value,
            DonViTinh: unitOfCalculation.value,
            GhiChu: note.value,
        };

        const response = await axios.post("http://localhost:3000/api/loaithietbi", newTypeDevice);

        showMessage('Loại thiết bị đã được thêm thành công!', 'success');
        await getTypeDevices();
    } catch (error) {
        showMessage('Có lỗi xảy ra, hãy thử lại!', 'error');
    }
};

const getTypeDevices = async () => {
    try {
        const response = await axios.get("http://localhost:3000/api/loaithietbi");
        typeDevices.value = response.data;
    } catch (error) {
        console.error('Lỗi khi lấy dữ liệu:', error);
    }
};

const deleteTypeDevice = async (maLoaiThietBi) => {
    const confirmDelete = confirm("Bạn có chắc chắn muốn xóa loại thiết bị này không?");
    if (!confirmDelete) return;
    try {
        const response = await axios.delete(`http://localhost:3000/api/loaithietbi/${maLoaiThietBi}`);
        typeDevices.value = typeDevices.value.filter(typeDevice => typeDevice.MaLoai !== maLoaiThietBi);
        showMessage('Loại thiết bị đã được xóa thành công!', 'success');
        await getTypeDevices();
    } catch (error) {
        showMessage('Có lỗi xảy ra, hãy thử lại!', 'error');
    }
}

const filteredTypeDevices = computed(() => {
    if (!searchQuery.value) {
        return typeDevices.value;
    }
    return typeDevices.value.filter(typeDevice =>
        typeDevice.TenLoai.toLowerCase().includes(searchQuery.value.toLowerCase())
    );
});

onMounted(() => {
    getTypeDevices();
});
</script>

<template>
    <div class="bg-gray-200 font-sans w-full min-h-screen">
        <div class="flex gap-3">
            <sidebar />
            <div class="flex flex-col gap-5 w-full p-3">
                <navbar />
                <div class="relative flex flex-col gap-4 w-full overflow-auto max-h-[calc(100vh-150px)]">
                    <div class="flex-grow lg:py-8 lg:px-24 p-4">
                        <div class="container max-w-screen-lg mx-auto">
                            <div>
                                <div class="bg-white rounded-lg shadow-lg p-4 px-4 md:p-8 mb-6">
                                    <div class="grid gap-4 gap-y-2 text-sm grid-cols-1 lg:grid-cols-3">
                                        <div class="text-[#333f48] font-semibold">
                                            <p class="text-lg">Thông tin loại thiết bị</p>
                                            <p>Vui lòng điền thông tin đầy đủ.</p>
                                        </div>
                                        <div class="lg:col-span-2">
                                            <form @submit.prevent="addTypeDevices" action="" method="POST"
                                                class="grid gap-4 gap-y-3 text-sm grid-cols-1 md:grid-cols-5"
                                                enctype="multipart/form-data">

                                                <div class="md:col-span-5">
                                                    <label for="nameTypeDevice" class="font-semibold text-[16px]">Tên loại</label>
                                                    <input type="text" name="nameTypeDevice" id="nameTypeDevice"
                                                        v-model="nameTypeDevice"
                                                        class="h-10 border mt-1 rounded px-4 w-full bg-gray-50"
                                                        placeholder="Nhập tên loại ..." />
                                                </div>

                                                <div class="md:col-span-5">
                                                    <label for="unitOfCalculation" class="font-semibold text-[16px]">Đơn vị tính</label>
                                                    <input type="text" name="unitOfCalculation" id="unitOfCalculation"
                                                        v-model="unitOfCalculation"
                                                        class="h-10 border mt-1 rounded px-4 w-full bg-gray-50"
                                                        placeholder="Nhập đơn vị tính ..." />
                                                </div>

                                                <div class="md:col-span-5">
                                                    <label for="note" class="font-semibold text-[16px]">Ghi chú</label>
                                                    <textarea type="text" name="note" id="note"
                                                        v-model="note"
                                                        class="h-20 border mt-1 rounded p-2 w-full bg-gray-50"
                                                        placeholder="Nhập ghi chú ..."></textarea>
                                                </div>

                                                <div class="md:col-span-5 text-right">
                                                    <div class="inline-flex items-end">
                                                        <button type="submit"
                                                            class="bg-[#333f48] hover:bg-blue-primary text-white font-bold py-2 px-4 rounded">Thêm
                                                            loại thiết bị</button>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="relative flex justify-center flex-1 gap-4 max-w-xl">
                        <input type="text" v-model="searchQuery"
                            class="items-center w-full p-3 bg-white border-2 border-gray-400 text-[14px] font-semibold tracking-wider text-black rounded-lg focus:outline-none"
                            placeholder="Tìm kiếm loại thiết bị ..." />
                        <i class="fa-solid fa-magnifying-glass absolute top-3 right-4 font-bold text-[25px] text-blue-primary"></i>
                    </div>
                    <div class="bg-white rounded-xl">
                        <div class="text-center py-4 block lg:hidden">
                            <h2 class="font-bold text-blue-primary text-[18px]">THÔNG TIN NHÀ CUNG CẤP</h2>
                        </div>
                        <div id="all_products" class="overflow-auto">
                            <table class="w-full border-collapse whitespace-nowrap text-center text-sm text-gray-500">
                                <thead class="">
                                    <tr>
                                        <th scope="col" class="px-6 py-4 font-semibold text-gray-900">Mã loại thiết bị
                                        </th>
                                        <th scope="col" class="px-6 py-4 font-semibold text-gray-900">Tên loại thiết bị
                                        </th>
                                        <th scope="col" class="px-6 py-4 font-semibold text-gray-900">Đơn vị tính</th>
                                        <th scope="col" class="px-6 py-4 font-semibold text-gray-900">Ghi chú</th>
                                        <th scope="col" class="px-6 py-4 font-semibold text-gray-900">Điều chỉnh</th>
                                    </tr>
                                </thead>
                                <tbody class="w-full">
                                    <tr class="border-t border-slate-500" v-for="typeDevice in filteredTypeDevices" :key="typeDevice.MaLoai">
                                        <th class="px-6 py-4 font-medium text-gray-900">{{ typeDevice.MaLoai }}</th>
                                        <td class="px-6 py-4 whitespace-nowrap overflow-hidden text-ellipsis">
                                        {{ typeDevice.TenLoai }}
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap overflow-hidden text-ellipsis">{{ typeDevice.DonViTinh }}</td>
                                        <td class="px-6 py-4 whitespace-nowrap overflow-hidden text-ellipsis">
                                        {{ typeDevice.GhiChu }}
                                        </td>
                                        <td class="flex justify-center items-center gap-2 px-7 py-7 flex-col">
                                            <a :href="`/editTypeDevice/${typeDevice.MaLoai}`"
                                                class="inline-block bg-blue-primary text-white font-medium py-2 px-4 rounded-md transition-all duration-300 hover:bg-blue-secondary whitespace-nowrap">Sửa
                                                loại thiết bị</a>
                                            <form @submit.prevent="deleteTypeDevice(typeDevice.MaLoai)">
                                                <button type="submit"
                                                    class="inline-block text-white font-medium bg-[#DC143C] py-2 px-4 mb-4 rounded-md transition-all duration-300 hover:bg-[#B22222] whitespace-nowrap">Xóa
                                                    loại thiết bị</button>
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