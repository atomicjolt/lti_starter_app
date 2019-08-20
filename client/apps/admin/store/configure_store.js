import { createStore, applyMiddleware, compose } from 'redux';
import API                                       from 'atomic-fuel/libs/middleware/api';
import CanvasApi                                 from 'atomic-canvas/libs/middleware';
import rootReducer                               from '../reducers';

const middleware = [API, CanvasApi];

const enhancers = [
  applyMiddleware(...middleware)
];

export default function(initialState) {
  const store = compose(...enhancers)(createStore)(rootReducer, initialState);
  return store;
}
