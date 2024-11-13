<script setup>
import { ref, onMounted, computed } from "vue";
import axios from "axios";
import navbar from '@/components/navbar.vue';
import sidebar from '@/components/sidebar.vue';

const entryForms = ref([]);
const idStaff = ref("");
const idSupplier = ref("");
const searchQuery = ref("");
const notification = ref({ message: '', type: '' });
const showMessage = (message, type) => {
    notification.value = { message, type };
    setTimeout(() => {
        notification.value.message = '';
    }, 3000);
};  

const addEntryForm = async () => {
    try {
        const newEntryForm = {
            MaNhaCungCap: idSupplier.value,
            MaNhanVien: idStaff.value,
        };

        const response = await axios.post("http://localhost:3000/api/phieunhap", newEntryForm);

        showMessage('Phiếu nhập đã được thêm thành công!', 'success');
        await getEntryForm();
    } catch (error) {
        showMessage(error.response?.data?.error || 'Có lỗi xảy ra, vui lòng thử lại!', 'error');
    }
};

const getEntryForm = async () => {
    try {
        const response = await axios.get("http://localhost:3000/api/phieunhap");
        entryForms.value = response.data.map(entry => {
            const localDate = new Date(entry.NgayNhap);
            const localDateString = localDate.toLocaleDateString('vi-VN')

            return {
                ...entry,
                NgayNhap: localDateString
            };
        });
    } catch (error) {
        console.error('Lỗi khi lấy dữ liệu:', error);
    }
};

const deleteEntryForm = async (maPhieuNhap) => {
    const confirmDelete = confirm("Bạn có chắc chắn muốn xóa phiếu nhập này không?");
    if (!confirmDelete) return;
    try {
        const response = await axios.delete(`http://localhost:3000/api/phieunhap/${maPhieuNhap}`);
        entryForms.value = entryForms.value.filter(entryForm => entryForm.MaPN !== maPhieuNhap);
        showMessage('Phiếu nhập đã được xóa thành công!', 'success');
        await getEntryForm();
    } catch (error) {
        showMessage(error.response?.data?.error || 'Có lỗi xảy ra, vui lòng thử lại!', 'error');
    }
}

const filteredEntryForm = computed(() => {
    if (!searchQuery.value) {
        return entryForms.value;
    }
    return entryForms.value.filter(entryForm => {
        return entryForm.MaPN.toString().toLowerCase().includes(searchQuery.value.toLowerCase());
    });
});
onMounted(() => {
    getEntryForm();
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
                                            <p class="text-lg">Thông tin phiếu nhập</p>
                                            <p>Vui lòng điền thông tin đầy đủ.</p>
                                        </div>
                                        <div class="lg:col-span-2">
                                            <form @submit.prevent="addEntryForm" action="" method="POST" 
                                                class="grid gap-4 gap-y-3 text-sm grid-cols-1 md:grid-cols-5"
                                                enctype="multipart/form-data">

                                                <div class="md:col-span-5">
                                                    <label for="idSupplier" class="font-semibold text-[16px]">Mã nhà
                                                        cung
                                                        cấp</label>
                                                    <input type="text" v-model="idSupplier" name="idSupplier" id="idSupplier"
                                                        class="h-10 border mt-1 rounded px-4 w-full bg-gray-50"
                                                        placeholder="Nhập mã nhà cung cấp ..." />
                                                </div>

                                                <div class="md:col-span-5">
                                                    <label for="idStaff" class="font-semibold text-[16px]">Mã nhân
                                                        viên</label>
                                                    <input type="text" v-model="idStaff" name="idStaff" id="idStaff"
                                                        class="h-10 border mt-1 rounded px-4 w-full bg-gray-50"
                                                        placeholder="Nhập mã nhân viên ..." />
                                                </div>

                                                <div class="md:col-span-5 text-right">
                                                    <div class="inline-flex items-end">
                                                        <button type="submit"
                                                            class="bg-[#333f48] hover:bg-blue-primary text-white font-bold py-2 px-4 rounded">Thêm
                                                            phiếu nhập</button>
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
                            placeholder="Tìm kiếm phiếu nhập ..." />
                        <i class="fa-solid fa-magnifying-glass absolute top-3 right-4 font-bold text-[25px] text-blue-primary"></i>
                    </div>
                    <div class="bg-white rounded-xl">
                        <div class="text-center py-4 block lg:hidden">
                            <h2 class="font-bold text-blue-primary text-[18px]">THÔNG TIN PHIẾU NHẬP</h2>
                        </div>
                        <div id="all_products" class="overflow-auto">
                            <table class="w-full border-collapse whitespace-nowrap text-center text-sm text-gray-500">
                                <thead class="">
                                    <tr>
                                        <th scope="col" class="px-6 py-4 font-semibold text-gray-900">Mã phiếu nhập</th>
                                        <th scope="col" class="px-6 py-4 font-semibold text-gray-900">Mã nhà cung cấp
                                        </th>
                                        <th scope="col" class="px-6 py-4 font-semibold text-gray-900">Mã nhân viên</th>
                                        <th scope="col" class="px-6 py-4 font-semibold text-gray-900">Ngày nhập</th>
                                        <th scope="col" class="px-6 py-4 font-semibold text-gray-900">Điều chỉnh</th>
                                    </tr>
                                </thead>
                                <tbody class="w-full">
                                    <tr class="border-t border-slate-500" v-for="entryForm in filteredEntryForm" :key="entryForm.MaPN">
                                        <th class="px-6 py-4 font-medium text-gray-900">{{ entryForm.MaPN }}</th>
                                        <td class="px-6 py-4 whitespace-nowrap overflow-hidden text-ellipsis">{{
                                            entryForm.MaNhaCungCap }}
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap overflow-hidden text-ellipsis">{{
                                            entryForm.MaNhanVien
                                            }}</td>
                                        <td class="px-6 py-4 whitespace-nowrap overflow-hidden text-ellipsis">
                                        {{ entryForm.NgayNhap}}
                                        </td>
                                        <td class="flex justify-center items-center gap-2 px-7 py-7 flex-col">
                                            <a :href="`/editEntryForm/${entryForm.MaPN}`"
                                                class="inline-block bg-blue-primary text-white font-medium py-2 px-4 rounded-md transition-all duration-300 hover:bg-blue-secondary whitespace-nowrap">Sửa
                                                phiếu nhập</a>
                                            <router-link :to="{ path: `/detailsEntryForm/${entryForm.MaPN}` }" class="inline-block bg-green-500 text-white font-medium py-2 px-4 rounded-md transition-all duration-300 hover:bg-green-600 whitespace-nowrap">Chi tiết phiếu nhập</router-link>
                                            <form @submit.prevent="deleteEntryForm(entryForm.MaPN)">
                                                <button type="submit"
                                                    class="inline-block text-white font-medium bg-[#DC143C] py-2 px-4 mb-4 rounded-md transition-all duration-300 hover:bg-[#B22222] whitespace-nowrap">Xóa
                                                    phiếu nhập</button>
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