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
            <div class="flex flex-col gap-5 w-full p-3">
                <navbar />
                <div class="flex flex-col gap-4 w-full overflow-auto max-h-[calc(100vh-150px)]">
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
                                            <form action="/editprofile" method="post"
                                                class="grid gap-4 gap-y-3 text-sm grid-cols-1 md:grid-cols-5"
                                                enctype="multipart/form-data">
                                                <div class="md:col-span-5">
                                                    <label for="idEntry" class="font-semibold text-[16px]">Mã phiếu
                                                        nhập</label>
                                                    <input type="text" name="idEntry" id="idEntry"
                                                        class="h-10 border mt-1 rounded px-4 w-full bg-gray-50"
                                                        placeholder="Nhập mã phiếu ..." />
                                                </div>

                                                <div class="md:col-span-5">
                                                    <label for="idSupplier" class="font-semibold text-[16px]">Mã nhà
                                                        cung
                                                        cấp</label>
                                                    <input type="text" name="idSupplier" id="idSupplier"
                                                        class="h-10 border mt-1 rounded px-4 w-full bg-gray-50"
                                                        placeholder="Nhập mã nhà cung cấp ..." />
                                                </div>

                                                <div class="md:col-span-5">
                                                    <label for="idStaff" class="font-semibold text-[16px]">Mã nhân
                                                        viên</label>
                                                    <input type="text" name="idStaff" id="idStaff"
                                                        class="h-10 border mt-1 rounded px-4 w-full bg-gray-50"
                                                        placeholder="Nhập mã nhân viên ..." />
                                                </div>

                                                <div class="md:col-span-5">
                                                    <label for="totalPrice" class="font-semibold text-[16px]">Tổng số
                                                        tiền</label>
                                                    <input type="number" name="totalPrice" id="totalPrice"
                                                        class="h-10 border mt-1 rounded px-4 w-full bg-gray-50"
                                                        placeholder="Nhập tổng số tiền ..." />
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
                    <div class="flex justify-center flex-1 gap-4 max-w-xl">
                        <input type="text"
                            class="items-center w-full p-3 bg-white border-2 border-gray-400 text-[14px] font-semibold tracking-wider text-black rounded-lg focus:outline-none"
                            placeholder="Tìm kiếm phiếu nhập ..." />
                        <button
                            class="font-bold text-[14px] bg-blue-primary text-white px-4 py-2 rounded-lg whitespace-nowrap">
                            Tìm kiếm
                        </button>
                    </div>
                    <div class="h-full bg-white rounded-xl">
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
                                        <th scope="col" class="px-6 py-4 font-semibold text-gray-900">Tổng tiền</th>
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
                                            product.year }}
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap overflow-hidden text-ellipsis">{{
                                            product.type }}
                                        </td>
                                        <td class="flex justify-center items-center gap-2 px-7 py-7 flex-col">
                                            <a :href="`/edit/${product.id}`"
                                                class="inline-block bg-blue-primary text-white font-medium py-2 px-4 rounded-md transition-all duration-300 hover:bg-blue-secondary whitespace-nowrap">Sửa
                                                phiếu nhập</a>
                                            <form @submit.prevent="deleteProduct(product.id)">
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
                </div>
            </div>
        </div>
    </div>
</template>

<style></style>
