<script setup>
import { ref, onMounted } from "vue";
import axios from "axios";
import navbar from '@/components/navbar.vue';
import sidebar from '@/components/sidebar.vue';
import { useRouter } from 'vue-router';

const router = useRouter();
const idCustomers = ref("");
const nameCustomers = ref("");
const addressCustomers = ref("");
const phoneCustomers = ref("");
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
const getCustomersByID = async (id) => {
    try {
        const response = await axios.get(`http://localhost:3000/api/khachhang/${id}`);
        console.log(response.data)
        nameCustomers.value = response.data[0].TenKhachHang;
        phoneCustomers.value = response.data[0].SoDienThoai;
        addressCustomers.value = response.data[0].DiaChi;
        
    } catch (error) {
        console.error('Lỗi khi lấy dữ liệu:', error);
    }
};

const editCustomers = async () => {
    try {
        const updateCustomers = {
            MaKhachHang: idCustomers.value,
            TenKhachHang: nameCustomers.value,
            SoDienThoai: phoneCustomers.value,
            DiaChi: addressCustomers.value,
        };
        const response = await axios.put(`http://localhost:3000/api/khachhang/${idCustomers.value}`, updateCustomers);
        showMessage('Thông tin khách hàng đã được cập nhật thành công!', 'success');

        setTimeout(() => {
            router.push('/customers');
        }, 2000);
    } catch(error) {
        showMessage(error.response?.data?.error || 'Có lỗi xảy ra, vui lòng thử lại!', 'error');
    }
}

onMounted(() => {
    const idKH = router.currentRoute.value.params.maKH;
    idCustomers.value = idKH;
    console.log(idKH)
    getCustomersByID(idKH);
});
</script>

<template>
    <div class="bg-gray-200 font-sans w-full min-h-screen">
        <div class="flex gap-3">
            <sidebar />
            <div class="flex flex-col gap-5 w-full p-3 overflow-auto">
                <navbar />
                <div class="relative flex flex-col gap-4 w-full overflow-auto max-h-[calc(100vh-150px)]">
                    <div class="flex-grow lg:py-8 lg:px-24 p-4">
                        <div class="container max-w-screen-lg mx-auto">
                            <div>
                                <div class="bg-white rounded-lg shadow-lg p-4 px-4 md:p-8 mb-6">
                                    <div class="grid gap-4 gap-y-2 text-sm grid-cols-1 lg:grid-cols-3">
                                        <div class="text-[#333f48] font-semibold">
                                            <p class="text-lg">Chỉnh sửa thông tin khách hàng</p>
                                            <p>Vui lòng điền thông tin đầy đủ.</p>
                                        </div>
                                        <div class="lg:col-span-2">
                                            <form @submit.prevent="editCustomers" action="" method="POST"
                                                class="grid gap-4 gap-y-3 text-sm grid-cols-1 md:grid-cols-5"
                                                enctype="multipart/form-data">

                                                <div class="md:col-span-5">
                                                    <label for="nameCustomers" class="font-semibold text-[16px]">Tên khách hàng</label>
                                                    <input type="text" name="nameCustomers" id="nameCustomers"
                                                        v-model="nameCustomers"
                                                        class="h-10 border mt-1 rounded px-4 w-full bg-gray-50"
                                                        placeholder="Nhập tên khách hàng ..." />
                                                </div>

                                                <div class="md:col-span-5">
                                                    <label for="phoneCustomers" class="font-semibold text-[16px]">Số
                                                        điện thoại</label>
                                                    <input type="text" name="phoneCustomers" id="phoneCustomers"
                                                        v-model="phoneCustomers"
                                                        class="h-10 border mt-1 rounded px-4 w-full bg-gray-50"
                                                        placeholder="Nhập số điện thoại ..." />
                                                </div>

                                                <div class="md:col-span-5">
                                                    <label for="addressCustomers" class="font-semibold text-[16px]">Địa
                                                        chỉ</label>
                                                    <input type="text" v-model="addressCustomers"
                                                        name="addressCustomers" id="addressCustomers"
                                                        class="h-10 border mt-1 rounded px-4 w-full bg-gray-50"
                                                        placeholder="Nhập địa chỉ ..." />
                                                </div>

                                                <div class="md:col-span-5 text-right">
                                                    <div class="inline-flex items-end">
                                                        <button type="submit"
                                                            class="bg-[#333f48] hover:bg-blue-primary text-white font-bold py-2 px-4 rounded">Thêm
                                                            khách hàng</button>
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