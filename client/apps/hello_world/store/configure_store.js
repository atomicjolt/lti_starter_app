import configureStore from 'atomic-fuel/libs/store/configure_store';
import CanvasApi from 'atomic-canvas/libs/middleware';
import rootReducer from '../reducers/index';
import API from '../middleware/api';

const middleware = [API, CanvasApi];

// This file just exports the default configure store. If modifications are needed
// make the modifications in this file by extending the configureStore
// or copy pasting the code into this file.
export default function(initialState) {
  return configureStore(initialState, rootReducer, middleware);
}
