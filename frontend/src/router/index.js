import { createRouter, createWebHistory } from "vue-router";

import store from "../store";
import LoginView from "../views/LoginView.vue";
import MainView from "../views/MainView.vue";
import UserFormView from "../views/UserFormView.vue";
import AdminView from "../views/AdminView.vue";
import UserForm from "../views/UserFormView.vue";
import StudentsListView from "../views/StudentsListView.vue";
import StudentProfilView from "../views/StudentProfilView.vue";
import RepositoriesListView from "../views/RepositoriesListView";
import RepositoryFormView from "../views/RepositoryFormView";
import PupilGroupsView from "../views/PupilGroupsView.vue";
import PupilGroupFormView from "../views/PupilGroupFormView.vue";
import RepositoryProfil from "../views/RepositoryProfil.vue";
import GroupFormView from "../views/GroupFormView.vue";
import YearFormView from "../views/YearFormView.vue";
import RoleFormView from "../views/RoleFormView.vue";

const routes = [
    {
        path: "/",
        component: MainView,
        meta: { requiresAuth: true },
        children: [
            {
                path: "/home",
                name: "RepositoriesList",
                alias: "/",
                component: RepositoriesListView
            }
        ]
    },
    {
        title: "Login",
        path: "/login",
        name: "login",
        meta: { requiresAuth: false },
        component: LoginView
    },
    {
        path: "/admin",
        component: MainView,
        meta: { requiresAuth: true },
        children: [
            {
                title: "User Form",
                path: "/user/create",
                name: "UserCreation",
                component: UserFormView
            },
            {
                title: "User Form",
                path: "/user/:id/edit",
                name: "UserEdition",
                component: UserForm
            },
            {
                title: "Admin Tab",
                path: "/admin",
                name: "AdminView",
                component: AdminView
            },
            {
                title: "Group Form",
                path: "/group/create",
                name: "GroupCreation",
                component: GroupFormView
            },
            {
                title: "Group Form",
                path: "/group/:id/edit",
                name: "GroupEdition",
                component: GroupFormView
            },
            {
                title: "Year Form",
                path: "/year/create",
                name: "YearCreation",
                component: YearFormView
            },
            {
                title: "Year Form",
                path: "/year/:id/edit",
                name: "YearEdition",
                component: YearFormView
            },
            {
                title: "Role Form",
                path: "/role/:id/edit",
                name: "RoleEdition",
                component: RoleFormView
            },
            {
                title: "Role Form",
                path: "/role/create",
                name: "RoleCreation",
                component: RoleFormView
            }
        ]
    },
    {
        path: "/repository",
        component: MainView,
        meta: { requiresAuth: true },
        children: [
            {
                title: "Repo Group Form",
                path: "/repository/create",
                name: "RepoGroupCreation",
                component: RepositoryFormView
            },
            {
                title: "Repo Group Profil",
                path: "/repository/:id",
                name: "RepositoryProfil",
                component: RepositoryProfil
            }
        ]
    },
    {
        path: "/student",
        component: MainView,
        meta: { requiresAuth: true },
        children: [
            {
                title: "Student Form",
                path: "/student/create",
                name: "StudentCreation",
                meta: { requiresAuth: true },
                component: StudentProfilView
            },
            {
                title: "Student Edit Form",
                path: "/student/:id/edit",
                name: "StudentEdition",
                meta: { requiresAuth: true },
                component: StudentProfilView
            }
        ]
    },
    {
        path: "/students",
        component: MainView,
        meta: { requiresAuth: true },
        children: [
            {
                path: "/students",
                name: "StudentsList",
                alias: "StudentsList",
                component: StudentsListView
            }
        ]
    },
    {
        path: "/pupilgroups",
        component: MainView,
        meta: { requiresAuth: true },
        children: [
            {
                path: "/pupilgroups",
                name: "PupilGroups",
                alias: "PupilGroups",
                component: PupilGroupsView
            },
            {
                title: "PupilGroup Edit Form",
                path: "/pupilgroup/:id/edit",
                name: "PupilGroupEdition",
                meta: { requiresAuth: true },
                component: PupilGroupFormView
            }
        ]
    },
    {
        path: "/pupilgroup",
        component: MainView,
        meta: { requiresAuth: true },
        children: [
            {
                title: "PupilGroup Form",
                path: "/pupilgroup/create",
                name: "PupilGroupCreation",
                meta: { requiresAuth: true },
                component: PupilGroupFormView
            }
        ]
    }
];

const router = createRouter({
    history: createWebHistory(),
    routes,
    linkActiveClass: "bg-gray-700 text-white"
});

// Navigation Guard
router.beforeEach(async (to, from, next) => {
    if (!store.getters["user/getUserStateLoaded"])
        await store.dispatch("user/initLogin");

    if (to.meta.requiresAuth && !store.getters["user/getIsLogged"])
        return next({ name: "login" });
    else if (!to.meta.requiresAuth && store.getters["user/getIsLogged"])
        return next({ name: "RepositoriesList" });

    if (to.meta.requiresAdmin && !store.getters["user/isUserAdmin"])
        return next({ name: "RepositoriesList" });

    next();
});

export default router;
