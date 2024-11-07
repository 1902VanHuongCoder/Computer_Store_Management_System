<script setup>
import { ref } from "vue";
import navbar from '@/components/navbar.vue';
import sidebar from '@/components/sidebar.vue';

const products = ref([
    { id: 1, name: "Pokémon Đặc Biệt - Tập 59", price: "20.000 VNĐ", year: 2017, type: "Truyện tranh (Manga)", quantity: 300, image: "/src/assets/img/TruyenTranh-4.jpg", author: "Hidenori Kusaka, Satoshi Yamamoto", publisher: "Kim Đồng", description: "Trận chiến giành cây cổ thụ - Zeruneasu đã diễn ra! Dù dốc hết sức mình chiến đấu, Koruni vẫn thua trong gang tấc nên đành để cho “cây cổ thụ” và đá khai mở bị cướp đi!! Cảm thấy có lỗi trong việc Furadari bên phía kẻ thù đang dần chiếm được quyền lực! “Vũ khí tối thượng” - Di sản đen tối từ 3 ngàn năm trước cuối cùng cũng xuất hiện!!!!" },
    { id: 1, name: "Pokémon Đặc Biệt - Tập 59", price: "20.000 VNĐ", year: 2017, type: "Truyện tranh (Manga)", quantity: 300, image: "/src/assets/img/TruyenTranh-4.jpg", author: "Hidenori Kusaka, Satoshi Yamamoto", publisher: "Kim Đồng", description: "Trận chiến giành cây cổ thụ - Zeruneasu đã diễn ra! Dù dốc hết sức mình chiến đấu, Koruni vẫn thua trong gang tấc nên đành để cho “cây cổ thụ” và đá khai mở bị cướp đi!! Cảm thấy có lỗi trong việc Furadari bên phía kẻ thù đang dần chiếm được quyền lực! “Vũ khí tối thượng” - Di sản đen tối từ 3 ngàn năm trước cuối cùng cũng xuất hiện!!!!" },
]);
</script>

<template>
    <div class="bg-gray-200 font-sans w-full min-h-screen">
        <div class="flex gap-3">
            <sidebar />
            <div class="flex flex-col gap-5 w-full p-3 overflow-auto">
                <navbar />
                <div class="h-full bg-white rounded-xl">
                    <div class="text-center py-4 block lg:hidden">
                        <h2 class="font-bold text-blue-primary text-[18px]">DANH SÁCH NGƯỜI DÙNG</h2>
                    </div>
                    <div id="all_products" class="overflow-auto">
                        <table class="w-full border-collapse whitespace-nowrap text-center text-sm text-gray-500">
                            <thead class="">
                                <tr>
                                    <th scope="col" class="px-6 py-4 font-semibold text-gray-900">Mã khách hàng</th>
                                    <th scope="col" class="px-6 py-4 font-semibold text-gray-900">Tên khách hàng</th>
                                    <th scope="col" class="px-6 py-4 font-semibold text-gray-900">Số điện thoại</th>
                                    <th scope="col" class="px-6 py-4 font-semibold text-gray-900">Địa chỉ</th>
                                    <th scope="col" class="px-6 py-4 font-semibold text-gray-900">Ngày tham gia</th>
                                    <th scope="col" class="px-6 py-4 font-semibold text-gray-900">Điều chỉnh</th>
                                </tr>
                            </thead>
                            <tbody class="w-full">
                                <tr class="border-t border-slate-500" v-for="product in products" :key="product.id">
                                    <th class="px-6 py-4 font-medium text-gray-900">{{ product.id }}</th>
                                    <td class="px-6 py-4 whitespace-nowrap overflow-hidden text-ellipsis">{{
                                        product.name }}
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap overflow-hidden text-ellipsis">{{
                                        product.price
                                    }}</td>
                                    <td class="px-6 py-4 whitespace-nowrap overflow-hidden text-ellipsis">{{
                                        product.price
                                    }}</td>
                                    <td class="px-6 py-4 whitespace-nowrap overflow-hidden text-ellipsis">{{
                                        product.publisher }}</td>
                                    <td class="flex justify-center items-center gap-2 px-7 py-7 flex-col">
                                        <form @submit.prevent="deleteProduct(product.id)">
                                            <button type="submit"
                                                class="inline-block text-white font-medium bg-[#DC143C] py-2 px-4 mb-4 rounded-md transition-all duration-300 hover:bg-[#B22222] whitespace-nowrap">Xóa
                                                người dùng</button>
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
