import 'babel-polyfill';
import es6Promise from 'es6-promise';
import React from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';
import jwt from 'atomic-fuel/libs/loaders/jwt';
import { getInitialSettings } from 'atomic-fuel/libs/reducers/settings';
import PropTypes from 'prop-types';
import ReactModal from 'react-modal';
import routes from './routes';
import configureStore from './store/configure_store';


import './styles/styles.scss';

// Polyfill es6 promises for IE
es6Promise.polyfill();

class Root extends React.PureComponent {
  static propTypes = {
    store: PropTypes.object.isRequired,
  };

  render() {
    const { store } = this.props;
    return (
      <Provider store={store}>
        <div>
          {routes}
        </div>
      </Provider>
    );
  }
}

const settings = getInitialSettings(window.DEFAULT_SETTINGS);
const store = configureStore({ settings, jwt: window.DEFAULT_JWT });
if (window.DEFAULT_JWT) { // Setup JWT refresh
  jwt(store.dispatch, settings.user_id);
}

ReactModal.setAppElement('#main-app');

ReactDOM.render(
  <Root store={store} />,
  document.getElementById('main-app'),
);
