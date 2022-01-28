const defaultTheme = require("tailwindcss/defaultTheme");

module.exports = {
    content: [
        "./vendor/laravel/framework/src/Illuminate/Pagination/resources/views/*.blade.php",
        "./storage/framework/views/*.php",
        "./resources/views/**/*.blade.php",
        "./resources/js/**/*.js",
    ],

    theme: {
        extend: {
            fontFamily: {
                sans: ["Spartan", ...defaultTheme.fontFamily.sans],
                serif: ["Spectral", ...defaultTheme.fontFamily.serif],
            },
            colors: {
                "primary": {
                    DEFAULT: "#1F3C88",
                    50: "#7D99E1",
                    100: "#6D8CDE",
                    200: "#4B72D6",
                    300: "#2E59CA",
                    400: "#274BA9",
                    500: "#1F3C88",
                    600: "#15285A",
                    700: "#0A142D",
                    800: "#000000",
                    900: "#000000",
                },
            },
        },
    },

    plugins: [
        require("@tailwindcss/forms"),
        require("tw-elements/dist/plugin")
    ],
};
