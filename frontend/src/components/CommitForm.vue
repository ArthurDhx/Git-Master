<template>
  <h2 class="col-span-4 sm:col-span-4 font-bold text-gray-900 sm:text-xl mt-4">
    Ajout d'un commit
  </h2>

  <div class="col-span-4 sm:col-span-4">
    <label
      for="commit-message"
      class="block text-gray-700 text-sm font-medium mb-2 required_field"
    >Message du commit</label>
    <input
      id="commit-message"
      v-model="form.commitMessage"
      type="text"
      name="commit-message"
      placeholder="Init project"
      class="border border-gray-400 rounded w-full py-2 px-3 text-gray-700 text-sm leading-tight focus:outline-none focus:border-purple-300"
    >
  </div>

  <div class="col-span-4 sm:col-span-3">
    <p class="block text-gray-700 text-sm font-medium mb-2">
      Liste des fichiers choisis ({{ form.selectedFiles.length }})
    </p>
    <ul>
      <li class="italic text-gray-700 text-sm font-medium mb-2">
        Pour modifier l'arboresence du fichier, modifier le path du fichier
      </li>
      <li class="italic text-gray-700 text-sm font-medium mb-2">
        Exemple : /files/init/sujet.pdf au lieu de sujet.pdf
      </li>
      <li
        v-for="(file, i) in form.selectedFilesPath"
        :key="file.id"
        class="text-gray-700 text-sm font-medium mb-2"
      >
        <div class="flex">
          <input
            v-model="form.selectedFilesPath[i]"
            type="text"
            class="border border-gray-400 rounded w-full py-2 px-3 text-gray-700 text-sm leading-tight focus:outline-none focus:border-purple-300"
          >
          <i
            class="fa-solid fa-trash bg-red-400 hover:bg-red-500 text-white font-bold py-1 px-2 text-xs rounded hover:cursor-pointer ml-1 h-6 mt-2"
            @click="removeFile(i)"
          />
        </div>
      </li>
    </ul>
  </div>

  <div class="col-span-4 sm:col-span-1">
    <label
      for="file-upload"
      class="p-2 relative cursor-pointer rounded-md font-medium text-purple-600 focus-within:outline-none focus-within:ring-2 focus-within:ring-purple-500 focus-within:ring-offset-2 hover:text-purple-500"
    >
      <span>Ajouter un fichier</span>
      <input
        id="file-upload"
        name="file-upload"
        type="file"
        class="sr-only"
        @change="saveFile"
      >
    </label>
  </div>
</template>

<script>
export default {
    name: 'CommitFormComponent',
    props: {
        form: {
            type: Object,
            required: true
        }
    },
    methods: {
        saveFile(event) {
            const file = event.target.files[0];
            const existingFile = this.form.selectedFiles.find((f) => f.name === file.name && f.lastModified === file.lastModified);

            if (file && !existingFile && !this.form.selectedFiles.includes(file)) {
                this.form.selectedFiles.push(file);
                this.form.selectedFilesPath.push(file.name);
            }

            event.target.value = "";
        },
        removeFile(index) {
            this.form.selectedFiles.splice(index, 1);
            this.form.selectedFilesPath.splice(index, 1);
        }
    }
};
</script>
