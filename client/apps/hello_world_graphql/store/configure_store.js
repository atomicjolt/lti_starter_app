import { createStore } from 'redux';
import rootReducer from '../reducers/index';

// This file just exports the default configure store. If modifications are needed
// make the modifications in this file by extending the configureStore
// or copy pasting the code into this file.
export default function(initialState) {
  return createStore(rootReducer, initialState);
}
