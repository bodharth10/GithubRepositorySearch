import Vue from "vue/dist/vue.esm";
import DashboardIndex from "../../views/dashboard/index.vue";

document.addEventListener("DOMContentLoaded", () => {
  const app = new Vue({
    el: "#vue",
    components: { DashboardIndex },
  });
});
