import api from '../api/api';
import { DONE } from '../constants/wrapper';

export function apiRequest(store, action) {
  const state = store.getState();
  const updatedParams = {
    // Add the context id from the lti launch
    context_id: state.settings.context_id,
    // Add consumer key to requests to indicate which lti app requests are originating from.
    oauth_consumer_key: state.settings.oauth_consumer_key,
    ...action.params
  };
  const promise = api.execRequest(
    action.method,
    action.url,
    state.settings.api_url,
    state.jwt,
    state.settings.csrf_token,
    updatedParams,
    action.body,
    action.headers,
    action.timeout);

  if (promise) {
    promise.then(
      (response) => {
        store.dispatch({
          type: action.type + DONE,
          payload: response.body,
          original: action,
          response,
        }); // Dispatch the new data
      },
      (error) => {
        store.dispatch({
          type: action.type + DONE,
          payload: {},
          original: action,
          error,
        }); // Dispatch the new error
      },
    );
  }

  return promise;
}

const API = store => next => (action) => {

  if (action.method) {
    apiRequest(store, action);
  }

  // call the next middleWare
  next(action);
};

export { API as default };
