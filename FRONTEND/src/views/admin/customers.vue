<script setup>
import { ref, onMounted, computed } from "vue";
import axios from "axios";
import navbar from '@/components/navbar.vue';
import sidebar from '@/components/sidebar.vue';

const customers = ref([]);
const nameCustomers = ref("");
const addressCustomers = ref("");
const phoneCustomers = ref("");
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

const addCustomers = async () => {
    try {
        const newCustomers = {
            TenKhachHang: nameCustomers.value,
            DiaChi: addressCustomers.value,
            SoDienThoai: phoneCustomers.value
        };

        const response = await axios.post("http://localhost:3000/api/khachhang", newCustomers);

        showMessage('Khách hàng được thêm thành công!', 'success');
        await getCustomers();
    } catch (error) {
        showMessage(error.response?.data?.error || 'Có lỗi xảy ra, vui lòng thử lại!', 'error');
    }
};

const getCustomers = async () => {
    try {
        const response = await axios.get("http://localhost:3000/api/khachhang");
        console.log(response.data)
        customers.value = response.data;
    } catch (error) {
        console.error('Lỗi khi lấy dữ liệu:', error);
    }
};

const deleteCustomers = async (maKH) => {
    const confirmDelete = confirm("Bạn có chắc chắn muốn xóa khách hàng này không?");
    if (!confirmDelete) return;
    try {
        const response = await axios.delete(`http://localhost:3000/api/khachhang/${maKH}`);
        customers.value = customers.value.filter(customer => customer.MaKhachHang !== maKH);
        showMessage('Khách hàng đã được xóa thành công!', 'success');
        await getCustomers();
    } catch(error) {
        showMessage(error.response?.data?.error || 'Có lỗi xảy ra, vui lòng thử lại!', 'error');
    }
}

const filteredCustomers = computed(() => {
    if (!searchQuery.value) {
        return customers.value;
    }
    return customers.value.filter(customer =>
        customer.TenKhachHang.toLowerCase().includes(searchQuery.value.toLowerCase())
    );
});

onMounted(() => {
    getCustomers();
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
                                            <p class="text-lg">Thông tin khách hàng</p>
                                            <p>Vui lòng điền thông tin đầy đủ.</p>
                                        </div>
                                        <div class="lg:col-span-2">
                                            <form @submit.prevent="addCustomers" action="" method="POST"
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
                    <div class="relative flex justify-center flex-1 gap-4 max-w-xl">
                        <input type="text" v-model="searchQuery"
                            class="items-center w-full p-3 bg-white border-2 border-gray-400 text-[14px] font-semibold tracking-wider text-black rounded-lg focus:outline-none"
                            placeholder="Tìm kiếm khách hàng ..." />
                        <i
                            class="fa-solid fa-magnifying-glass absolute top-3 right-4 font-bold text-[25px] text-blue-primary"></i>
                    </div>
                    <div class="bg-white rounded-xl">
                        <div class="text-center py-4 block lg:hidden">
                            <h2 class="font-bold text-blue-primary text-[18px]">DANH SÁCH NGƯỜI DÙNG</h2>
                        </div>
                        <div id="all_products" class="overflow-auto">
                            <table class="w-full border-collapse whitespace-nowrap text-center text-sm text-gray-500">
                                <thead class="">
                                    <tr>
                                        <th scope="col" class="px-6 py-4 font-semibold text-gray-900">Mã khách hàng</th>
                                        <th scope="col" class="px-6 py-4 font-semibold text-gray-900">Tên khách hàng
                                        </th>
                                        <th scope="col" class="px-6 py-4 font-semibold text-gray-900">Số điện thoại</th>
                                        <th scope="col" class="px-6 py-4 font-semibold text-gray-900">Địa chỉ</th>
                                        <th scope="col" class="px-6 py-4 font-semibold text-gray-900">Điều chỉnh</th>
                                    </tr>
                                </thead>
                                <tbody class="w-full">
                                    <tr class="border-t border-slate-500" v-for="customer in filteredCustomers" :key="customer.MaKhachHang">
                                        <th class="px-6 py-4 font-medium text-gray-900">{{ customer.MaKhachHang }}</th>
                                        <td class="px-6 py-4 whitespace-nowrap overflow-hidden text-ellipsis">{{
                                            customer.TenKhachHang }}
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap overflow-hidden text-ellipsis">{{
                                            customer.SoDienThoai }}
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap overflow-hidden text-ellipsis">{{
                                            customer.DiaChi }}</td>
                                        <td class="flex justify-center items-center gap-2 px-7 py-7 flex-col">
                                            <a :href="`/editCustomer/${customer.MaKhachHang}`"
                                                class="inline-block bg-blue-primary text-white font-medium py-2 px-4 rounded-md transition-all duration-300 hover:bg-blue-secondary whitespace-nowrap">Sửa
                                                khách hàng</a>
                                            <form @submit.prevent="deleteCustomers(customer.MaKhachHang)">
                                                <button type="submit"
                                                    class="inline-block text-white font-medium bg-[#DC143C] py-2 px-4 mb-4 rounded-md transition-all duration-300 hover:bg-[#B22222] whitespace-nowrap">Xóa
                                                    khách hàng</button>
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