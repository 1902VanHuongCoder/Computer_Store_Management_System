<script setup>
import { ref, computed, onMounted } from 'vue';
import { useRouter } from 'vue-router';

const router = useRouter();

const chucVu = ref(localStorage.getItem('chucVu'));
const hoTen = ref(localStorage.getItem('hoTen'));
const sidebarMobile = [
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
        icon: "fa-solid fa-group",
        path: "/customers",
    },
    {
        name: "Thông tin phiếu nhập",
        icon: "fa-solid fa-rectangle-list",
        path: "entryForm",
    },
    { name: "Thông tin hóa đơn", icon: "fa-solid fa-scroll", path: "billInfo" },
];

const filteredSidebarMobile = computed(() => {
    if (chucVu.value === 'Quản trị viên') {
        return sidebarMobile;
    } else {
        return sidebarMobile.filter((item, index) => index !== 2 && index !== 6);
    }
});

const dangXuat = () => {
    localStorage.removeItem('chucVu');
    localStorage.removeItem('hoTen');
    router.push('/login');
};

onMounted(() => {
    const open = $('.openSidebar');
    const close = $('.closeSidebar');
    const sidebar = $('.sidebar');

    open.on('click', () => {
        sidebar.animate({left : 0}, 400);
    });

    close.on('click', () => {
        sidebar.animate({left: '-100%'}, 400);
    })
})
</script>

<template>
    <nav class="flex gap-4 relative">
        <button class="openSidebar p-4 bg-white rounded-xl shadow lg:hidden block"><i
                class="fa-solid fa-bars-staggered text-xl text-blue-primary"></i></button>
        <div class="flex justify-between bg-white shadow rounded-xl w-full px-4 py-1 lg:py-3">
            <div class="flex gap-4 rounded-lg items-center p-2">
                <img src="../assets/img/avatar.jpg" class="w-14 h-14 rounded-full" alt="" />
                <div class="flex flex-col gap-1">
                    <p class="font-bold text-[14px] lg:text-lg">{{ hoTen }}</p>
                    <small class="text-[12px] font-semibold">Chức vụ : <span class="text-blue-secondary">{{ chucVu }}</span></small>
                </div>
            </div>
            <button @click.prevent="dangXuat" class="px-5 py-2 bg-blue-primary rounded-lg font-semibold text-white lg:block hidden">Đăng
                xuất</button>
        </div>
        <div class="sidebar fixed top-0 left-[-100%] bg-white w-full min-h-full p-4">
            <div class="flex flex-col">
                <div class="flex justify-between items-center">
                    <h2 class="text-blue-primary font-semibold text-2xl">JeiKei.com</h2>
                    <i class="closeSidebar fa-regular fa-circle-xmark text-blue-primary text-4xl"></i>
                </div>
                <hr class="bg-blue-primary h-[2px] my-5" />
                <ul class="flex flex-col gap-6">
                    <li v-for="item in filteredSidebarMobile" :key="item"
                        class="flex gap-3 items-center font-semibold text-gray-600 cursor-pointer hover:text-blue-primary transition-all duration-200">
                        <i :class="item.icon"></i>
                        <p>{{ item.name }}</p>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</template>

<style></style>