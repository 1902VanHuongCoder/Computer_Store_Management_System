<script setup>
import { onMounted, ref } from "vue";
import navbar from '@/components/navbar.vue';
import sidebar from '@/components/sidebar.vue';
import axios from 'axios';
import { useRouter } from 'vue-router';

const router = useRouter();
const idStaff = ref("");
const nameStaff = ref("");
const poision = ref("");
const phoneStaff = ref("");
const dateStaff = ref("");
const password = ref("");
const confirmPassword = ref("");
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
const getStaffByID = async (id) => {
    try {
        const response = await axios.get(`http://localhost:3000/api/nhanvien/${id}`);
        nameStaff.value = response.data[0].HoTen;
        phoneStaff.value = response.data[0].SoDienThoai;
        const date = new Date(response.data[0].NgaySinh);
        const localDate = new Date(date.getTime() - (date.getTimezoneOffset() * 60000));
        dateStaff.value = localDate.toISOString().slice(0, 10);
        poision.value = response.data[0].ChucVu;

    } catch (error) {
        console.error('Lỗi khi lấy dữ liệu:', error);
    }
};

const editStaffInfo = async () => {

    try {
        const updateStaffInfo = {
            MaNhanVien: idStaff.value,
            HoTen: nameStaff.value,
            SoDienThoai: phoneStaff.value,
            NgaySinh: dateStaff.value,
            ChucVu: poision.value,
        };

        // Chỉ thêm trường mật khẩu nếu người dùng nhập mật khẩu mới
        if (password.value !== "") {
            updateStaffInfo.MatKhau = password.value;
        }
        const response = await axios.put(`http://localhost:3000/api/nhanvien/${idStaff.value}`, updateStaffInfo);
        showMessage('Cập nhật thông tin nhân viên thành công!', 'success');

        setTimeout(() => {
            router.push('/staffList');
        }, 2000);
    } catch (error) {
        showMessage(error.response?.data?.error || 'Có lỗi xảy ra, vui lòng thử lại!', 'error');
    }
}

onMounted(() => {
    const idNV = router.currentRoute.value.params.maNV;
    idStaff.value = idNV;
    console.log(idNV);
    getStaffByID(idNV);
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
                                            <p class="text-lg">Cập nhật thông tin nhân viên</p>
                                            <p>Vui lòng điền thông tin đầy đủ.</p>
                                        </div>
                                        <div class="lg:col-span-2">
                                            <form @submit.prevent="editStaffInfo" action="" method="POST"
                                                class="grid gap-4 gap-y-3 text-sm grid-cols-1 md:grid-cols-5"
                                                enctype="multipart/form-data">

                                                <div class="md:col-span-5">
                                                    <label for="nameStaff" class="font-semibold text-[16px]">Họ
                                                        tên</label>
                                                    <input type="text" name="nameStaff" id="nameStaff"
                                                        v-model="nameStaff"
                                                        class="h-10 border mt-1 rounded px-4 w-full bg-gray-50"
                                                        placeholder="Nhập họ tên ..." />
                                                </div>

                                                <div class="md:col-span-5">
                                                    <label for="dateStaff" class="font-semibold text-[16px]">Ngày
                                                        sinh</label>
                                                    <input type="date" name="dateStaff" id="dateStaff"
                                                        v-model="dateStaff"
                                                        class="h-10 border mt-1 rounded px-4 w-full bg-gray-50"
                                                        placeholder="Nhập ngày sinh ..." />
                                                </div>

                                                <div class="md:col-span-5">
                                                    <label for="phoneStaff" class="font-semibold text-[16px]">Số điện
                                                        thoại</label>
                                                    <input type="text" readonly name="phoneStaff" id="phoneStaff"
                                                        v-model="phoneStaff"
                                                        class="h-10 border mt-1 rounded px-4 w-full bg-gray-50"
                                                        placeholder="Nhập số điện thoại ...">
                                                </div>

                                                <div class="md:col-span-5">
                                                    <label for="position" class="font-semibold text-[16px]">Chức
                                                        vụ</label>
                                                    <select id="position" v-model="poision"
                                                        class="h-10 border mt-1 rounded px-4 w-full bg-gray-50">
                                                        <option value="">Chọn chức vụ phù hợp</option>
                                                        <option value="Quản trị viên">Quản trị viên</option>
                                                        <option value="Nhân viên">Nhân viên</option>
                                                    </select>
                                                </div>

                                                <div class="md:col-span-5">
                                                    <label for="password" class="font-semibold text-[16px]">Mật
                                                        khẩu</label>
                                                    <input type="password" name="password" id="password"
                                                        v-model="password"
                                                        class="h-10 border mt-1 rounded px-4 w-full bg-gray-50"
                                                        placeholder="Nhập mật khẩu ...">
                                                </div>

                                                <div class="md:col-span-5">
                                                    <label for="confirmPassword" class="font-semibold text-[16px]">Nhập
                                                        lại mật khẩu</label>
                                                    <input type="password" name="confirmPassword" id="confirmPassword"
                                                        v-model="confirmPassword"
                                                        class="h-10 border mt-1 rounded px-4 w-full bg-gray-50"
                                                        placeholder="Xác nhận mật khẩu ...">
                                                </div>

                                                <div class="md:col-span-5 text-right">
                                                    <div class="inline-flex items-end">
                                                        <button type="submit"
                                                            class="bg-[#333f48] hover:bg-blue-primary text-white font-bold py-2 px-4 rounded">Cập
                                                            nhật thông tin</button>
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