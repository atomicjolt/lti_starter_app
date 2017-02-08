// import api      from '../libs/api';
// import { DONE } from '../constants/wrapper';

const ExternalTools = store => next => (action) => { // eslint-disable-line no-unused-vars
  // call the next middleWare
  next(action);
};

export { ExternalTools as default };
