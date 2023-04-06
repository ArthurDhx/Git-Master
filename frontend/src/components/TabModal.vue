<template>
  <vue-final-modal
    v-slot="{ close }"
    v-bind="$attrs"
    classes="modal-container"
  >
    <div class="relative bg-white rounded-lg shadow dark:bg-gray-700">
      <div class="flex items-center justify-between p-5 border-b rounded-t dark:border-gray-600">
        <h3 class="text-xl font-medium text-gray-900 dark:text-white">
          Importation des emails
        </h3>
        <button
          type="button"
          class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 ml-auto inline-flex items-center dark:hover:bg-gray-600 dark:hover:text-white"
          @click="$emit('cancel', close)"
        >
          <svg
            aria-hidden="true"
            class="w-5 h-5"
            fill="currentColor"
            viewBox="0 0 20 20"
            xmlns="http://www.w3.org/2000/svg"
          ><path
            fill-rule="evenodd"
            d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
            clip-rule="evenodd"
          /></svg>
          <span class="sr-only">X</span>
        </button>
      </div>
      <div class="space-y-6">
        <div class="relative">
          <table class="w-full text-sm text-left text-gray-500">
            <thead class="text-xs uppercase text-gray-700 bg-gray-50">
              <tr>
                <th
                  scope="col"
                  class="py-3 px-6"
                >
                  Email
                </th>
                <th
                  scope="col"
                  class="py-3 px-6"
                >
                  Résultat
                </th>
              </tr>
            </thead>
            <tbody>
              <tr
                v-for="email in listeEmails"
                :key="email"
                class="bg-white border-b"
              >
                <th
                  scope="row"
                  class="py-4 px-6 font-medium text-gray-900 whitespace-nowrap"
                >
                  {{ email.label }}
                </th>
                <td class="py-4 px-6">
                  {{ email.result }}
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
      <div class="flex items-center p-6 space-x-2 border-t border-gray-200 rounded-b dark:border-gray-600">
        <button
          type="button"
          class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800"
          @click="$emit('cancel', close)"
        >
          Quitter
        </button>
      </div>
    </div>
  </vue-final-modal>
</template>

<script>
export default {
    name: 'TabModal',
    inheritAttrs: false,
    emits: ['cancel'],
    data() {
        return {
            listeEmails: [
                { label: 'aaa@aa.fr', result: 'ok'},
                { label: 'bbb@aa.fr', result: 'ok'},
                { label: 'ccc@aa.fr', result: 'pas ok'},
                { label: 'ddd@aa.fr', result: 'pas ok '},
                { label: 'ddd@aa.fr', result: 'pas ok '},
                { label: 'ddd@aa.fr', result: 'pas ok '}
            ]
        };
    }
};
</script>


<style scoped>
::v-deep(.modal-container) {
  display: flex;
  justify-content: center;
  align-items: center;
  min-width:30%
}
::v-deep(.modal-content) {
  position: relative;
  display: flex;
  flex-direction: column;
  max-height: 90%;
  margin: 0 1rem;
  padding: 1rem;
  border: 1px solid #e2e8f0;
  border-radius: 0.25rem;
  background: #fff;
}
.modal__title {
  margin: 0 2rem 0 0;
  font-size: 1.5rem;
  font-weight: 700;
}
.modal__content {
  flex-grow: 1;
  overflow-y: auto;
}
.modal__action {
  display: flex;
  justify-content: center;
  align-items: center;
  flex-shrink: 0;
  padding: 1rem 0 0;
}
.modal__close {
  position: absolute;
  top: 0.5rem;
  right: 0.5rem;
}

.dark-mode div ::v-deep(.modal-content) {
  border-color: #2d3748;
  background-color: #1a202c;
}
</style>
