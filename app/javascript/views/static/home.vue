<template>
  <div id="home">
    <div class="flex flex-col p-2 py-6 m-h-screen">
      <div class="bg-white items-center justify-between w-full flex rounded-full shadow-lg p-2 mb-5 sticky" style="top: 5px">
        <div>
          <div class="p-2 mr-1 rounded-full hover:bg-gray-100 cursor-pointer">
            <svg class="h-6 w-6 text-gray-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M9.707 16.707a1 1 0 01-1.414 0l-6-6a1 1 0 010-1.414l6-6a1 1 0 011.414 1.414L5.414 9H17a1 1 0 110 2H5.414l4.293 4.293a1 1 0 010 1.414z" clip-rule="evenodd" />
            </svg>
          </div>
        </div>
        <input class="font-semibold uppercase rounded-full w-full py-4 pl-4 text-gray-700 bg-gray-100 leading-tight focus:outline-none focus:shadow-outline lg:text-sm text-xs" type="text" placeholder="Try searching for Repository" v-debounce:300ms="search" v-model="query">
        <div class="bg-gray-600 p-2 hover:bg-blue-400 cursor-pointer mx-2 rounded-full">
          <svg class="w-6 h-6 text-white" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
            <path fill-rule="evenodd" d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z" clip-rule="evenodd" />
          </svg>
        </div>
      </div>
      <div v-if="repositories.length > 0" class="flex flex-col gap-4 lg:p-4 p-2  rounde-lg m-2">
        <div v-for="respository in repositories" class="flex items-center justify-between w-full p-2 lg:rounded-full md:rounded-full hover:bg-gray-100 cursor-pointer border-2 rounded-lg">
          <div class="lg:flex md:flex items-center">
            <div class="h-12 w-12 mb-2 lg:mb-0 border md:mb-0 rounded-full mr-3"></div>
            <div class="flex flex-col">
              <div class="text-sm leading-3 text-gray-700 font-bold w-full">{{respository.full_name}}</div>
              <!-- <div class="text-xs text-gray-600 w-full">Av. veteranos del 93, Parque ecuador, Concepcion.</div> -->
            </div>
          </div>
        </div>
      </div>

      <nav aria-label="Page navigation example">
        <ul class="inline-flex -space-x-px">
          <li>
            <a v-if="current != 1" @click="current--" class="py-2 px-3 ml-0 leading-tight text-gray-500 bg-white rounded-l-lg border border-gray-300 hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white">Previous</a>
          </li>
          <li>
            <a v-for="current in paginate_total" @click.prevent="updateCurrent(current + 1)" class="py-2 px-3 leading-tight text-gray-500 bg-white border border-gray-300 hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white cursor-pointer">{{ current + 1 }}</a>
          </li>
          <li>
            <a  @click="current++" v-if="current < paginate_total" class="py-2 px-3 leading-tight text-gray-500 bg-white rounded-r-lg border border-gray-300 hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white">Next</a>
          </li>
        </ul>
      </nav>  
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "home",

  data () {
    return {
      repositories : [],
      query: "",
      current: 1,
      paginate: 50,
      paginate_total: 0,
      total_count: 0,
      per_page: 25,
      sort_by: "desc",
      loading: false
    }
  },
  methods:{
    
    search(query) {
      this.query = query
      this.page = 1
      this.repositories = []
      this.getRepositories();
    },

    created() {
      this.paginate_total = this.repositories.length/this.paginate;
    },

    setPaginate: function (i) {
       if (this.current == 1) {
         return i < this.paginate;
       }
       else {
         return (i >= (this.paginate * (this.current - 1)) && i < (this.current * this.paginate));
       }
     },
    
     updateCurrent: function (i) {
       this.current = i;

       this.getRepositories();
     },
     updatePaginate: function () {
       this.current = 1;
       this.paginate_total = Math.ceil(document.querySelectorAll('tbody tr').length/this.paginate);
     },

    getRepositories(){
      this.loading = true
      axios.get("http://localhost:3000/search", { params: { q: this.query, page: this.current, sort_by: this.sort_by, per_page: this.per_page}}).then(response => {
        this.repositories = response.data.repositories;
        this.paginate_total = response.data.total_pages;
        this.loading = false;
      }).catch(e => {
       console.log(e);
      });
    }  
  },
};
</script>

<style>
  .page-link {
    display: inline-block;
  }
  .page-link {
      font-size: 20px;
      color: #29b3ed;
      font-weight: 500;
  }
  .offset{
    width: 500px !important;
    margin: 20px auto;  
  }
</style>
