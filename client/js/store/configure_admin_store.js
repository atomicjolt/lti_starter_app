import { createStore, applyMiddleware, compose } from 'redux';
import { persistState }                          from 'redux-devtools';
import rootReducer                               from '../reducers';
import DevTools                                  from '../dev/dev_tools';
import API                                       from '../middleware/api';
import CanvasApi                                 from '../libs/canvas/middleware';
import ExternalTool                              from '../middleware/external_tools';

const middleware = [API, CanvasApi, ExternalTool];

let enhancers = [
  applyMiddleware(...middleware)
];

// In production, we want to use just the middleware.
// In development, we want to use some store enhancers from redux-devtools.
// UglifyJS will eliminate the dead code depending on the build environment.
if (__DEV__) {
  enhancers = [
    ...enhancers,
    DevTools.instrument(),
    persistState(window.location.href.match(/[?&]debug_session=([^&]+)\b/))
  ];
}

export default function (initialState) {
  const store = compose(...enhancers)(createStore)(rootReducer, initialState);

  if (__DEV__ && module.hot) {
    module.hot.accept(
      '../reducers',
      () => store.replaceReducer(rootReducer)
    );
  }

  return store;
}
