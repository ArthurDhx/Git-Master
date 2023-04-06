<template>
  <vue-awesome-paginate
    v-if="data.totalItems > data.itemsPerPage"
    v-model="data.currentPage"
    :total-items="data.totalItems"
    :items-per-page="data.itemsPerPage"
    :max-pages-shown="data.maxPagesShown"
    :show-breakpoint-buttons="true"
    :show-ending-buttons="true"
    :hide-prev-next-when-ends="true"
    :first-page-content="'<<'"
    :last-page-content="'>>'"
  >
    <template #prev-button>
      <i class="fa-sharp fa-solid fa-chevron-left" />            
    </template>
    <template #next-button>
      <i class="fa-sharp fa-solid fa-chevron-right" />            
    </template>
    <template #first-page-button>
      <i class="fa-solid fa-backward-step" />
    </template>
    <template #last-page-button>
      <i class="fa-solid fa-forward-step" />
    </template>
  </vue-awesome-paginate>
</template>

<script>
export default {
    name: 'PaginationComponent',
    props: {
        data: {
            type: Object,
            required: true
        }
    }
};
</script>

<style>
  .pagination-container {
    display: flex;
    column-gap: 4px;
  }
  .paginate-buttons {
    height: 36px;
    width: 36px;
    border-radius: 8px;
    cursor: pointer;
    background-color: #ffffff;
    border: 1px solid #d9d9d9;
    color: black;
  }
  .paginate-buttons:hover {
    opacity: 0.75;
  }
  .active-page {
    background-color: #1f2937;
    color: white;
  }
  .active-page:hover {
    background-color: #374151;
  }
</style>
