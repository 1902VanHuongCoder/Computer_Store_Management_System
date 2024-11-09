<script setup>
import { ref, onMounted, computed } from "vue";
import axios from "axios";
import navbar from '@/components/navbar.vue';
import sidebar from '@/components/sidebar.vue';

const staffs = ref([]);
const namestaffs = ref("");
const phoneStaffs = ref("");
const positionStaffs = ref("");
const idStaffs = ref("");
const dateStaffs = ref("");
const searchQuery = ref("");
const notification = ref({ message: '', type: '' });
const showMessage = (message, type) => {
    notification.value = { message, type };
    setTimeout(() => {
        notification.value.message = '';
    }, 3000);
};

const getStaffs = async () => {
    try {
        const response = await axios.get("http://localhost:3000/api/nhanvien");
        staffs.value = response.data;
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

const filteredStaffs = computed(() => {
    if (!searchQuery.value) {
        return staffs.value;
    }
    return staffs.value.filter(staff =>
        staff.HoTen.toLowerCase().includes(searchQuery.value.toLowerCase())
    );
});

onMounted(() => {
    getStaffs();
});
</script>

<template>
    <div class="bg-gray-200 font-sans w-full min-h-screen">
        <div class="flex gap-3">
            <sidebar />
            <div class="flex flex-col gap-5 w-full p-3 overflow-auto">
                <navbar />
                <div class="text-center pt-4 pb-2 block">
                    <h2 class="font-bold text-blue-primary text-[20px]">DANH SÁCH NHÂN VIÊN</h2>
                </div>
                <div class="relative flex justify-center gap-4 max-w-xl">
                        <input type="text" v-model="searchQuery"
                            class="items-center w-full p-3 bg-white border-2 border-gray-400 text-[14px] font-semibold tracking-wider text-black rounded-lg focus:outline-none"
                            placeholder="Tìm kiếm nhân viên ..." />
                        <i class="fa-solid fa-magnifying-glass absolute top-3 right-4 font-bold text-[25px] text-blue-primary"></i>
                    </div>
                <div class="bg-white rounded-xl">
                    <div id="all_products" class="overflow-auto">
                        <table class="w-full border-collapse whitespace-nowrap text-center text-sm text-gray-500">
                            <thead class="">
                                <tr>
                                    <th scope="col" class="px-6 py-4 font-semibold text-gray-900">Mã nhân viên</th>
                                    <th scope="col" class="px-6 py-4 font-semibold text-gray-900">Tên nhân viên</th>
                                    <th scope="col" class="px-6 py-4 font-semibold text-gray-900">Ngày sinh</th>
                                    <th scope="col" class="px-6 py-4 font-semibold text-gray-900">Số điện thoại</th>
                                    <th scope="col" class="px-6 py-4 font-semibold text-gray-900">Chức vụ</th>
                                    <th scope="col" class="px-6 py-4 font-semibold text-gray-900">Điều chỉnh</th>
                                </tr>
                            </thead>
                            <tbody class="w-full">
                                <tr class="border-t border-slate-500" v-for="staff in filteredStaffs"
                                    :key="staff.MaNhanVien">
                                    <th class="px-6 py-4 font-medium text-gray-900">{{ staff.MaNhanVien }}</th>
                                    <td class="px-6 py-4 whitespace-nowrap overflow-hidden text-ellipsis">
                                        {{ staff.HoTen }}
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap overflow-hidden text-ellipsis">{{ new
                                        Date(staff.NgaySinh).toLocaleDateString('vi-VN') }}</td>
                                    <td class="px-6 py-4 whitespace-nowrap overflow-hidden text-ellipsis">{{
                                        staff.SoDienThoai }}</td>
                                    <td class="px-6 py-4 whitespace-nowrap overflow-hidden text-ellipsis">{{
                                        staff.ChucVu }}</td>
                                    <td class="flex justify-center items-center gap-2 px-7 py-7 flex-col">
                                        <a :href="`/editStaff/${staff.MaNhanVien}`"
                                            class="inline-block bg-blue-primary text-white font-medium py-2 px-4 rounded-md transition-all duration-300 hover:bg-blue-secondary whitespace-nowrap">Sửa
                                            nhân viên</a>
                                        <form @submit.prevent="">
                                            <button type="submit"
                                                class="inline-block text-white font-medium bg-[#DC143C] py-2 px-4 mb-4 rounded-md transition-all duration-300 hover:bg-[#B22222] whitespace-nowrap">Xóa
                                                nhân viên</button>
                                        </form>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<style></style>
