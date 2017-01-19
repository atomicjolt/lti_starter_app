// import api      from '../libs/api';
// import { DONE } from '../constants/wrapper';

const ExternalTools = store => next => (action) => {
  // call the next middleWare
  next(action);
};

export { ExternalTools as default };
