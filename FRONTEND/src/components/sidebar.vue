<script setup>
const sidebarMenu = [
    {
        name: "Danh sách sản phẩm",
        icon: "fa-solid fa-igloo",
        path: "/",
    },
    {
        name: "Danh sách người dùng",
        icon: "fa-solid fa-users",
        path: "/customers",
    },
    {
        name: "Thêm sản phẩm",
        icon: "fa-solid fa-cart-plus",
        path: "addProduct",
    },
    {
        name: "Thêm nhà cung cấp",
        icon: "fa-solid fa-user-tie",
        path: "suppliers",
    },
    {
        name: "Thêm nhà sản xuất",
        icon: "fa-solid fa-user-group",
        path: "manufacturers",
    },
    { name: "Thêm admin", icon: "fa-solid fa-user-plus", path: "addAdmin" },
    {
        name: "Thông tin phiếu nhập",
        icon: "fa-solid fa-rectangle-list",
        path: "entryForm",
    },
    { name: "Chi tiết phiếu nhập", icon: "fa-solid fa-list", path: "detailsEntryForm" },
    { name: "Thông tin hóa đơn", icon: "fa-solid fa-scroll", path: "billInfo" },
    {
        name: "Chi tiết hóa đơn",
        icon: "fa-solid fa-money-bills",
        path: "detailsBillInfo",
    },
];
</script>

<template>
    <div class="w-1/4 px-6 py-5 lg:flex flex-col gap-4 bg-white shadow-md min-h-screen hidden">
        <div class="flex justify-between items-center">
            <h2 class="text-blue-primary font-semibold text-2xl">JeiKei.com</h2>
            <i class="fa-brands fa-slack text-blue-primary text-2xl"></i>
        </div>
        <hr class="bg-blue-primary h-[2px]" />
        <h2 class="font-semibold text-gray-400 text-lg uppercase">Computer Store Manager</h2>
        <ul class="flex flex-col gap-3">
            <router-link :to="item.path" v-for="item in sidebarMenu" :key="item"
                class="flex gap-3 items-center font-semibold text-gray-700 cursor-pointer px-2 py-4 shadow-none hover:bg-blue-primary hover:text-white rounded-lg transition-all duration-200 hover:shadow-xl">
                <i :class="item.icon"></i>
                <p>{{ item.name }}</p>
            </router-link>
        </ul>
    </div>
</template>

<style></style>