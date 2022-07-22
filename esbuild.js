const esbuild = require('esbuild');
const { sassPlugin } = require('esbuild-sass-plugin');

const [env, ...entryPoints] = process.argv.slice(2);

const baseConfig = {
  entryPoints,
  bundle: true,
  outdir: 'app/assets/builds',
  publicPath: 'assets',
  assetNames: '[name]-[hash].digested',
  logLevel: 'info',
  plugins: [
    sassPlugin(),
  ],
  loader: {
    '.js': 'jsx',
    '.png': 'file',
    '.woff': 'file',
    '.woff2': 'file',
    '.eot': 'file',
    '.ttf': 'file',
    '.svg': 'file',
    '.jpg': 'file',
    '.lazy.json': 'file',
  },

};

if (env === 'dev') {
  esbuild.build({
    ...baseConfig,
    sourcemap: 'inline',
    watch: true,
  });
} else {
  esbuild.build({
    ...baseConfig,
    sourcemap: 'external',
    minify: true
  });
}
