import { createRouter, createWebHistory } from "vue-router";
import {ref} from "vue"
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

const routes = [
  {
    path: "/login",
    name: "Login",
    component: Login,
  },
  {
    path: "/addAdmin",
    name: "Add Admin",
    component: AddAdmin,
  },
  {
    path: "/staffList",
    name: "Staff List",
    component: StaffList
  },
  {
    path: "/",
    name: "Admin Dashboard",
    component: AdminDashboard,
  },
  {
    path: "/addProduct",
    name: "Add Product",
    component: AddProduct,
  },
  {
    path: "/editProduct",
    name: "Edit Product",
    component: EditProduct,
  },
  {
    path: "/entryForm",
    name: "Entry Form",
    component: EntryForm,
  },
  {
    path: "/editEntryForm",
    name: "Edit Entry Form",
    component: EditEntryForm,
  },
  {
    path: "/detailsEntryForm",
    name: "Details Entry Form",
    component: DetailsEntryForm,
  },
  {
    path: "/editDetailsEntryForm",
    name: "Edit Details Entry Form",
    component: EditDetailsEntryForm,
  },
  {
    path: "/billInfo",
    name: "Bill Info",
    component: BillInfo,
  },
  {
    path: "/detailsBillInfo",
    name: "Details Bill Info",
    component: DetailsBillInfo,
  },
  {
    path: "/customers",
    name: "Customers",
    component: Customers,
  },
  {
    path: "/editCustomer/:maKH",
    name: "Edit Customers",
    component: EditCustomers,
  },
  {
    path: "/suppliers",
    name: "Suppliers",
    component: Suppliers,
  },
  {
    path: "/editSuppliers/:maNCC",
    name: "Edit Suppliers",
    component: EditSuppliers,
  },
  {
    path: "/manufacturers",
    name: "Manufacturers",
    component: Manufacturers,
  },
  {
    path: "/editManufacturers/:maNSX",
    name: "Edit Manufacturers",
    component: EditManufacturers,
  },
  {
    path: "/typeDevice",
    name: "Type Devices",
    component: TypeDevice,
  },
  {
    path: "/editTypeDevice/:maLoaiThietBi",
    name: "Edit Type Devices",
    component: EditTypeDevice,
  }
];

const isLoading = ref(false);
const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes,
});

export default router;
