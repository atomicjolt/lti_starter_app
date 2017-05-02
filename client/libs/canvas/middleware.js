import _                           from 'lodash';
import api                         from '../api/api';
import { DONE }                    from '../constants/wrapper';
import { getNextUrl, parseParams } from '../urls';

const canvasProxyUrl = 'api/canvas';

function checkRequired(action) {
  if (action.canvas.required.length > 0) {
    const missing = _.difference(action.canvas.required, _.keys(action.params));
    if (missing.length > 0) {
      throw new Error(`Missing required parameter(s): ${missing.join(', ')}`);
    }
  }
}

export function proxyCanvas(store, action, params) {
  const state = store.getState();

  checkRequired(action);

  const promise = api.execRequest(
    action.canvas.method,
    canvasProxyUrl,
    state.settings.apiUrl,
    state.jwt,
    state.settings.csrfToken,
    {
      ...action.params,
      ...params,
      type: action.canvas.type,
      oauth_consumer_key: state.settings.oauthConsumerKey
    },
    action.body
  );

  if (promise) {
    promise.then((response, error) => {
      let lastPage = false;

      if (action.canvas.method === 'get' && response.header) {
        const nextUrl = getNextUrl(response.headers.link);
        if (nextUrl) {
          const newParams = parseParams(nextUrl);
          if (newParams) {
            proxyCanvas(store, action, newParams);
          }
        } else {
          lastPage = true;
        }
      }

      store.dispatch({
        type: action.canvas.type + DONE,
        payload: response.body,
        original: action,
        lastPage,
        response,
        error
      }); // Dispatch the new data
    });
  }

  return promise;
}

const CanvasApi = store => next => (action) => {
  if (action.canvas) {
    proxyCanvas(store, action, {});
  }

  // call the next middleWare
  next(action);
};

export { CanvasApi as default };
