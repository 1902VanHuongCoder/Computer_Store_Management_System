<script setup>
import Loading from '../../FRONTEND/src/views/admin/loading.vue';
import { ref } from 'vue';
import { useRoute, useRouter } from 'vue-router';

const isLoading = ref(false); 
  
const router = useRouter();
const route = useRoute();

router.beforeEach((to, from, next) => {
  isLoading.value = true;
  setTimeout(() => {
    next();
  }, 1000);
});

router.afterEach(() => {
  isLoading.value = false;
});  
</script>

<template>
  <div id="app">
    <Loading :isLoading="isLoading" />
    <router-view></router-view>
  </div>
</template>

<style scoped></style>