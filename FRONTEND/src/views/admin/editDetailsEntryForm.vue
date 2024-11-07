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
                                            <p class="text-lg">Cỉnh sửa chi tiết phiếu nhập</p>
                                            <p>Vui lòng điền thông tin đầy đủ.</p>
                                        </div>
                                        <div class="lg:col-span-2">
                                            <form action="/editprofile" method="post"
                                                class="grid gap-4 gap-y-3 text-sm grid-cols-1 md:grid-cols-5"
                                                enctype="multipart/form-data">
                                                <div class="md:col-span-5">
                                                    <label for="idProduct" class="font-semibold text-[16px]">Mã sản phẩm</label>
                                                    <input type="text" name="idProduct" id="idProduct"
                                                        class="h-10 border mt-1 rounded px-4 w-full bg-gray-50"
                                                        placeholder="Nhập mã sản phẩm ..." />
                                                </div>

                                                <div class="md:col-span-5">
                                                    <label for="idEntry" class="font-semibold text-[16px]">Mã phiếu
                                                        nhập</label>
                                                    <input type="text" name="idEntry" id="idEntry"
                                                        class="h-10 border mt-1 rounded px-4 w-full bg-gray-50"
                                                        placeholder="Nhập mã phiếu ..." />
                                                </div>

                                                <div class="md:col-span-5">
                                                    <label for="quantity" class="font-semibold text-[16px]">Số lượng</label>
                                                    <input type="number" name="quantity" id="quantity"
                                                        class="h-10 border mt-1 rounded px-4 w-full bg-gray-50"
                                                        placeholder="Nhập số lượng ..." />
                                                </div>

                                                <div class="md:col-span-5">
                                                    <label for="idEntry" class="font-semibold text-[16px]">Giá bán</label>
                                                    <input type="text" name="idEntry" id="idEntry"
                                                        class="h-10 border mt-1 rounded px-4 w-full bg-gray-50"
                                                        placeholder="1-xxx-xxx ..." />
                                                </div>

                                                <div class="md:col-span-5 text-right">
                                                    <div class="inline-flex items-end">
                                                        <button type="submit"
                                                            class="bg-[#333f48] hover:bg-blue-primary text-white font-bold py-2 px-4 rounded">Chỉnh sửa
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
                </div>
            </div>
        </div>
    </div>
</template>

<style></style>
