<script setup>
import { ref, onMounted } from "vue";
import axios from "axios";
import navbar from '@/components/navbar.vue';
import sidebar from '@/components/sidebar.vue';
import { useRouter } from 'vue-router';

const router = useRouter();
const idNSX = ref("");
const idThietBi = ref("");
const idSupplier = ref("");
const idType = ref("");
const nameTB = ref("");
const description = ref("");
const priceTB = ref("");
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

const getDeviceByID = async (id) => {
    try {
        const response = await axios.get(`http://localhost:3000/api/thietbi/${id}`);
        nameTB.value = response.data[0].TenThietBi;
        priceTB.value = response.data[0].GiaThanh;
        description.value = response.data[0].ThongSoKT;
        idNSX.value = response.data[0].MaNSX;
        idSupplier.value = response.data[0].MaNhaCungCap;
        idType.value = response.data[0].MaLoai;
        
    } catch (error) {
        console.error('Lỗi khi lấy dữ liệu:', error);
    }
};

const editDevice = async () => {
    try {
        const updateDevice = {
            MaThietBi: idThietBi.value,
            TenThietBi: nameTB.value,
            GiaThanh: priceTB.value,
            ThongSoKT: description.value,
            MaNSX: idNSX.value,
            MaLoai: idType.value,
            MaNhaCungCap: idSupplier.value,
        };
        const response = await axios.put(`http://localhost:3000/api/thietbi/${idThietBi.value}`, updateDevice);
        showMessage('Thiết bị đã chỉnh sửa thành công!', 'success');

        setTimeout(() => {
            router.push('/');
        }, 2000);
    } catch(error) {
        showMessage(error.response?.data?.error || 'Có lỗi xảy ra, vui lòng thử lại!', 'error');
    }
}

onMounted(() => {
    const idTB = router.currentRoute.value.params.maTB;
    idThietBi.value = idTB;
    console.log(idTB);
    getDeviceByID(idTB);
});
</script>

<template>
    <div class="bg-gray-200 font-sans w-full min-h-screen">
        <div class="flex gap-3">
            <sidebar />
            <div class="flex flex-col gap-5 w-full p-3">
                <navbar />
                <div class="h-full overflow-hidden">
                    <div class="text-center py-4">
                        <h2 class="font-bold text-blue-primary text-[22px]">CHỈNH SỬA THIẾT BỊ</h2>
                    </div>
                    <form @submit.prevent="editDevice" action="" method="POST" enctype="multipart/form-data"
                        class="w-full max-h-[calc(100vh-200px)] overflow-y-auto">
                        <div
                            class="flex flex-col bg-white w-full md:w-[70%] mx-auto gap-5 border-2 rounded-xl shadow-md p-5 m-2">
                            <div class="">
                                <div>
                                    <label for="idNSX"
                                        class="font-bold mb-1 block text-base text-gray-700 after:ml-0.5 after:text-red-500 after:content-['*']">Mã
                                        nhà sản xuất</label>
                                    <input v-model="idNSX" name="idNSX" autofocus type="text" id="idNSX"
                                        class="outline-0 p-3 block w-full rounded-md border shadow-md focus:border-blue-secondary focus:ring focus:ring-blue-secondary focus:ring-opacity-50 disabled:cursor-not-allowed"
                                        placeholder="Nhập mã NSX ..." />
                                </div>
                            </div>
                            <div class="">
                                <div>
                                    <label for="idSupplier"
                                        class="font-bold mb-1 block text-base text-gray-700 after:ml-0.5 after:text-red-500 after:content-['*']">Mã
                                        nhà cung cấp</label>
                                    <input v-model="idSupplier" name="idSupplier" autofocus type="text" id="idSupplier"
                                        class="outline-0 p-3 block w-full rounded-md border shadow-md focus:border-blue-secondary focus:ring focus:ring-blue-secondary focus:ring-opacity-50 disabled:cursor-not-allowed"
                                        placeholder="Nhập mã nhà cung cấp ..." />
                                </div>
                            </div>
                            <div class="">
                                <div>
                                    <label for="idType"
                                        class="font-bold mb-1 block text-base text-gray-700 after:ml-0.5 after:text-red-500 after:content-['*']">Mã
                                        loại</label>
                                    <input v-model="idType" name="idType" autofocus type="text" id="idType"
                                        class="outline-0 p-3 block w-full rounded-md border shadow-md focus:border-blue-secondary focus:ring focus:ring-blue-secondary focus:ring-opacity-50 disabled:cursor-not-allowed"
                                        placeholder="Nhập mã loại ..." />
                                </div>
                            </div>
                            <div class="">
                                <div>
                                    <label for="nameTB"
                                        class="font-bold mb-1 block text-base text-gray-700 after:ml-0.5 after:text-red-500 after:content-['*']">Tên
                                        thiết bị</label>
                                    <input name="nameTB" v-model="nameTB" autofocus type="text" id="nameTB"
                                        class="outline-0 p-3 block w-full rounded-md border shadow-md focus:border-blue-secondary focus:ring focus:ring-blue-secondary focus:ring-opacity-50 disabled:cursor-not-allowed"
                                        placeholder="Nhập tên thiết bị ..." />
                                </div>
                            </div>
                            <div class="">
                                <div>
                                    <label for="priceTB"
                                        class="font-bold mb-1 block text-base text-gray-700 after:ml-0.5 after:text-red-500 after:content-['*']">Giá
                                        thành</label>
                                    <input v-model="priceTB" name="priceTB" autofocus type="text" id="priceTB"
                                        class="outline-0 p-3 block w-full rounded-md border shadow-md focus:border-blue-secondary focus:ring focus:ring-blue-secondary focus:ring-opacity-50 disabled:cursor-not-allowed"
                                        placeholder="10.000 VNĐ" />
                                </div>
                            </div>
                            <div class="">
                                <div>
                                    <label for="description"
                                        class="font-bold mb-1 block text-base text-gray-700 after:ml-0.5 after:text-red-500 after:content-['*']">Thông
                                        số</label>
                                    <textarea v-model="description" id="description" name="description"
                                        class="outline-0 p-3 block w-full rounded-md border shadow-md focus:border-blue-secondary focus:ring focus:ring-blue-secondary focus:ring-opacity-50 disabled:cursor-not-allowed"
                                        rows="3" placeholder="Hãy thêm thông số ..."></textarea>
                                </div>
                            </div>
                            <div class="text-center">
                                <button type="submit"
                                    class="inline-block rounded-lg bg-blue-primary px-6 py-3 text-sm font-bold text-[#fff] shadow-md hover:bg-blue-secondary hover:scale-110 transition-all duration-200">Thêm
                                    Thiết bị</button>
                            </div>
                        </div>
                    </form>
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