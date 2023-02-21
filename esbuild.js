const {sassPlugin } = require("esbuild-sass-plugin");

/* handle dev vs production settings */
const env = "development";
const is_prod = (env==="production");

require("esbuild").build({
    entryPoints: ["app/javascript/application.js"],
    outdir: "app/assets/builds",
    publicPath: "/assets",
    assetNames: "[name]-[hash].digested",
    bundle: true,
    minify: is_prod,
    sourcemap: !is_prod,
    watch: ('--watch' === process.argv[2]),
    target: "es6",
    loader: {".js": "jsx",
	     ".png": "file"},
    plugins: [sassPlugin()]
})
    .then(() => console.log("Done"))
    .catch(() => process.exit(1));
