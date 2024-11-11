import { createRouter, createWebHistory } from "vue-router";
import { ref } from "vue";
import Login from "../views/auth/Login.vue";
import AddAdmin from "../views/auth/Register.vue";
import AdminDashboard from "../views/admin/adminDashboard.vue";
import AddProduct from "../views/admin/addProduct.vue";
import EditProduct from "../views/admin/editProduct.vue";
import EntryForm from "../views/admin/EntryForm.vue";
import EditEntryForm from "../views/admin/editEntryForm.vue";
import DetailsEntryForm from "../views/admin/detailsEntryForm.vue";
import EditDetailsEntryForm from "../views/admin/editDetailsEntryForm.vue";
import BillInfo from "../views/admin/billInfo.vue";
import DetailsBillInfo from "../views/admin/detailsBillInfo.vue";
import Customers from "../views/admin/customers.vue";
import Suppliers from "../views/admin/suppliers.vue";
import EditSuppliers from "../views/admin/editSuppliers.vue";
import Manufacturers from "../views/admin/manufacturers.vue";
import EditManufacturers from "../views/admin/editManufacturers.vue";
import TypeDevice from "../views/admin/typeDevice.vue";
import EditTypeDevice from "../views/admin/editTypeDevice.vue";
import EditCustomers from "../views/admin/editCustomers.vue";
import StaffList from "../views/admin/staffList.vue";
import EditStaffInfo from "@/views/admin/editStaffInfo.vue";
import EditBillInfo from "../views/admin/editBillInfo.vue";
import EditDetailsBillInfo from "../views/admin/editDetailsBillInfo.vue";

const routes = [
  {
    path: "/login",
    name: "Login",
    component: Login,
    meta: { requiresAuth: true },
  },
  {
    path: "/addAdmin",
    name: "Add Admin",
    component: AddAdmin,
    meta: { requiresAuth: true },
  },
  {
    path: "/staffList",
    name: "Staff List",
    component: StaffList,
    meta: { requiresAuth: true },
  },
  {
    path: "/editStaff/:maNV",
    name: "Edit Staff List",
    component: EditStaffInfo,
    meta: { requiresAuth: true },
  },
  {
    path: "/",
    name: "Admin Dashboard",
    component: AdminDashboard,
    meta: { requiresAuth: true },
  },
  {
    path: "/addProduct",
    name: "Add Product",
    component: AddProduct,
    meta: { requiresAuth: true },
  },
  {
    path: "/editProduct/:maTB",
    name: "Edit Product",
    component: EditProduct,
    meta: { requiresAuth: true },
  },
  {
    path: "/entryForm",
    name: "Entry Form",
    component: EntryForm,
    meta: { requiresAuth: true },
  },
  {
    path: "/editEntryForm/:maPN",
    name: "Edit Entry Form",
    component: EditEntryForm,
    meta: { requiresAuth: true },
  },
  {
    path: "/detailsEntryForm",
    name: "Details Entry Form",
    component: DetailsEntryForm,
    meta: { requiresAuth: true },
  },
  {
    path: "/editDetailsEntryForm/:maPN/:maThietBi",
    name: "Edit Details Entry Form",
    component: EditDetailsEntryForm,
    meta: { requiresAuth: true },
  },
  {
    path: "/billInfo",
    name: "Bill Info",
    component: BillInfo,
    meta: { requiresAuth: true },
  },
  {
    path: "/editBillInfo/:maPX",
    name: "Edit Bill Info",
    component: EditBillInfo,
    meta: { requiresAuth: true },
  },
  {
    path: "/detailsBillInfo",
    name: "Details Bill Info",
    component: DetailsBillInfo,
    meta: { requiresAuth: true },
  },
  {
    path: "/ediDetailsBillInfo/:maPX/:maThietBi",
    name: "Edit Detail Bill Info",
    component: EditDetailsBillInfo,
    meta: { requiresAuth: true },
  },
  {
    path: "/customers",
    name: "Customers",
    component: Customers,
    meta: { requiresAuth: true },
  },
  {
    path: "/editCustomer/:maKH",
    name: "Edit Customers",
    component: EditCustomers,
    meta: { requiresAuth: true },
  },
  {
    path: "/suppliers",
    name: "Suppliers",
    component: Suppliers,
    meta: { requiresAuth: true },
  },
  {
    path: "/editSuppliers/:maNCC",
    name: "Edit Suppliers",
    component: EditSuppliers,
    meta: { requiresAuth: true },
  },
  {
    path: "/manufacturers",
    name: "Manufacturers",
    component: Manufacturers,
    meta: { requiresAuth: true },
  },
  {
    path: "/editManufacturers/:maNSX",
    name: "Edit Manufacturers",
    component: EditManufacturers,
    meta: { requiresAuth: true },
  },
  {
    path: "/typeDevice",
    name: "Type Devices",
    component: TypeDevice,
    meta: { requiresAuth: true },
  },
  {
    path: "/editTypeDevice/:maLoaiThietBi",
    name: "Edit Type Devices",
    component: EditTypeDevice,
    meta: { requiresAuth: true },
  },
];

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes,
});

const isLoading = ref(false);
router.beforeEach((to, from, next) => {
  isLoading.value = true;
  
  // Kiểm tra xem route có yêu cầu xác thực không
  if (to.matched.some(record => record.meta.requiresAuth)) {
    const chucVu = localStorage.getItem('chucVu');

    // Kiểm tra trạng thái đăng nhập
    if (!chucVu && to.path !== '/login') {
      next({ path: '/login' }); // Chuyển hướng đến trang đăng nhập
    } else if (chucVu && to.path === '/login') {
      // Nếu đã đăng nhập nhưng cố truy cập trang đăng nhập, chuyển hướng về trang chủ
      next({ path: '/' });
    } else {
      next(); // Nếu đã đăng nhập và không truy cập trang đăng nhập, cho phép truy cập
    }
  } else {
    next(); // Nếu route không yêu cầu xác thực, cho phép truy cập
  }

  setTimeout(() => {
    isLoading.value = false;
  }, 1000);
});

export { router, isLoading };
export default router;
