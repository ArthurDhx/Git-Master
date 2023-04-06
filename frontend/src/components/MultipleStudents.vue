<template>
  <h2 class="col-span-4 sm:col-span-4 font-bold text-gray-900 sm:text-xl mt-4">
    Ajout de plusieurs étudiants
  </h2>

  <div class="col-span-4 sm:col-span-4">
    <label
      for="group-number"
      class="block text-gray-700 text-sm font-medium mb-2 required_field"
    >Nombre d'étudiants par groupe</label>
    <input
      id="group-number"
      v-model="form.groupNumber"
      type="number"
      name="group-number"
      required
      placeholder="2"
      class="border border-gray-400 rounded w-full py-2 px-3 text-gray-700 text-sm leading-tight focus:outline-none focus:border-purple-300"
      @change="onChange"
    >
  </div>

  <div
    v-if="(form.groupNumber!= null && form.groupNumber > 0 && selectedStudents.length > 0)"
    class="col-span-4 sm:col-span-3"
  >
    <div
      v-for="(n, i) in (Math.ceil(selectedStudents.length / $parent.form.groupNumber))"
      :key="i"
      class="col-span-4 sm:col-span-2"
    >
      <label
        for="studentsGroup"
        class="block text-gray-700 text-sm font-medium mb-2 required_field"
      >Groupe {{ (i) }} - ( {{ getStudentNumber(i) }} étudiants )</label>
      <Multiselect
        v-model="form.studentsGroup[i]"
        :options="studentsList"
        object
        mode="tags"
        placeholder="Choisir des étudiants"
        :close-on-select="false"
        :searchable="true"
        class="multiselect border border-gray-400 text-gray-700 text-sm focus:outline-none focus:border-purple-300"
        @select="onSelect"
        @deselect="onDeselect"
        @clear="clear(i)"
      />
    </div>
  </div>
</template>

<script>
import Multiselect from '@vueform/multiselect';
export default {
    name: 'MultipleStudentsComponent',
    components: {
        Multiselect
    },
    props: {
        selectedStudents: {
            type: Array,
            required: true
        },
        form: {
            type: Object,
            required: true
        }
    },
    data () {
        return {
            studentsList: []
        };
    },
    watch: {
        selectedStudents: {
            immediate: true,
            handler (val) {
                // getStudentsList from selected pupilsGroup and filter duplicates
                this.studentsList = (val.map((row) => { return { value: row.id, label: row.firstname + " " + row.lastname, email: row.email};}))
                    .filter((student, i, array) => array.findIndex(student2 => (student2.value === student.value)) === i);

                this.form.studentsGroup.map(subArray => subArray.splice(0));
            }
        }
    },
    methods: {
        onSelect(student) {
            this.studentsList.splice(this.studentsList.findIndex((i) => {
                return i.value === student.value;
            }), 1);
        },
        onDeselect(student) {
            this.studentsList.push(student);
        },
        onChange() {
            this.studentsList = (this.selectedStudents.map((row) => { return { value: row.id, label: row.firstname + " " + row.lastname, email: row.email};}))
                .filter((student, i, array) => array.findIndex(student2 => (student2.value === student.value)) === i);

            this.form.studentsGroup.map(subArray => subArray.splice(0));
        },
        clear(i) {
            this.form.studentsGroup[i].forEach(student => {
                this.studentsList.push(student);
            });
        },
        getStudentNumber(group_no) {
            if (group_no + 1 === Math.ceil(this.selectedStudents.length / this.$parent.form.groupNumber)) {
                return this.selectedStudents.length - (this.$parent.form.groupNumber * group_no);
            } else {
                return this.$parent.form.groupNumber;
            }
        }
    }
};
</script>
