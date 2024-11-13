<script setup>
import { ref, computed } from 'vue';

const chucVu = ref(localStorage.getItem('chucVu'));
const sidebarMenu = [
    {
        name: "Danh sách thiết bị",
        icon: "fa-solid fa-igloo",
        path: "/",
    },
    {
        name: "Thêm sản phẩm",
        icon: "fa-solid fa-cart-plus",
        path: "addProduct",
    },
    { name: "Thêm nhân viên", icon: "fa-solid fa-user-plus", path: "addAdmin" },
    {
        name: "Quản lý loại thiết bị",
        icon: "fa-solid fa-tags",
        path: "typeDevice",
    },
    {
        name: "Quản lý nhà cung cấp",
        icon: "fa-solid fa-user-tie",
        path: "suppliers",
    },
    {
        name: "Quản lý nhà sản xuất",
        icon: "fa-solid fa-user-group",
        path: "manufacturers",
    },
    { name: "Quản lý nhân viên", icon: "fa-solid fa-users", path: "staffList" },
        {
        name: "Quản lý khách hàng",
        icon: "fa-solid fa-user-group",
        path: "/customers",
    },
    {
        name: "Thông tin phiếu nhập",
        icon: "fa-solid fa-rectangle-list",
        path: "entryForm",
    },
    { name: "Thông tin hóa đơn", icon: "fa-solid fa-scroll", path: "billInfo" },
    {
        name: "Chi tiết hóa đơn",
        icon: "fa-solid fa-money-bills",
        path: "detailsBillInfo",
    },
];

const filteredSidebarMenu = computed(() => {
    if (chucVu.value === 'Quản trị viên') {
        return sidebarMenu;
    } else {
        return sidebarMenu.filter((item, index) => index !== 2 && index !== 6);
    }
});
</script>

<template>
    <div class="w-1/4 px-6 py-5 lg:flex flex-col gap-4 bg-white shadow-md min-h-screen hidden">
        <div class="flex justify-between items-center">
            <h2 class="text-blue-primary font-semibold text-2xl">JeiKei.com</h2>
            <i class="fa-brands fa-slack text-blue-primary text-2xl"></i>
        </div>
        <hr class="bg-blue-primary h-[2px]" />
        <h2 class="font-semibold text-gray-400 text-lg uppercase">Computer Store Manager</h2>
        <ul class="flex flex-col gap-2">
            <router-link :to="item.path" v-for="item in filteredSidebarMenu" :key="item" active-class="active-link"
                class="flex gap-3 text-[16px] items-center font-semibold text-gray-700 cursor-pointer px-2 py-3 shadow-none hover:bg-blue-primary hover:text-white rounded-lg transition-all duration-200 hover:shadow-xl">
                <i :class="item.icon"></i>
                <p>{{ item.name }}</p>
            </router-link>
        </ul>
    </div>
</template>

<style scoped>
.active-link {
    background-color: #254E7A;
    color: #fff;
    box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
}
</style>