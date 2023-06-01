// Originally copied from https://github.com/kentcdodds/eslint-config-kentcdodds

/**
 * @see https://github.com/eslint/eslint/issues/3458
 * @see https://www.npmjs.com/package/@rushstack/eslint-patch
 */
require('@rushstack/eslint-patch/modern-module-resolution')

/* eslint-disable sort-keys */
module.exports = {
  env: {
    browser: true,
    es6: true,
    node: true,
  },
  plugins: ['prettier'],
  extends: [
    'prettier',
    './rules/import.js',
    './rules/typescript.js',
    './rules/jest.js',
    './rules/react.js',
    './rules/jsx-a11y.js',
    './rules/base.js',
  ],
  rules: {},
  overrides: [],
}
