<script setup>
import { onMounted, ref } from "vue";
import navbar from '@/components/navbar.vue';
import sidebar from '@/components/sidebar.vue';
import axios from 'axios';
import { useRouter } from 'vue-router';

const router = useRouter();
const idProduct = ref("");
const idBill = ref("");
const quantity = ref("");
const price = ref("");
const notification = ref({ message: '', type: '' });
const showMessage = (message, type) => {
    notification.value = { message, type };
    setTimeout(() => {
        notification.value.message = '';
    }, 3000);
};  
const getChiTietPhieuXuatByID = async (id) => {
    try {
        const response = await axios.get(`http://localhost:3000/api/chitietphieuxuat/phieuxuat/${id}`);
        idBill.value = response.data[0].MaPX;
        idProduct.value = response.data[0].MaThietBi;
        quantity.value = response.data[0].SoLuong;
        price.value = response.data[0].DonGia;
    } catch (error) {
        console.error('Lỗi khi lấy dữ liệu:', error);
    }
};

const editChiTietPhieuXuat = async () => {
    try {
        const updateChiTietPhieuXuat = {
            MaPX: idBill.value,
            MaThietBi: idProduct.value,
            SoLuong: quantity.value,
            DonGia: price.value,
        };
        const response = await axios.put(`http://localhost:3000/api/chitietphieuxuat/${idBill.value}/${idProduct.value}`, updateChiTietPhieuXuat);
        showMessage('Chi tiết hóa đơn đã chỉnh sửa thành công!', 'success');

        setTimeout(() => {
            router.push('/detailsBillInfo');
        }, 2000);
    } catch(error) {
        showMessage(error.response?.data?.error || 'Có lỗi xảy ra, vui lòng thử lại!', 'error');
    }
}

onMounted(() => {
    const idPX = router.currentRoute.value.params.maPX;
    idBill.value = idPX;
    console.log(idPX);
    getChiTietPhieuXuatByID(idPX);
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
                                            <p class="text-lg">Chi tiết hóa đơn</p>
                                            <p>Vui lòng điền thông tin đầy đủ.</p>
                                        </div>
                                        <div class="lg:col-span-2">
                                            <form action="" method="POST" @submit.prevent="editChiTietPhieuXuat"
                                                class="grid gap-4 gap-y-3 text-sm grid-cols-1 md:grid-cols-5"
                                                enctype="multipart/form-data">
                                                <div class="md:col-span-5">
                                                    <label for="idProduct" class="font-semibold text-[16px]">Mã thiết
                                                        bị</label>
                                                    <input readonly type="text" v-model="idProduct" name="idProduct"
                                                        id="idProduct"
                                                        class="h-10 border mt-1 rounded px-4 w-full bg-gray-50"
                                                        placeholder="Nhập mã thiết bị ..." />
                                                </div>

                                                <div class="md:col-span-5">
                                                    <label for="idBill" class="font-semibold text-[16px]">Mã hóa
                                                        đơn</label>
                                                    <input readonly type="text" v-model="idBill" name="idBill" id="idBill"
                                                        class="h-10 border mt-1 rounded px-4 w-full bg-gray-50"
                                                        placeholder="Nhập mã hóa đơn ..." />
                                                </div>

                                                <div class="md:col-span-5">
                                                    <label for="quantity" class="font-semibold text-[16px]">Số
                                                        lượng</label>
                                                    <input type="number" v-model="quantity" name="quantity"
                                                        id="quantity"
                                                        class="h-10 border mt-1 rounded px-4 w-full bg-gray-50"
                                                        placeholder="Nhập số lượng ..." />
                                                </div>

                                                <div class="md:col-span-5">
                                                    <label for="price" class="font-semibold text-[16px]">Đơn giá</label>
                                                    <input type="text" v-model="price" name="price" id="price"
                                                        class="h-10 border mt-1 rounded px-4 w-full bg-gray-50"
                                                        placeholder="1-xxx-xxx ..." />
                                                </div>

                                                <div class="md:col-span-5 text-right">
                                                    <div class="inline-flex items-end">
                                                        <button type="submit"
                                                            class="bg-[#333f48] hover:bg-blue-primary text-white font-bold py-2 px-4 rounded">Chỉnh sửa
                                                            chi tiết hóa đơn</button>
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