<script setup>
import { ref } from "vue";
import navbar from '@/components/navbar.vue';
import sidebar from '@/components/sidebar.vue';

</script>

<template>
    <div class="bg-gray-200 font-sans w-full min-h-screen">
        <div class="flex gap-3">
            <sidebar />
            <div class="flex flex-col gap-5 w-full p-3 overflow-auto">
                <navbar />
                <div class="bg-white rounded-xl">
                    <div class="text-center py-4 block lg:hidden">
                        <h2 class="font-bold text-blue-primary text-[18px]">DANH SÁCH NHÂN VIÊN</h2>
                    </div>
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
                                <tr class="border-t border-slate-500">
                                    <th class="px-6 py-4 font-medium text-gray-900"></th>
                                    <td class="px-6 py-4 whitespace-nowrap overflow-hidden text-ellipsis">
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap overflow-hidden text-ellipsis"></td>
                                    <td class="px-6 py-4 whitespace-nowrap overflow-hidden text-ellipsis"></td>
                                    <td class="px-6 py-4 whitespace-nowrap overflow-hidden text-ellipsis"></td>
                                    <td class="flex justify-center items-center gap-2 px-7 py-7 flex-col">
                                        <a :href="`/edit/`"
                                            class="inline-block bg-blue-primary text-white font-medium py-2 px-4 rounded-md transition-all duration-300 hover:bg-blue-secondary whitespace-nowrap">Sửa
                                            sản phẩm</a>
                                        <form @submit.prevent="">
                                            <button type="submit"
                                                class="inline-block text-white font-medium bg-[#DC143C] py-2 px-4 mb-4 rounded-md transition-all duration-300 hover:bg-[#B22222] whitespace-nowrap">Xóa
                                                sản phẩm</button>
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
