/** @type {import('tailwindcss').Config} */
export default {
  content: ["./index.html", "./src/**/*.{vue,js,ts,jsx,tsx}"],
  theme: {
    extend: {
      colors: {
        blue: {
          primary: "#254E7A",
          secondary: "#5584B0",
          light: "#81C2E6",
          extraLight: "#CBE3EF",
        },
      },
      fontFamily: {
        sans: ["Poppins", "sans-serif"]
      },
    },
  },
  plugins: [],
};
