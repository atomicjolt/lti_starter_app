// Copied from https://github.com/remind101/jest-transform-graphql
// and updated for Jest 28 compatibility
const loader = require('graphql-tag/loader');

module.exports = {
  process(src) {
    // call directly the webpack loader with a mocked context
    // as graphql-tag/loader leverages `this.cacheable()`
    return {
      code: loader.call({ cacheable() {} }, src)
    };
  },
};
