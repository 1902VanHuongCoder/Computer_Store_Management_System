<script setup>
import { onMounted, ref } from "vue";
import navbar from '@/components/navbar.vue';
import sidebar from '@/components/sidebar.vue';
import axios from 'axios';
import { useRouter } from 'vue-router';

const router = useRouter();
const idTypeDevice = ref("");
const nameTypeDevice = ref("");
const unitOfCalculation = ref("");
const note = ref(""); 
const notification = ref({ message: '', type: '' });
const showMessage = (message, type) => {
    notification.value = { message, type };
    setTimeout(() => {
        notification.value.message = '';
    }, 3000);
};  
const getTypeDeviceByID = async (id) => {
    try {
        const response = await axios.get(`http://localhost:3000/api/loaithietbi/${id}`);
        nameTypeDevice.value = response.data[0].TenLoai;
        unitOfCalculation.value = response.data[0].DonViTinh;
        note.value = response.data[0].GhiChu;
        
    } catch (error) {
        console.error('Lỗi khi lấy dữ liệu:', error);
    }
};

const editTypeDevice = async () => {
    try {
        const updateTypeDevice = {
            MaLoai: idTypeDevice.value,
            TenLoai: nameTypeDevice.value,
            DonViTinh: unitOfCalculation.value,
            GhiChu: note.value,
        };
        const response = await axios.put(`http://localhost:3000/api/loaithietbi/${idTypeDevice.value}`, updateTypeDevice);
        showMessage('Loại thiết bị đã chỉnh sửa thành công!', 'success');

        setTimeout(() => {
            router.push('/typedevice');
        }, 2000);
    } catch(error) {
        showMessage('Có lỗi xảy ra, vui lòng thử lại!', 'error');showMessage(error.response?.data?.error || 'Có lỗi xảy ra, vui lòng thử lại!', 'error');
    }
}

onMounted(() => {
    const idLoaiThietBi = router.currentRoute.value.params.maLoaiThietBi;
    idTypeDevice.value = idLoaiThietBi;
    console.log(idLoaiThietBi);
    getTypeDeviceByID(idLoaiThietBi);
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
                                            <p class="text-lg">Chỉnh sửa loại thiết bị</p>
                                            <p>Vui lòng điền thông tin đầy đủ.</p>
                                        </div>
                                        <div class="lg:col-span-2">
                                            <form @submit.prevent="editTypeDevice" action="" method="POST"
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