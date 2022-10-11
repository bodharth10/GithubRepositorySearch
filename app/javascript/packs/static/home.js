import Vue from 'vue/dist/vue.esm'
import axios from 'axios';
import vueDebounce from 'vue-debounce';
Vue.use(vueDebounce);
import Home from '../../views/static/home.vue'
document.addEventListener('DOMContentLoaded', () => {
    const app = new Vue({
        el: '#vue',
        components: { Home }
    })
})