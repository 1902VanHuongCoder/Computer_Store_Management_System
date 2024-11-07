<script setup>
import { ref } from "vue";
import navbar from '@/components/navbar.vue';
import sidebar from '@/components/sidebar.vue';
</script>

<template>
    <div class="bg-gray-200 font-sans w-full min-h-screen">
        <div class="flex gap-3">
            <sidebar />
            <div class="flex flex-col gap-5 w-full p-3">
                <navbar />
                <div class="h-full overflow-hidden">
                    <div class="text-center py-4">
                        <h2 class="font-bold text-blue-primary text-[22px]">CHỈNH SỬA THIẾT BỊ</h2>
                    </div>
                    <form action="/admin/addproduct" method="POST" enctype="multipart/form-data" id="all_products"
                        class="w-full max-h-[calc(100vh-200px)] overflow-y-auto">
                        <div
                            class="flex flex-col bg-white w-full md:w-[70%] mx-auto gap-5 border-2 rounded-xl shadow-md p-5 m-2">
                            <div class="">
                                <div>
                                    <label for="idProduct"
                                        class="font-bold mb-1 block text-base text-gray-700 after:ml-0.5 after:text-red-500 after:content-['*']">Mã
                                        thiết bị</label>
                                    <input name="idProduct" autofocus type="text" id="idProduct"
                                        class="outline-none p-3 block w-full rounded-md border shadow-md focus:border-blue-secondary focus:ring focus:ring-blue-secondary focus:ring-opacity-50 disabled:cursor-not-allowed"
                                        placeholder="Nhập mã thiết bị ..." />
                                </div>
                            </div>
                            <div class="">
                                <div>
                                    <label for="name"
                                        class="font-bold mb-1 block text-base text-gray-700 after:ml-0.5 after:text-red-500 after:content-['*']">Tên
                                        thiết bị</label>
                                    <input name="name" autofocus type="text" id="name"
                                        class="outline-0 p-3 block w-full rounded-md border shadow-md focus:border-blue-secondary focus:ring focus:ring-blue-secondary focus:ring-opacity-50 disabled:cursor-not-allowed"
                                        placeholder="Nhập tên thiết bị ..." />
                                </div>
                            </div>
                            <div class="">
                                <div>
                                    <label for="priceIn"
                                        class="font-bold mb-1 block text-base text-gray-700 after:ml-0.5 after:text-red-500 after:content-['*']">Giá
                                        nhập</label>
                                    <input min="1" name="price" autofocus type="number" id="price"
                                        class="outline-0 p-3 block w-full rounded-md border shadow-md focus:border-blue-secondary focus:ring focus:ring-blue-secondary focus:ring-opacity-50 disabled:cursor-not-allowed"
                                        placeholder="10.000 VNĐ" />
                                </div>
                            </div>
                            <div class="">
                                <div>
                                    <label for="priceOut"
                                        class="font-bold mb-1 block text-base text-gray-700 after:ml-0.5 after:text-red-500 after:content-['*']">Giá thành</label>
                                    <input name="priceOut" autofocus type="text" id="priceOut"
                                        class="outline-0 p-3 block w-full rounded-md border shadow-md focus:border-blue-secondary focus:ring focus:ring-blue-secondary focus:ring-opacity-50 disabled:cursor-not-allowed"
                                        placeholder="10.000 VNĐ" />
                                </div>
                            </div>
                            <div class="">
                                <div>
                                    <label for="idNSX"
                                        class="font-bold mb-1 block text-base text-gray-700 after:ml-0.5 after:text-red-500 after:content-['*']">Mã nhà sản xuất</label>
                                    <input name="idNSX" autofocus type="text" id="idNSX"
                                        class="outline-0 p-3 block w-full rounded-md border shadow-md focus:border-blue-secondary focus:ring focus:ring-blue-secondary focus:ring-opacity-50 disabled:cursor-not-allowed"
                                        placeholder="Nhập mã NSX ..." />
                                </div>
                            </div>
                            <div class="">
                                <div>
                                    <label for="type"
                                        class="font-bold mb-1 block text-base text-gray-700 after:ml-0.5 after:text-red-500 after:content-['*']">Mã loại</label>
                                    <input name="type" autofocus type="text" id="type"
                                        class="outline-0 p-3 block w-full rounded-md border shadow-md focus:border-blue-secondary focus:ring focus:ring-blue-secondary focus:ring-opacity-50 disabled:cursor-not-allowed"
                                        placeholder="Nhập mã loại ..." />
                                </div>
                            </div>
                            <div class="">
                                <div>
                                    <label for="idSupplier"
                                        class="font-bold mb-1 block text-base text-gray-700 after:ml-0.5 after:text-red-500 after:content-['*']">Mã nhà cung cấp</label>
                                    <input name="idSupplier" autofocus type="text" id="idSupplier"
                                        class="outline-0 p-3 block w-full rounded-md border shadow-md focus:border-blue-secondary focus:ring focus:ring-blue-secondary focus:ring-opacity-50 disabled:cursor-not-allowed"
                                        placeholder="Nhập mã nhà cung cấp ..." />
                                </div>
                            </div>
                            <div class="">
                                <div>
                                    <label for="quantity"
                                        class="font-bold mb-1 block text-base text-gray-700 after:ml-0.5 after:text-red-500 after:content-['*']">Số
                                        lượng</label>
                                    <input min="1" name="quantity" autofocus type="number" id="color"
                                        class="outline-0 p-3 block w-full rounded-md border shadow-md focus:border-blue-secondary focus:ring focus:ring-blue-secondary focus:ring-opacity-50 disabled:cursor-not-allowed"
                                        placeholder="20" />
                                </div>
                            </div>
                            <div class="">
                                <div>
                                    <label for="5"
                                        class="font-bold mb-1 block text-base text-gray-700 after:ml-0.5 after:text-red-500 after:content-['*']">Thông số</label>
                                    <textarea id="description" name="description"
                                        class="outline-0 p-3 block w-full rounded-md border shadow-md focus:border-blue-secondary focus:ring focus:ring-blue-secondary focus:ring-opacity-50 disabled:cursor-not-allowed"
                                        rows="3" placeholder="Hãy thêm mô tả ..."></textarea>
                                </div>
                            </div>
                            <label
                                class="font-bold mb-1 block text-base text-gray-700 after:ml-0.5 after:text-red-500 after:content-['*']">Chọn
                                ảnh chính thiết bị :</label>
                            <input type="file" name="images[]" multiple class="font-bold">
                            <div class="text-center">
                                <button type="submit"
                                    class="inline-block rounded-lg bg-blue-primary px-6 py-3 text-sm font-bold text-[#fff] shadow-md hover:bg-blue-secondary hover:scale-110 transition-all duration-200">Chỉnh sửa
                                    Thiết bị</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</template>

<style></style>
