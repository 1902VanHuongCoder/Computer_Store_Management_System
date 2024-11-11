<script setup>
import { onMounted, ref } from "vue";
import navbar from '@/components/navbar.vue';
import sidebar from '@/components/sidebar.vue';
import axios from 'axios';
import { useRouter } from 'vue-router';

const router = useRouter();
const idPhieuXuat = ref("");
const idStaff = ref("");
const idCustomer = ref("");
const ngayXuat = ref("");
const notification = ref({ message: '', type: '' });
const showMessage = (message, type) => {
    notification.value = { message, type };
    setTimeout(() => {
        notification.value.message = '';
    }, 3000);
}; const getPhieuXuatByID = async (id) => {
    try {
        const response = await axios.get(`http://localhost:3000/api/phieuxuat/${id}`);
        idStaff.value = response.data[0].MaNhanVien;
        idCustomer.value = response.data[0].MaKhachHang;
        const date = new Date(response.data[0].NgayXuat);
        const localDate = new Date(date.getTime() - (date.getTimezoneOffset() * 60000));
        ngayXuat.value = localDate.toISOString().slice(0, 10);
        
    } catch (error) {
        console.error('Lỗi khi lấy dữ liệu:', error);
    }
};

const editBillInfo = async () => {
    try {
        const updateBillInfo = {
            MaPX: idPhieuXuat.value,
            MaKhachHang: idCustomer.value,
            MaNhanVien: idStaff.value,
        };
        const response = await axios.put(`http://localhost:3000/api/phieuxuat/${idPhieuXuat.value}`, updateBillInfo);
        showMessage('Hóa đơn đã chỉnh sửa thành công!', 'success');

        setTimeout(() => {
            router.push('/billInfo');
        }, 2000);
    } catch(error) {
        showMessage(error.response?.data?.error || 'Có lỗi xảy ra, vui lòng thử lại!', 'error');
    }
}

onMounted(() => {
    const idPX = router.currentRoute.value.params.maPX;
    idPhieuXuat.value = idPX;
    console.log(idPX);
    getPhieuXuatByID(idPX);
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
                                            <p class="text-lg">Chỉnh sửa thông tin hóa đơn</p>
                                            <p>Vui lòng điền thông tin đầy đủ.</p>
                                        </div>
                                        <div class="lg:col-span-2">
                                            <form action="" method="POST" @submit.prevent="editBillInfo"
                                                class="grid gap-4 gap-y-3 text-sm grid-cols-1 md:grid-cols-5"
                                                enctype="multipart/form-data">

                                                <div class="md:col-span-5">
                                                    <label for="idCustomer" class="font-semibold text-[16px]">Mã khác hàng</label>
                                                    <input type="text" v-model="idCustomer" name="idCustomer" id="idCustomer"
                                                        class="h-10 border mt-1 rounded px-4 w-full bg-gray-50"
                                                        placeholder="Nhập mã khách hàng ..." />
                                                </div>

                                                <div class="md:col-span-5">
                                                    <label for="idStaff" class="font-semibold text-[16px]">Mã nhân
                                                        viên</label>
                                                    <input v-model="idStaff" type="text" name="idStaff" id="idStaff"
                                                        class="h-10 border mt-1 rounded px-4 w-full bg-gray-50"
                                                        placeholder="Nhập mã nhân viên ..." />
                                                </div>

                                                <div class="md:col-span-5">
                                                    <label for="ngayXuat" class="font-semibold text-[16px]">Ngày
                                                        xuất</label>
                                                    <input type="date" readonly name="ngayXuat" id="ngayXuat"
                                                        v-model="ngayXuat"
                                                        class="h-10 border mt-1 rounded px-4 w-full bg-gray-50"
                                                        placeholder="Nhập ngày xuất ..." />
                                                </div>

                                                <div class="md:col-span-5 text-right">
                                                    <div class="inline-flex items-end">
                                                        <button type="submit"
                                                            class="bg-[#333f48] hover:bg-blue-primary text-white font-bold py-2 px-4 rounded">Chỉnh sửa
                                                            hóa đơn</button>
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