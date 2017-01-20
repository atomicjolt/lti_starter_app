import api      from '../libs/api';
import { DONE } from '../constants/wrapper';

const API = store => next => (action) => {
  function request(method, url, params, body, headers, timeout) {
    const state = store.getState();
    const updatedParams = {
      // Add consumer key to requests to indicate which lti app requests are originating from
      oauth_consumer_key: state.settings.oauth_consumer_key,
      ...params
    };
    const promise = api.execRequest(
      method,
      url,
      state.settings.api_url,
      state.jwt,
      state.settings.csrf_token,
      updatedParams,
      body,
      headers,
      timeout);

    if (promise) {
      promise.then(
        (response) => {
          store.dispatch({
            type     : action.type + DONE,
            payload  : response.body,
            original : action,
            response,
          }); // Dispatch the new data
        },
        (error) => {
          store.dispatch({
            type     : action.type + DONE,
            payload  : {},
            original : action,
            error,
          }); // Dispatch the new error
        },
      );
    }
  }

  if (action.method) {
    request(action.method, action.url, action.params, action.body, action.headers, action.timeout);
  }

  // call the next middleWare
  next(action);
};

export { API as default };
