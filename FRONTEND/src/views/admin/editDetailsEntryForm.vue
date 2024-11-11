<script setup>
import { onMounted, ref } from "vue";
import navbar from '@/components/navbar.vue';
import sidebar from '@/components/sidebar.vue';
import axios from 'axios';
import { useRouter } from 'vue-router';

const router = useRouter();
const idEntry = ref("");
const idProduct = ref("");
const quantity = ref("");
const price = ref("");
const notification = ref({ message: '', type: '' });
const showMessage = (message, type) => {
    notification.value = { message, type };
    setTimeout(() => {
        notification.value.message = '';
    }, 3000);
};
const getChiTietPhieuNhapByID = async (id) => {
    try {
        const response = await axios.get(`http://localhost:3000/api/chitietphieunhap/phieunhap/${id}`);
        idEntry.value = response.data[0].MaPN;
        idProduct.value = response.data[0].MaThietBi;
        quantity.value = response.data[0].SoLuong;
        price.value = response.data[0].DonGia;
    } catch (error) {
        console.error('Lỗi khi lấy dữ liệu:', error);
    }
};

const editDetailEntryForm = async () => {
    try {
        const updateDetailEntryForm = {
            MaPN: idEntry.value,
            MaThietBi: idProduct.value,
            SoLuong: quantity.value,
            DonGia: quantity.value,
        };
        const response = await axios.put(`http://localhost:3000/api/chitietphieunhap/${idEntry.value}/${idProduct.value}`, updateDetailEntryForm);
        showMessage('Chi tiết phiếu nhập đã chỉnh sửa thành công!', 'success');

        setTimeout(() => {
            router.push('/detailsEntryForm');
        }, 2000);
    } catch(error) {
        showMessage(error.response?.data?.error || 'Có lỗi xảy ra, vui lòng thử lại!', 'error');
    }
}

onMounted(() => {
    const idPN = router.currentRoute.value.params.maPN;
    idEntry.value = idPN;
    console.log(idPN);
    getChiTietPhieuNhapByID(idPN);
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
                                            <p class="text-lg">Cỉnh sửa chi tiết phiếu nhập</p>
                                            <p>Vui lòng điền thông tin đầy đủ.</p>
                                        </div>
                                        <div class="lg:col-span-2">
                                            <form action="" @submit.prevent="editDetailEntryForm" method="POST"
                                                class="grid gap-4 gap-y-3 text-sm grid-cols-1 md:grid-cols-5"
                                                enctype="multipart/form-data">

                                                <div class="md:col-span-5">
                                                    <label for="idEntry" class="font-semibold text-[16px]">Mã phiếu
                                                        nhập</label>
                                                    <input v-model="idEntry" readonly type="text" name="idEntry" id="idEntry"
                                                        class="h-10 border mt-1 rounded px-4 w-full bg-gray-50"
                                                        placeholder="Nhập mã phiếu nhập ..." />
                                                </div>

                                                <div class="md:col-span-5">
                                                    <label for="idProduct" class="font-semibold text-[16px]">Mã thiết
                                                        bị</label>
                                                    <input v-model="idProduct" readonly type="text" name="idProduct"
                                                        id="idProduct"
                                                        class="h-10 border mt-1 rounded px-4 w-full bg-gray-50"
                                                        placeholder="Nhập mã thiết bị ..." />
                                                </div>

                                                <div class="md:col-span-5">
                                                    <label for="quantity" class="font-semibold text-[16px]">Số
                                                        lượng</label>
                                                    <input v-model="quantity" type="number" name="quantity"
                                                        id="quantity"
                                                        class="h-10 border mt-1 rounded px-4 w-full bg-gray-50"
                                                        placeholder="Nhập số lượng ..." />
                                                </div>

                                                <div class="md:col-span-5">
                                                    <label for="price" class="font-semibold text-[16px]">Đơn giá</label>
                                                    <input v-model="price" type="text" name="price" id="price"
                                                        class="h-10 border mt-1 rounded px-4 w-full bg-gray-50"
                                                        placeholder="1-xxx-xxx ..." />
                                                </div>

                                                <div class="md:col-span-5 text-right">
                                                    <div class="inline-flex items-end">
                                                        <button type="submit"
                                                            class="bg-[#333f48] hover:bg-blue-primary text-white font-bold py-2 px-4 rounded">Thêm
                                                            chi tiết phiếu nhập</button>
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