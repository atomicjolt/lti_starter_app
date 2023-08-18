import 'core-js';
import 'regenerator-runtime/runtime';
import es6Promise from 'es6-promise';
import React from 'react';
import ReactDOM from 'react-dom';
import PropTypes from 'prop-types';
import { Provider } from 'react-redux';
import { BrowserRouter as Router, Route } from 'react-router-dom';
import { getInitialSettings } from 'atomic-fuel/libs/reducers/settings';
import jwt from 'atomic-fuel/libs/loaders/jwt';
import { ltiLaunch } from '@atomicjolt/lti-client/src/client/launch';

import configureStore from './store/configure_store';
import Index from './components/layout/index';
import initResizeHandler from '../../common/libs/resize_iframe';

import './styles/styles.scss';

// Polyfill es6 promises for IE
es6Promise.polyfill();

class Root extends React.PureComponent {
  render() {
    const { store } = this.props;
    return (
      <Provider store={store}>
        <Router>
          <div>
            <Route path="/" exact component={Index} />
          </div>
        </Router>
      </Provider>
    );
  }
}

Root.propTypes = {
  store: PropTypes.object.isRequired,
};

const settings = getInitialSettings(window.DEFAULT_SETTINGS);
const store = configureStore({ settings, jwt: window.DEFAULT_JWT });
if (window.DEFAULT_JWT) { // Setup JWT refresh
  jwt(store.dispatch, settings.user_id);
}

const mainApp =  document.getElementById('main-app');
initResizeHandler(mainApp);

ltiLaunch(window.DEFAULT_SETTINGS).then((valid) => {
  if (valid) {
    ReactDOM.render(
      <Root store={store} />,
      mainApp,
    );
  } else {
    document.body.innerHTML = 'Invalid request. Please reload the page.';
  }
});
