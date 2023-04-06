module.exports = {
    root: true,
    env: {
        node: true,
        'vue/setup-compiler-macros': true
    },
    parser: 'vue-eslint-parser',
    extends: [
        'eslint:recommended',
        'plugin:vue/vue3-recommended'
    ],
    "rules": {
        "semi": ["error", "always"],
        "comma-spacing": "warn",
        "eqeqeq": "error",
        "indent": "warn",
        "no-unreachable": "error",
        "key-spacing": "warn",
        "max-statements": ["warn", 30],
        "prefer-const": "warn",
        "no-eval": "error",
        "eol-last": "warn",
        "no-throw-literal": "error",
        "require-jsdoc": "warn",
        "comma-dangle": "error",
        "no-constant-condition": "error",
        "keyword-spacing": "warn",
        "no-path-concat": "error",
        "no-var": "error",
        "vue/no-mutating-props": "off",
        "vue/multi-word-component-names": "off"
    }
};
